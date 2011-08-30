package net.minodisk.events {
  import flash.events.Event;
  import flash.events.MouseEvent;
	
	public class ButtonEvent extends MouseEvent {
		
		static public const PRESS:String = 'press';
		
		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
      localX:Number = 0, localY:Number = 0) {
			super(type, bubbles, cancelable, localX, localY);
		}
		
		public override function clone():Event {
			return new ButtonEvent(type, bubbles, cancelable, localX, localY);
		}
		
		public override function toString():String {
			return formatToString('PressEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'localX', 'localY');
		}
		
	}
}