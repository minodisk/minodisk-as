package net.minodisk.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 10.0
	 * @author dsk
	 * @since 2010/10/25
	 */
	public class Mask extends Sprite
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function Mask() 
		{
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
			
			parent.mask = this;
		}
		
		
	}
	
	
}
