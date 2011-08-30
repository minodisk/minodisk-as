package net.minodisk.ui {
  import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CheckBox extends SimpleButton {
		
		public var check:MovieClip;
		
		private var _selected:Boolean;
		
		public function get selected():Boolean { return _selected; }
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			
			check.visible = _selected;
		}
		
		public function CheckBox() 
		{
			super();
			
			hitArea = out;
			selected = false;
			
			addEventListener(MouseEvent.CLICK, _onClick);
		}
		
		private function _onClick(e:MouseEvent):void 
		{
			selected = !selected;
			dispatchEvent(new Event(Event.CHANGE, false, false));
			if (selected)
			{
				dispatchEvent(new Event(Event.SELECT, false, false));
			}
		}
		
	}
}