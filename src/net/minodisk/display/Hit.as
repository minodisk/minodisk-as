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
	public class Hit extends Sprite
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _rectangle:Rectangle;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get rectangle():Rectangle
		{
			if (!_rectangle && parent)
			{
				_rectangle = getRect(parent);
			}
			return _rectangle;
		}
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function Hit() 
		{
			super();
			
			alpha = 0;
			
			if (stage)
			{
				_onAddedToStage();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			}
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _onAddedToStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			_rectangle = getRect(parent);
			(parent as Sprite).mouseChildren = false;
			(parent as Sprite).hitArea = this;
		}
		
		
	}
	
	
}
