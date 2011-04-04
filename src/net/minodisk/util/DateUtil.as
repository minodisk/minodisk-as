package net.minodisk.util {
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/25
	 */
	public class DateUtil {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		public static const MILLISECONDS_PER_DAY:int = 1000 * 60 * 60 * 24;
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		public static function isEqual(date0:Date, date1:Date):Boolean {
			
			return date0.getTime() === date1.getTime();
		}
		
		//TODO getTime() して MILLISECONDS_PER_DAY で割った商の比較との実行速度検証
		public static function isEqualDay(date0:Date, date1:Date):Boolean {
			
			return date0.getFullYear() === date1.getFullYear() &&
			       date0.getMonth() === date1.getMonth() &&
				   date0.getDate() === date1.getDate();
		}
		public static function isEqualUTCDay(date0:Date, date1:Date):Boolean {
			
			return date0.getUTCFullYear() === date1.getUTCFullYear() &&
			       date0.getUTCMonth() === date1.getUTCMonth() &&
				   date0.getUTCDate() === date1.getUTCDate();
		}
		
		public static function offsetDay(date:Date, day:int):Date {
			var newDate:Date;
			
			newDate = new Date();
			newDate.setTime(date.getTime() + MILLISECONDS_PER_DAY * day);
			
			return newDate;
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
