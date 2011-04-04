package net.minodisk.color {
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/14
	 */
	public class ColorMatrix {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		private static const LUM_R:Number = .212671;
		private static const LUM_G:Number = .715160;
		private static const LUM_B:Number = .072169;
		
		public static const NORMAL:ColorMatrix = new ColorMatrix(
			1, 0, 0, 0, 0,
			0, 1, 0, 0, 0,
			0, 0, 1, 0, 0,
			0, 0, 0, 1, 0
		);
		
		public static const GRAY_SCALE:ColorMatrix = new ColorMatrix(
			.333333, .333333, .333333, 0, 0,
			.333333, .333333, .333333, 0, 0,
			.333333, .333333, .333333, 0, 0,
			0, 0, 0, 1, 0
		);
		
		public static const NTSC_GRAY_SCALE:ColorMatrix = new ColorMatrix(
			.298912, .586611, .114478, 0, 0,
			.298912, .586611, .114478, 0, 0,
			.298912, .586611, .114478, 0, 0,
			0, 0, 0, 1, 0
		);
		
		public static const SEPIA:ColorMatrix = new ColorMatrix(
			.9, 0, 0, 0, 0,
			0, .7, 0, 0, 0,
			0, 0, .4, 0, 0,
			0, 0, 0, 1, 0
		);
		
		public static const REVERSE:ColorMatrix = new ColorMatrix(
			-1, 0, 0, 0, 0xff,
			0, -1, 0, 0, 0xff,
			0, 0, -1, 0, 0xff,
			0, 0, 0, 1, 0
		);
		
		
		//--------------------------------------
		// CLASS PUBLIC METHODS
		//--------------------------------------
		
		public static function staturation(value:Number):ColorMatrix {
			
			var n:Number = 1 - value;
			var r:Number = LUM_R * n;
			var g:Number = LUM_G * n;
			var b:Number = LUM_B * n;
			return new ColorMatrix(
				r + value, g, b, 0, 0,
				r, g + value, b, 0, 0,
				r, g, b + value, 0, 0,
				0, 0, 0, 1, 0
			);
			
		}
		
		/*public static function get staturation(v:Number):Array {
			
			var a:Number = v * 2 / 3 + 1 / 3;
			var b:Number = (1 - a) / 2;
			return [
				a, b, b, 0, 0,
				b, a, b, 0, 0,
				b, b, a, 0, 0,
				0, 0, 0, 1, 0
			];
			
		}
		
		public static function get brightness(v:Number):Array {
			
			return [
				1, 0, 0, v, 0,
				0, 1, 0, v, 0,
				0, 0, 1, v, 0,
				0, 0, 0, 1, 0
			];
			
		}
		
		public static function set contrust(v:Number):Array {
			
			var a:Number = v + 1;
			var b:Number = -128 * v;
			return [
				a, 0, 0, 0, b,
				0, a, 0, 0, b,
				0, 0, a, 0, b,
				0, 0, 0, 1, 0
			];
			
		}*/
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		
		public var matrix:Array;
		
		/*private var _rr:Number;
		private var _rg:Number;
		private var _rb:Number;
		private var _ra:Number;
		private var _rAdd:Number;
		
		private var _gr:Number;
		private var _gg:Number;
		private var _gb:Number;
		private var _ga:Number;
		private var _gAdd:Number;
		
		private var _br:Number;
		private var _bg:Number;
		private var _bb:Number;
		private var _ba:Number;
		private var _bAdd:Number;
		
		private var _ar:Number;
		private var _ag:Number;
		private var _ab:Number;
		private var _aa:Number;
		private var _aAdd:Number;/**/
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get rr():Number { return matrix[0]; }
		
		public function set rr(value:Number):void {
			matrix[0] = value;
		}
		
		public function get rg():Number { return matrix[1]; }
		
		public function set rg(value:Number):void {
			matrix[1] = value;
		}
		
		public function get rb():Number { return matrix[2]; }
		
		public function set rb(value:Number):void {
			matrix[2] = value;
		}
		
		public function get ra():Number { return matrix[3]; }
		
		public function set ra(value:Number):void {
			matrix[3] = value;
		}
		
		public function get rAdd():Number { return matrix[4]; }
		
		public function set rAdd(value:Number):void {
			matrix[4] = value;
		}
		
		public function get gr():Number { return matrix[5]; }
		
		public function set gr(value:Number):void {
			matrix[5] = value;
		}
		
		public function get gg():Number { return matrix[6]; }
		
		public function set gg(value:Number):void {
			matrix[6] = value;
		}
		
		public function get gb():Number { return matrix[7]; }
		
		public function set gb(value:Number):void {
			matrix[7] = value;
		}
		
		public function get ga():Number { return matrix[8]; }
		
		public function set ga(value:Number):void {
			matrix[8] = value;
		}
		
		public function get gAdd():Number { return matrix[9]; }
		
		public function set gAdd(value:Number):void {
			matrix[9] = value;
		}
		
		public function get br():Number { return matrix[10]; }
		
		public function set br(value:Number):void {
			matrix[10] = value;
		}
		
		public function get bg():Number { return matrix[11]; }
		
		public function set bg(value:Number):void {
			matrix[11] = value;
		}
		
		public function get bb():Number { return matrix[12]; }
		
		public function set bb(value:Number):void {
			matrix[12] = value;
		}
		
		public function get ba():Number { return matrix[13]; }
		
		public function set ba(value:Number):void {
			matrix[13] = value;
		}
		
		public function get bAdd():Number { return matrix[14]; }
		
		public function set bAdd(value:Number):void {
			matrix[14] = value;
		}
		
		public function get ar():Number { return matrix[15] }
		
		public function set ar(value:Number):void {
			matrix[15] = value;
		}
		
		public function get ag():Number { return matrix[16]; }
		
		public function set ag(value:Number):void {
			matrix[16] = value;
		}
		
		public function get ab():Number { return matrix[17]; }
		
		public function set ab(value:Number):void {
			matrix[17] = value;
		}
		
		public function get aa():Number { return matrix[18]; }
		
		public function set aa(value:Number):void {
			matrix[18] = value;
		}
		
		public function get aAdd():Number { return matrix[19]; }
		
		public function set aAdd(value:Number):void {
			matrix[19] = value;
		}
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function ColorMatrix(rr:Number = 1, rg:Number = 0, rb:Number = 0, ra:Number = 0, rAdd:int = 0,
		                            gr:Number = 0, gg:Number = 1, gb:Number = 0, ga:Number = 0, gAdd:int = 0,
									br:Number = 0, bg:Number = 0, bb:Number = 1, ba:Number = 0, bAdd:int = 0,
									ar:Number = 0, ag:Number = 0, ab:Number = 0, aa:Number = 1, aAdd:int = 0) {
			matrix = [
				rr, rg, rb, ra, rAdd,
				gr, gg, gb, ga, gAdd,
				br, bg, bb, ba, bAdd,
				ar, ag, ab, aa, aAdd
			];
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		public function toString():String {
			return '[' + matrix[0] + ', ' + matrix[1] + ', ' + matrix[2] + ', ' + matrix[3] + ', ' + matrix[4] + ',\n' + 
			       ' ' + matrix[5] + ', ' + matrix[6] + ', ' + matrix[7] + ', ' + matrix[8] + ', ' + matrix[9] + ',\n' + 
			       ' ' + matrix[10] + ', ' + matrix[11] + ', ' + matrix[12] + ', ' + matrix[13] + ', ' + matrix[14] + ',\n' + 
			       ' ' + matrix[15] + ', ' + matrix[16] + ', ' + matrix[17] + ', ' + matrix[18] + ', ' + matrix[19] + ']';
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}
