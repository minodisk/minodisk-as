package net.minodisk.util {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/26
	 */
	public class MovieClipUtil {
		
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
		// PUBLIC METHODS
		//--------------------------------------
		
		public static function gotoFinalFrameAndStop(mc:MovieClip):void {
			var i:int, child:MovieClip;
			
			mc.gotoAndStop(mc.totalFrames);
			i = mc.numChildren;
			while (i--) {
				child = mc.getChildAt(i) as MovieClip;
				if (child) {
					gotoFinalFrameAndStop(child);
				}
			}
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
