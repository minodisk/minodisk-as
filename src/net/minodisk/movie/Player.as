package net.minodisk.movie {
  import flash.events.AsyncErrorEvent;
  import flash.events.EventDispatcher;
  import flash.events.NetStatusEvent;
  import flash.events.TimerEvent;
  import flash.media.SoundTransform;
  import flash.media.Video;
  import flash.net.NetConnection;
  import flash.net.NetStream;
  import flash.utils.setTimeout;
  import flash.utils.Timer;
  import net.minodisk.events.CueEvent;
  import net.minodisk.events.PlayerEvent;
  import net.minodisk.events.PlayerTimeEvent;
  import net.minodisk.movie.Cue;
  import net.minodisk.util.MathUtil;
  
  [Event(name='ready', type='net.minodisk.events.PlayerEvent')]
  [Event(name='statusChange', type='net.minodisk.events.PlayerEvent')]
  [Event(name='loadProgress', type='net.minodisk.events.PlayerEvent')]
  [Event(name='seekStart', type='net.minodisk.events.PlayerEvent')]
  [Event(name='seekComplete', type='net.minodisk.events.PlayerEvent')]
  [Event(name='updateTime', type='net.minodisk.events.PlayerTimeEvent')]
  [Event(name='cue', type='net.minodisk.events.CueEvent')]
	
  public class Player extends EventDispatcher {
    
    static public const PLAY:String = 'play';
    static public const PAUSE:String = 'pause';
    static public const STOP:String = 'stop';
    static public const END:String = 'end';
    
    private var _status:String;
    private var _ready:Boolean;
    private var _continuous:Boolean;
    private var _buffering:Boolean;
    private var _isPlayStop:Boolean;
    private var _connection:NetConnection;
    private var _loadedTimer:Timer;
    private var _timeTimer:Timer;
    private var _stream:NetStream;
    private var _url:String;
    private var _video:Video;
    private var _width:Number;
    private var _height:Number;
    private var _duration:Number;
    private var _seekPoints:Array;
    private var _cueLayers:Object;
    private var _currentCues:Object;
    private var _volume:Number;
    private var _internalVolume:Number;
    private var _pan:Number;
    
    public function get status():String {
      return _status;
    }
    
    public function get url():String {
      return _url;
    }
    
    public function get video():Video {
      return _video;
    }
    
    public function get duration():Number {
      return _duration;
    }
    
    public function get time():Number {
      return (_status === STOP || _stream === null) ? 0 : _stream.time;
    }
    
    public function get bytesLoaded():Number {
      return (_stream) ? _stream.bytesLoaded : 0;
    }
    
    public function get bytesTotal():Number {
      return (_stream) ? _stream.bytesTotal : 0;
    }
    
    public function get volume():Number {
      return _volume;
    }
    
    public function set volume(value:Number):void {
      _volume = value;
      _updateSoundTransform();
    }
    
    protected function get internalVolume():Number {
      return _internalVolume;
    }
    
    protected function set internalVolume(value:Number):void {
      _internalVolume = value;
      _updateSoundTransform();
    }
    
    public function get pan():Number {
      return _pan;
    }
    
    public function set pan(value:Number):void {
      _pan = value;
      _updateSoundTransform();
    }
    
    private function _updateSoundTransform():void {
      if (_stream) {
        _stream.soundTransform = new SoundTransform(_volume * _internalVolume, _pan);
      }
    }
    
    public function Player() {
      super();
      
      _status = STOP;
      _ready = false;
      _continuous = false;
      _buffering = false;
      _isPlayStop = false;
      _volume = 0;
      _internalVolume = 0;
      _pan = 0;
      _connection = new NetConnection();
      _loadedTimer = new Timer(33);
      _loadedTimer.addEventListener(TimerEvent.TIMER, _updateLoaded);
      _timeTimer = new Timer(33);
      _timeTimer.addEventListener(TimerEvent.TIMER, _updateTime);
    }
    
    public function load(url:String):void {
      _timeTimer.start();
      
      if (url !== _url) {
        _ready = false;
        _url = url;
        _width = 0;
        _height = 0;
        _duration = 0;
        _cueLayers = { };
        _currentCues = { };
        if (_stream) {
          _stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, trace);
          _stream.removeEventListener(NetStatusEvent.NET_STATUS, _netStatus);
          _stream.close();
          _stream.client = null;
          _stream = null;
        }
        if (_video) {
          _video.clear();
          _video.attachNetStream(null);
          _video = null;
        }
        if (!_connection.connected) {
          _connection.addEventListener(NetStatusEvent.NET_STATUS, _connectionNetStatus);
          _connection.connect(null);
        } else {
          _playStream();
        }
      }
    }
    
    private function _connectionNetStatus(e:NetStatusEvent):void {
      if (e.info.code === 'NetConnection.Connect.Success') {
        _connection.removeEventListener(NetStatusEvent.NET_STATUS, _connectionNetStatus);
        _playStream();
      }
    }
    
    private function _playStream():void {
      if (!_stream) {
        _stream = new NetStream(_connection);
        _stream.client = {
          onMetaData: _onMetaData
        };
        _updateSoundTransform();
        _stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, trace);
        _stream.addEventListener(NetStatusEvent.NET_STATUS, _netStatus);
      }
      _loadedTimer.start();
      _setStatus(STOP);
      _stream.play(_url);
    }
    
    public function _onMetaData(info:Object):void {
      /*trace('----- onMetaData');
      for (var key:String in info) {
        trace('', key, ':', info[key]);
      }*/
      
      if (info.width) {
        _width = Number(info.width);
      }
      if (info.height) {
        _height = Number(info.height);
      }
      if (info.duration) {
        _duration = Number(info.duration);
      }
      if (info.seekpoints) {
        _seekPoints = [];
        var i:int = info.seekpoints.length;
        while (i--) {
          _seekPoints.push(Number(info.seekpoints[i].time));
        }
        _seekPoints.sort(Array.NUMERIC);
        
        var cueList:Array;
        for (var layer:String in _cueLayers) {
          cueList = _cueLayers[layer];
          i = cueList.length;
          while (i--) {
            _adjustToNearestSeekPoint(cueList[i]);
          }
        }
      }
      if (!_ready && _width > 0 && _height > 0 && _duration > 0 && _seekPoints) {
        _ready = true;
        _video = new Video(_width, _height);
        _video.attachNetStream(_stream);
        _seek(0); // Sometimes video isn't rendered without this process.
        dispatchEvent(new PlayerEvent(PlayerEvent.READY, false, false));
      }
    }
    
    
    public function play():void {
      _setStatus(PLAY);
      _isPlayStop = false; // Calling `stop(); play();` continuously, status will be `END`. Because `play()` is called before the notification of `stop()` seek.
      _timeTimer.start();
      
      _stream.resume();
    }
    
    public function pause():void {
      _setStatus(PAUSE);
      _timeTimer.stop();
      
      _stream.pause();
    }
    
    public function stop():void {
      _setStatus(STOP);
      _timeTimer.stop();
      
      _video.clear();
      _stream.pause();
      _seek(0);
    }
    
    public function seekTo(ratio:Number, continuous:Boolean = false):void {
      if (_duration) {
        seek(_duration * ratio, continuous);
      }
    }
    
    public function seek(time:Number, continuous:Boolean = false):void {
      if (status !== PLAY) {
        _setStatus(PAUSE);
      }
      _seek(time, continuous);
    }
    
    private function _seek(time:Number, continuous:Boolean = false):void {
      internalVolume = 0;
      _continuous = continuous;
      _timeTimer.stop();
      _stream.resume();
      _stream.seek(time);
    }
    
    public function addCue(cue:Cue, layer:String = 'default'):void {
      if (!(layer in _cueLayers)) {
        _cueLayers[layer] = [];
      }
      
      _adjustToNearestSeekPoint(cue);
      
      var cueList:Array = _cueLayers[layer];
      cueList.push(cue);
      cueList.sort(function (a:Cue, b:Cue):Number {
        return a.time - b.time;
      });
    }
    
    private function _adjustToNearestSeekPoint(cue:Cue):void {
      if (_seekPoints) {
        cue.time = MathUtil.nearest(cue.time, _seekPoints);
      }
    }
    
    private function _updateLoaded(e:TimerEvent):void {
      dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_PROGRESS, false, false));
      if (_stream.bytesLoaded >= _stream.bytesTotal) {
        _loadedTimer.stop();
      }
    }
    
    private function _setStatus(value:String):void {
      _status = value;
      dispatchEvent(new PlayerEvent(PlayerEvent.STATUS_CHANGE, false, false));
    }
    
    private function _netStatus(e:NetStatusEvent):void {
      if (e.info.code !== 'NetStream.Buffer.Flush') trace(e.info.code);
      
      if (e.info.code.indexOf('NetStream.Buffer') !== 0) { // Sometimes `NetStream.Buffer.*` is notified after `NetStream.Play.Stop`.
        _isPlayStop = e.info.code === 'NetStream.Play.Stop';
      }
      switch (e.info.code) {
        case 'NetStream.Seek.Notify':
          _buffering = true;
          if (_status !== STOP) {
            dispatchEvent(new PlayerEvent(PlayerEvent.SEEK_START, false, false));
          }
          setTimeout(_updateTime, 0);
          break;
        case 'NetStream.Buffer.Full':
          _buffering = false;
          if (_status !== STOP) {
            dispatchEvent(new PlayerEvent(PlayerEvent.SEEK_COMPLETE, false, false));
          }
          setTimeout(_updateTime, 0);
          if (_continuous) {
            _stream.pause();
          } else {
            internalVolume = 1;
            switch (_status) {
              case PLAY:
                play();
                break;
              case PAUSE:
                pause();
                break;
              case STOP:
                _timeTimer.stop();
                _stream.pause();
                _stream.seek(0);
                break;
            }
          }
          break;
      }
    }
    
    private function _updateTime(e:TimerEvent = null):void {
      var cueList:Array, currentCue:Cue, i:int, cue:Cue;
      for (var layer:String in _cueLayers) {
        cueList = _cueLayers[layer];
        currentCue = _currentCues[layer];
        i = cueList.length;
        while (i--) {
          cue = cueList[i];
          if (cue.time <= time) {
            if (cue !== currentCue) {
              _currentCues[layer] = cue;
              dispatchEvent(new CueEvent(CueEvent.CUE, false, false, cue, layer));
            }
            break;
          }
        }
      }
      
      dispatchEvent(new PlayerTimeEvent(PlayerTimeEvent.UPDATE_TIME, false, false, !_continuous, _ready && (!_buffering  || _status === STOP)));
      
      if (_isPlayStop && duration && time >= duration) {
        _timeTimer.stop();
        _setStatus(END);
      }
    }
    
  }
}