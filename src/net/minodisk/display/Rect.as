package net.minodisk.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2010/11/04
	 */
	public class Rect extends Sprite {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _rectangle:Rectangle;
		private var _index:int;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get rectangle():Rectangle { return _rectangle; }
		
		public function get index():int { return _index; }
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function Rect() {
			super();
			
			visible = false;
			
			if (stage) {
				_onAddedToStage();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			}
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _onAddedToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			_rectangle = getRect(parent);
			_index = parent.getChildIndex(this);
			
			parent.removeChild(this);
		}
		
		
	}
	
	
}
