package net.minodisk.util {
	
	public class StringUtil {
		
		static public function padLeft(value:*, length:int, pad:String):String {
      var str:String = String(value);
			while (str.length < length) {
				str = pad + str;
			}
			return str;
		}
		
		static public function padRight(value:*, length:int, pad:String):String {
      var str:String = String(value);
			while (str.length < length) {
				str += pad;
			}
			return str;
		}
		
		static public function repeat(value:Object, length:int):String {
			var str:String = '';
			while (length--) {
				str += value;
			}
			return str;
		}
		
		static public function optimizeForTextField(value:String):String {
			return value.replace(/\t/g, '').replace(/\r\n/g, '\r');
		}
		
		
	}
}