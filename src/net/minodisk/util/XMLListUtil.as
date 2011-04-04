package net.minodisk.util {
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/23
	 */
	public class XMLListUtil {
		
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
		
		public static function shuffle(list:XMLList):XMLList {
			var i:int, j:int, t:XML;
			
			i = list.length();
			while (i) {
				j = Math.random() * i >> 0;
				t = list[--i];
				list[i] = list[j];
				list[j] = t;
			}
			
			return list;
		}
		
		public static function random(list:XMLList):XML {
			
			return list[list.length() * Math.random() >> 0];
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
