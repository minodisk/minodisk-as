package net.minodisk.util {
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/22
	 */
	public class ArrayUtil {
		
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
		
		public static function shuffle(array:Array, destructive:Boolean = false):Array {
			var i:int, j:int, value:Object;
			
			if (!destructive) {
				array = array.concat();
			}
			i = array.length;
			while (i) {
				j = Math.random() * i >> 0;
				value = array[--i];
				array[i] = array[j];
				array[j] = value;
			}
			
			return array;
		}
		
		//TODO indexOfでポインタ以前にあるかを調べる方法との実行速度比較
		public static function unique(array:Array, destructive:Boolean = false):Array {
			var storage:Object, i:int, value:Object;
			
			if (!destructive) {
				array = array.concat();
			}
			storage = { };
			i = array.length;
			while (i--) {
				value = array[i];
				if (value in storage) {
					array.splice(i, 1);
				}
				storage[value] = true;
			}
			
			return array;
		}
		
		public static function random(array:Array):* {
			
			return array[array.length * Math.random() >> 0];
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
