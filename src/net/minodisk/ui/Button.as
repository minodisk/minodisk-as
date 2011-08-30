package net.minodisk.ui {
  import flash.display.MovieClip;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import net.minodisk.events.ButtonEvent;
	
  [Event(name='select', type='flash.events.Event')]
  [Event(name='press', type='net.minodisk.events.ButtonEvent')]
  
	public class Button extends Component {
		
		static protected const OUT:String = 'out';
		static protected const OVER:String = 'over';
		static protected const DOWN:String = 'down';
    static protected const SELECT:String = 'select';
		static protected const DISABLE:String = 'disable';
		
    // display objects
		public var hit:MovieClip;
		public var out:MovieClip;
		public var over:MovieClip;
		public var down:MovieClip;
    public var select:MovieClip;
		public var disable:MovieClip;
		protected var _buttons:Object;
    
    // properties
    protected var _autoSelect:Boolean;
		protected var _startDelay:Number;
		protected var _endDelay:Number;
		protected var _decreaseRate:Number;
		protected var _timer:Timer;
    
    // status flags
		protected var _status:String;
    protected var _enabled:Boolean;
    protected var _selected:Boolean;
		protected var _down:Boolean;
		protected var _over:Boolean;
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void {
			_enabled = value;
      if (!_enabled) {
        _timer.stop();
      }
			_update();
		}
    
    public function get autoSelect():Boolean {
      return _autoSelect;
    }
    
    public function set autoSelect(value:Boolean):void {
      _autoSelect = value;
      if (_autoSelect) {
        addEventListener(MouseEvent.CLICK, _onClick);
      } else {
        selected = false;
        removeEventListener(MouseEvent.CLICK, _onClick);
      }
    }
    
    public function get selected():Boolean {
      return _selected;
    }
    
    public function set selected(value:Boolean):void {
      if (_selected !== value) {
        _selected = value;
        _update();
        if (_selected) {
          dispatchEvent(new Event(Event.SELECT, false, false));
        }
      }
    }
    
    public function get startDelay():Number {
      return _startDelay;
    }
    
    public function set startDelay(value:Number):void {
      _startDelay = value;
      _timer.delay = _startDelay;
    }
    
    public function get endDelay():Number {
      return _endDelay;
    }
    
    public function set endDelay(value:Number):void {
      _endDelay = value;
    }
    
    public function get decreaseRate():Number {
      return _decreaseRate;
    }
    
    public function set decreaseRate(value:Number):void {
      _decreaseRate = value;
    }
		
		public function Button() {
			super();
			_over = false;
			_down = false;
			_buttons = {
				out: out,
				over: over,
				down: down,
        select: select,
				disable: disable
			};
			for (var prop:String in _buttons) {
				if (_buttons[prop]) {
					_buttons[prop].visible = false;
				}
			}
			
			mouseChildren = false;
			buttonMode = true;
			tabEnabled = false;
      if (hit) {
				hitArea = hit;
				hit.alpha = 0;
			}
      
      _startDelay = 200;
      _endDelay = 30;
      _decreaseRate = .85;
			_timer = new Timer(_startDelay);
			_timer.addEventListener(TimerEvent.TIMER, _onTimer);
      
			addEventListener(MouseEvent.ROLL_OUT, _onRollOut);
			addEventListener(MouseEvent.ROLL_OVER, _onRollOver);
			addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
      
      autoSelect = false;
			_enabled = true;
      _status = OUT;
      if (out) {
        out.visible = true;
      }
		}
		
		protected function _onRollOut(e:MouseEvent):void {
			_over = false;
			_update();
		}
		
		protected function _onRollOver(e:MouseEvent):void {
			_over = true;
			_update();
		}
		
    private var _stage:Stage;
    
		protected function _onMouseDown(e:MouseEvent):void {
      _stage = stage;
			_stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
			_down = true;
			_update();
      
			_timer.reset();
			_timer.delay = _startDelay;
			_timer.start();
			dispatchEvent(new ButtonEvent(ButtonEvent.PRESS, false, false));
		}
		
		private function _onTimer(e:TimerEvent):void {
			var delay:Number = _timer.delay * _decreaseRate;
			_timer.delay = (delay < _endDelay) ? _endDelay : delay;
			dispatchEvent(new ButtonEvent(ButtonEvent.PRESS, false, false));
		}
		
		protected function _onStageMouseUp(e:MouseEvent):void {
			_stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
      _stage = null;
			_timer.stop();
			_down = false;
			_update();
		}
    
    private function _onClick(e:MouseEvent):void {
      if (!_selected) {
        selected = !selected;
      }
    }
		
		private function _update():void {
      var newStatus:String = (!_enabled) ? DISABLE : (_selected) ? SELECT : (_down) ? DOWN : (_over) ? OVER : OUT;
			mouseEnabled = _enabled && !_selected;
      if (newStatus !== _status) {
        _updateTo(newStatus);
      }
			_status = newStatus;
		}
    
    protected function _updateTo(newStatus:String):void {
      if (_buttons[newStatus]) {
				_buttons[_status].visible = false;
				_buttons[newStatus].visible = true;
			}
    }
		
	}
}