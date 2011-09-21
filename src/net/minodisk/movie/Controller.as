package net.minodisk.movie {
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import net.minodisk.events.PlayerEvent;
  import net.minodisk.events.PlayerTimeEvent;
  import net.minodisk.events.SliderEvent;
  import net.minodisk.ui.Slider;
  import net.minodisk.util.MathUtil;
  import net.minodisk.util.StringUtil;
	
  public class Controller extends Sprite {
    
    public var playButton:Sprite;
    public var pauseButton:Sprite;
    public var stopButton:Sprite;
    public var seekSlider:Slider;
    public var volumeSlider:Slider;
    public var timeTextField:TextField;
    
    protected var _player:Player;
    
    public function get volume():Number {
      return _player.volume;
    }
    
    public function set volume(value:Number):void {
      _player.volume = value;
      volumeSlider.position = value;
    }
    
    public function Controller() {
      super();
      
      seekSlider.position = 0;
      seekSlider.buffer.scaleX = 0;
      seekSlider.loaded.scaleX = 0;
      timeTextField.mouseEnabled = false;
      timeTextField.text = '00:00/00:00';
      
      playButton.addEventListener(MouseEvent.CLICK, _play);
      pauseButton.addEventListener(MouseEvent.CLICK, _pause);
      stopButton.addEventListener(MouseEvent.CLICK, _stop);
      seekSlider.addEventListener(SliderEvent.CHANGING, _seekChanging);
      seekSlider.addEventListener(SliderEvent.CHANGED, _seekChanged);
      volumeSlider.addEventListener(SliderEvent.CHANGE, _volumeChang);
    }
    
    public function connect(player:Player):void {
      _player = player;
      _player.addEventListener(PlayerEvent.STATUS_CHANGE, _statusChange);
      _player.addEventListener(PlayerEvent.LOAD_PROGRESS, _loadProgress);
      _player.addEventListener(PlayerTimeEvent.UPDATE_TIME, _updateTime);
    }
    
    public function disconnect(player:Player):void {
      _player.removeEventListener(PlayerEvent.STATUS_CHANGE, _statusChange);
      _player.removeEventListener(PlayerEvent.LOAD_PROGRESS, _loadProgress);
      _player.removeEventListener(PlayerTimeEvent.UPDATE_TIME, _updateTime);
      _player = null;
    }
    
    
    // control from script
    
    public function seek(time:Number, continuous:Boolean = false):void {
      _player.seek(time, continuous);
      seekSlider.position = time / _player.duration;
    }
    
    public function play():void {
      _player.play();
    }
    
    public function pause():void {
      _player.pause();
    }
    
    public function stop():void {
      _player.stop();
    }
    
    
    // ui event handlers
    
    private function _play(e:MouseEvent):void {
      if (_player.status !== Player.END) {
        play();
      } else {
        stop();
        play();
      }
    }
    
    private function _pause(e:MouseEvent):void {
      pause();
    }
    
    private function _stop(e:MouseEvent):void {
      stop();
    }
    
    private function _seekChanging(e:SliderEvent):void {
      _player.seekTo(e.position, true);
    }
    
    private function _seekChanged(e:SliderEvent):void {
      _player.seekTo(e.position, false);
    }
    
    private function _volumeChang(e:SliderEvent):void {
      _player.volume = e.position;
    }
    
    
    // player event handlers
    
    private function _statusChange(e:PlayerEvent):void {
      var isPlaying:Boolean = (_player.status === Player.PLAY);
      playButton.visible = !isPlaying;
      pauseButton.visible = isPlaying;
    }
    
    private function _loadProgress(e:PlayerEvent):void {
      seekSlider.loaded.scaleX = MathUtil.convergeBetween(_player.bytesLoaded / _player.bytesTotal, 0, 1);
    }
    
    private function _updateTime(e:PlayerTimeEvent):void {
      timeTextField.text = _toTimeString(_player.time) +  '/' + _toTimeString(_player.duration);
      if (e.isHead) {
        seekSlider.position = _player.time / _player.duration;
      }
      if (e.isBuffer) {
        seekSlider.buffer.scaleX = MathUtil.convergeBetween(_player.time / _player.duration, 0, 1);
      }
    }
    
    
    // utilities
    
    protected function _toTimeString(sec:Number):String {
      var s:int = sec % 60 >> 0;
      var m:int = sec / 60 >> 0;
      var h:int = m / 60 >> 0;
      m %= 60;
      var str:String = StringUtil.padLeft(m, 2, '0') + ':' + StringUtil.padLeft(s, 2, '0');
      return (h !== 0) ? StringUtil.padLeft(h, 2, '0') + ':' + str : str;
    }
    
  }
}