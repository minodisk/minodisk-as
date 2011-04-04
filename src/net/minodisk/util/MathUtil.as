package net.minodisk.util {
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/13
	 */
	public class MathUtil {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		public static const DEGREE_PER_RADIAN:Number = 180 / Math.PI;
		public static const RADIAN_PER_DEGREE:Number = Math.PI / 180;
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * Get random number a <= return < b
		 * 
		 * @param	a	not less than...
		 * @param	b	less than...
		 * @return		random number.
		 */
		public static function randomBetween(a:Number, b:Number):Number {
			return a + Math.random() * (b - a);
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
