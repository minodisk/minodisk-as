package net.minodisk.util {
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/14
	 */
	public class StringUtil {
		
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
		
		public static function padLeft(value:Object, length:int, pad:String):String {
			var string:String;
			
			string = value.toString();
			while (string.length < length) {
				string = pad + string;
			}
			
			return string;
		}
		
		public static function padRight(value:Object, length:int, pad:String):String {
			var string:String;
			
			string = value.toString();
			while (string.length < length) {
				string += pad;
			}
			
			return string;
		}
		
		public static function repeat(value:Object, length:int):String {
			var string:String, buffer:String;
			
			string = value.toString();
			buffer = '';
			while (length--) {
				buffer += string;
			}
			
			return buffer;
		}
		
		public static function optimizeForTextField(value:String):String {
			
			return value.replace(/\t/g, '').replace(/\r\n/g, '\r');
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
