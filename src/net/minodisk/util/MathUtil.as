package net.minodisk.util {
	
	public class MathUtil {
		
		public static const DEGREE_PER_RADIAN:Number = 180 / Math.PI;
		public static const RADIAN_PER_DEGREE:Number = Math.PI / 180;
		
		/**
		 * Get random number a <= return < b
		 * 
		 * @param	a	not less than...
		 * @param	b	less than...
		 * @return		random number.
		 */
		static public function randomBetween(a:Number, b:Number):Number {
			return a + Math.random() * (b - a);
		}
    
    static public function nearestIn(value:Number, ...targets:Array):Number {
      return nearest(value, targets);
    }
    
    static public function nearest(value:Number, targets:Array):Number {
      var compared:Array = [];
      var i:int = targets.length;
      while (i--) {
        compared[i] = Math.abs(targets[i] - value);
      }
      var min:Number = Math.min.apply(null, compared);
      return targets[compared.indexOf(min)];
    }
		
		static public function convergeBetween(value:Number, a:Number, b:Number):Number {
      var min:Number = Math.min(a, b);
      var max:Number = Math.max(a, b);
      return (value < min) ? min : (value > max) ? max : value;
    }
    
	}
}