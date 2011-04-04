package net.minodisk.ui 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2010/11/09
	 */
	public class CheckBox extends Button
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------
		
		public var check:MovieClip;
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _selected:Boolean;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get selected():Boolean { return _selected; }
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			
			check.visible = _selected;
		}
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function CheckBox() 
		{
			super();
			
			hitArea = out;
			selected = false;
			
			addEventListener(MouseEvent.CLICK, _onClick);
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		private function _onClick(e:MouseEvent):void 
		{
			selected = !selected;
			dispatchEvent(new Event(Event.CHANGE, false, false));
			if (selected)
			{
				dispatchEvent(new Event(Event.SELECT, false, false));
			}
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
