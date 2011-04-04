package net.minodisk.format 
{
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author dsk
	 * @since 2009/09/11
	 */
	public class DateFormat  
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _pattern:String;
		private var _notPatterns:Array;
		
		private var _bcadNames:Array;
		private var _monthNames:Array;
		private var _dayNames:Array;
		private var _ampmNames:Array;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		/**
		 * パターンです.
		 * <p>
		 * パターン文字の解説です。
		 * <table>
		 * <tr><th>文字</th><th>説明</th><th>例</th></tr>
		 * <tr><td>G</td><td>紀元</td><td>AD</td></tr>
		 * <tr><td>y</td><td>年</td><td>2009, 09</td></tr>
		 * <tr><td>M</td><td>月</td><td>July, Jul, 07</td></tr>
		 * <tr><td>d</td><td>日</td><td>10</td></tr>
		 * <tr><td>E</td><td>曜日</td><td>Tuesday, Tue</td></tr>
		 * <tr><td>a</td><td>午前/午後</td><td>PM</td></tr>
		 * <tr><td>H</td><td>時(0～23)</td><td>0</td></tr>
		 * <tr><td>K</td><td>午前/午後の時(0～11)</td><td>0</td></tr>
		 * <tr><td>m</td><td>分</td><td>30</td></tr>
		 * <tr><td>s</td><td>秒</td><td>55</td></tr>
		 * <tr><td>S</td><td>ミリ秒</td><td>012</td></tr>
		 * <tr><td>z</td><td>タイムゾーン</td><td>GMT+09:00</td></tr>
		 * <tr><td>Z</td><td>タイムゾーン</td><td>+0900</td></tr>
		 * </table>
		 * </p>
		 * <p>
		 * 注意事項です。
		 * <ul>
		 * <li>パターン内に任意の文字列を入れたい場合は、任意の文字列を' 'で囲みます。' 'で囲まれた文字列はパターン文字と認識されません。</li>
		 * <li>パターン文字の連続する数によりフォーマットが決まります。yyの場合は年を2桁で表します。yyyyの場合は年を4桁で表します。</li>
		 * <li>月を表すパターン文字において、パターン文字の連続が3文字以上(MMM)の場合は、月をテキスト(July, Jul)で表示します。2文字以内(MM)の場合は、数字(07)で表します。</li>
		 * <li>\\t,\\vは内部的に使用しているのでパターンに指定することはできません。</li>
		 * <li>Java の SimpleDateFormat クラスを参考にしていますが、一部の機能を実装していません。ロケールは　Names　で終わる各配列をオーバーライドして使用します。</li>
		 * </ul>
		 * </p>
		 * <p>
		 * パターン例です。
		 * <table>
		 * <tr><th>パターン</th><th>表示例</th></tr>
		 * <tr><td>null("yyyy/MM/dd HH:mm:ss")</td><td>2009/09/14 15:08:31</td></tr>
		 * <tr><td>"yyyy.MM.dd G 'at' HH:mm:ss z"</td><td>2009.09.14 AD at 15:08:31 GMT+09:00</td></tr>
		 * <tr><td>"EEE, MMM d, ''yy"</td><td>Mon, Sep 14, '09</td></tr>
		 * <tr><td>"K:mm a"</td><td>3:08 PM</td></tr>
		 * <tr><td>"KK 'o''clock' a, zzzz"</td><td>03 o'clock PM, GMT+09:00</td></tr>
		 * <tr><td>"K:mm a, z"</td><td>3:08 PM, GMT+09:00</td></tr>
		 * <tr><td>"yyyyy.MMMMM.dd GGG KK:mm aaa"</td><td>02009.September.14 AD 03:08 PM</td></tr>
		 * <tr><td>"EEE, d MMM yyyy HH:mm:ss Z"</td><td>Mon, 14 Sep 2009 15:08:31 +0900</td></tr>
		 * <tr><td>"yyMMddHHmmssZ"</td><td>090914150831+0900</td></tr>
		 * </table>
		 * </p>
		 */
		public function get pattern():String { return _pattern; }
		public function set pattern(value:String):void 
		{
			_pattern = (value)? value: 'yyyy/MM/dd HH:mm:ss';
			
			_parsePattern();
		}
		
		/**
		 * 紀元を表すストリング表現の配列です.
		 * <p>デフォルトの値は['BC', 'AD']です。</p>
		 */
		public function get bcadNames():Array { return _bcadNames; }
		public function set bcadNames(value:Array):void 
		{
			_bcadNames = value;
		}
		
		/**
		 * 月を表すストリング表現の配列です.
		 * <p>デフォルトの値は['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']です。</p>
		 */
		public function get monthNames():Array { return _monthNames; }
		public function set monthNames(value:Array):void 
		{
			_monthNames = value;
		}
		
		/**
		 * 曜日を表すストリング表現の配列です.
		 * <p>デフォルトの値は['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']です。</p>
		 */
		public function get dayNames():Array { return _dayNames; }
		public function set dayNames(value:Array):void 
		{
			_dayNames = value;
		}
		
		/**
		 * 午前/午後を表すストリング表現の配列です.
		 * <p>デフォルトの値は['AM', 'PM']です。</p>
		 */
		public function get ampmNames():Array { return _ampmNames; }
		public function set ampmNames(value:Array):void 
		{
			_ampmNames = value;
		}
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		/**
		 * DateFormat クラスは、日付のフォーマットを行うためのクラスです.
		 * 
		 * @param	pattern	指定されたパターンを持つオブジェクトを生成します。
		 * 
		 * @see	pattern
		 */
		public function DateFormat(pattern:String = "yyyy/MM/dd HH:mm:ss") 
		{
			_pattern = pattern;
			
			_bcadNames  = ['BC', 'AD'];
			_monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 
		                   'July', 'August', 'September', 'October', 'November', 'December'];
			_dayNames   = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
			_ampmNames  = ['AM', 'PM'];
			
			_parsePattern();
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * パターンに従い、フォーマットします。
		 * 
		 * @param	date	フォーマットする Date オブジェクトです。
		 * @return			フォーマットされた String です。
		 * 
		 * @see patern
		 */
		public function format(date:Date = null):String 
		{
			date = (date)? date: new Date();
			
			var output:String = '';
			var i:int, pointer:String, length:int;
			
			for (i = 0; i < _pattern.length; i ++) {
				pointer = _pattern.charAt(i);
				
				if (pointer == 'G') {
					length = /G+/.exec(_pattern)[0].length;
					output += _bcadNames[(date.fullYear < 0)? 0: 1];
				} else if (pointer == 'y') {
					length = /y+/.exec(_pattern)[0].length;
					output += _complement(date.fullYear.toString(), length);
				} else if (pointer == 'M') {
					length = /M+/.exec(_pattern)[0].length;
					if (length < 3) output += _complement((date.month + 1).toString(), length);
					else if (length < 5) output += _monthNames[date.month].substr(0, length);
					else output += _monthNames[date.month];
				} else if (pointer == 'd') {
					length = /d+/.exec(_pattern)[0].length;
					output += _complement(date.date.toString(), length);
				} else if (pointer == 'E') {
					length = /E+/.exec(_pattern)[0].length;
					if (length < 5) output += _dayNames[date.day].substr(0, length);
					else output += _dayNames[date.day];
				} else if (pointer == 'a') {
					length = /a+/.exec(_pattern)[0].length;
					output += _ampmNames[(date.hours < 12)? 0: 1];
				} else if (pointer == 'H') {
					length = /H+/.exec(_pattern)[0].length;
					output += _complement(date.hours.toString(), length);
				} else if (pointer == 'K') {
					length = /K+/.exec(_pattern)[0].length;
					output += _complement((date.hours % 12).toString(), length);
				} else if (pointer == 'm') {
					length = /m+/.exec(_pattern)[0].length;
					output += _complement(date.minutes.toString(), length);
				} else if (pointer == 's') {
					length = /s+/.exec(_pattern)[0].length;
					output += _complement(date.seconds.toString(), length);
				} else if (pointer == 'S') {
					length = /S+/.exec(_pattern)[0].length;
					output += _complementMilliseconds(date.milliseconds.toString(), length);
				} else if (pointer == 'z') {
					length = /z+/.exec(_pattern)[0].length;
					output += _complementTimezone(date.timezoneOffset);
				} else if (pointer == 'Z') {
					length = /Z+/.exec(_pattern)[0].length;
					output += _complementTimezone(date.timezoneOffset, true);
				} else {
					length = 1;
					output += pointer;
				}
				i += length - 1;
			}
			
			var counter:int = -1;
			output = output.replace(/\v/g, function ():String {
				counter ++;
				return _notPatterns[counter];
			});
			output = output.replace(/\t/g, '\'');
			
			return output;
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _parsePattern():void
		{
			_notPatterns = [];
			
			_pattern = _pattern.replace(/'{2}/g, '\t');
			_pattern = _pattern.replace(/'(.*?)'/g, function ():String {
				_notPatterns.push(arguments[1]);
				return '\v';
			});
		}
		
		private function _complement(value:String, length:int):String 
		{
			while (value.length < length) value = '0' + value;
			if (length != 1) value = value.substr(value.length - length);
			return value;
		}
		
		private function _complementMilliseconds(value:String, length:int):String 
		{
			while (value.length < 3) value = '0' + value;
			while (value.length < length) value += '0';
			value = value.substr(0, length);
			return value;
		}
		
		private function _complementTimezone(value:int, isShort:Boolean = false):String 
		{
			var output:String = (isShort)? '': 'GMT';
			output += (value < 0)? '+': '';
			output += _complement(( -Math.floor(value / 60)).toString(), 2);
			output += (isShort)? '': ':';
			output += _complement((value % 60).toString(), 2);
			return output;
		}
		
		
	}
	
	
}
			/*
			// 正規表現は処理速度が1.3倍ほど遅いので使用しない。
			// switch より　if が早いので if で実装した。
			var result:String;
			output = _pattern.replace(/(y+)|(M+)|(d+)|(E+)|(a+)|(H+)|(h+)|(m+)|(s+)|(S+)/g, function (match:String, y:String, M:String, d:String, E:String, a:String, H:String, h:String, m:String, s:String, S:String, index:int, whole:String):String {
				if (y != '') result = _complement(date.fullYear.toString(), y.length);
				else if (M != '') result = (M.length < 3)? _complement((date.month + 1).toString(), M.length)
				                     : (M.length < 5)? _monthNames[date.month].substr(0, M.length)
				                     : _monthNames[date.month];
				else if (d != '') result = _complement(date.date.toString(), d.length);
				else if (a != '') result = _ampmNames[(date.hours < 12)? 0: 1];
				else if (H != '') result = _complement(date.hours.toString(), H.length);
				else if (h != '') result = _complement((date.hours % 12).toString(), h.length);
				else if (m != '') result = _complement(date.minutes.toString(), m.length);
				else if (s != '') result = _complement(date.seconds.toString(), s.length);
				else if (S != '') result = _complementMilliseconds(date.milliseconds.toString(), S.length);
				return result;
			});
			/**/









