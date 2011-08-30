package net.minodisk.ui {
  import events.PressEvent;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
	
	public class PressButton extends Button {
		
		private var _startDelay:Number;
		private var _endDelay:Number;
		private var _decreaseRate:Number;
		
		private var _timer:Timer;
		
		public function get startDelay():Number { return _startDelay; }
		
		public function set startDelay(value:Number):void {
			_startDelay = value;
			if (!_timer.running) {
				_timer.delay = _startDelay;
			}
		}
		
		public function get endDelay():Number { return _endDelay; }
		
		public function set endDelay(value:Number):void {
			_endDelay = value;
		}
		
		public function get decreaseRate():Number { return _decreaseRate; }
		
		public function set decreaseRate(value:Number):void {
			_decreaseRate = value;
		}
		
		public function PressButton(startDelay:Number = 200, endDelay:Number = 30, decreaseRate:Number = .85) {
			super();
			_startDelay = startDelay;
			_endDelay = endDelay;
			_decreaseRate = decreaseRate;
			_timer = new Timer(_startDelay);
			_timer.addEventListener(TimerEvent.TIMER, _onTimer);
		}
		
		override protected function _onMouseDown(e:MouseEvent):void {
			super._onMouseDown(e);
			_dispatch();
			_timer.reset();
			_timer.delay = _startDelay;
			_timer.start();
		}
		
		override protected function _onStageMouseUp(e:MouseEvent):void {
      super._onStageMouseUp(e);
			_timer.stop();
		}
		
		private function _onTimer(e:TimerEvent = null):void {
			var delay:Number = _timer.delay * _decreaseRate;
			_timer.delay = (delay < _endDelay) ? _endDelay : delay;
			_dispatch();
		}
		
		private function _dispatch():void {
			dispatchEvent(new PressEvent(PressEvent.PRESS, false, false));
		}
		
	}
}