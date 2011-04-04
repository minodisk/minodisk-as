package net.minodisk.display 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2010/11/04
	 */
	public class ProgressCircle extends Sprite
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _circle:Shape;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function ProgressCircle() 
		{
			super();
			
			_circle = new Shape();
			var g:Graphics = _circle.graphics;
			for (var i:int = 0, angle:Number; i < 12; i ++)
			{
				angle = Math.PI * 2 * i / 12;
				g.beginFill(0x96a3aa, 0.4 + 0.4 * i / 12);
				g.drawCircle(10 * Math.cos(angle), 10 * Math.sin(angle), 2);
				g.endFill();
			}
			
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _onAddedToStage(e:Event):void 
		{
			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		private function _onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		private function _onEnterFrame(e:Event):void 
		{
			_circle.rotation += 30;
		}
		
		
	}
	
	
}
