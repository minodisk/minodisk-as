package net.minodisk.util {
	import flash.display.DisplayObjectContainer;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/22
	 */
	public class DisplayObjectUtil {
		
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
		
		public static function removeChildren(context:DisplayObjectContainer, ...children:Array):void {
			var i:int, len:int;
			
			for (i = 0, len = children.length; i < len; i++) {
				context.removeChild(children[i]);
			}
		}
		
		public static function removeAllChildren(context:DisplayObjectContainer):void {
			
			while (context.numChildren) {
				context.removeChildAt(0);
			}
		}
		
		public static function getChildren(context:DisplayObjectContainer):Array {
			var children:Array, i:int, len:int;
			
			children = [];
			for (i = 0, len = context.numChildren; i < len; i++) {
				children[i] = context.getChildAt(i);
			}
			
			return children;
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
