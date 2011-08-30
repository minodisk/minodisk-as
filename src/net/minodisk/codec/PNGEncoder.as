package net.minodisk.codec {
  import flash.display.BitmapData;
  import flash.utils.ByteArray;
	
  public class PNGEncoder {

		static private const SIGNATURE:ByteArray = _createSignature();
	  static private const CRC_TABLE:Vector.<uint> = Vector.<uint>([
			0x000000000, 0x077073096, 0x0EE0E612C, 0x0990951BA, 0x0076DC419, 0x0706AF48F, 0x0E963A535, 0x09E6495A3, 
			0x00EDB8832, 0x079DCB8A4, 0x0E0D5E91E, 0x097D2D988, 0x009B64C2B, 0x07EB17CBD, 0x0E7B82D07, 0x090BF1D91, 
			0x01DB71064, 0x06AB020F2, 0x0F3B97148, 0x084BE41DE, 0x01ADAD47D, 0x06DDDE4EB, 0x0F4D4B551, 0x083D385C7, 
			0x0136C9856, 0x0646BA8C0, 0x0FD62F97A, 0x08A65C9EC, 0x014015C4F, 0x063066CD9, 0x0FA0F3D63, 0x08D080DF5, 
			0x03B6E20C8, 0x04C69105E, 0x0D56041E4, 0x0A2677172, 0x03C03E4D1, 0x04B04D447, 0x0D20D85FD, 0x0A50AB56B, 
			0x035B5A8FA, 0x042B2986C, 0x0DBBBC9D6, 0x0ACBCF940, 0x032D86CE3, 0x045DF5C75, 0x0DCD60DCF, 0x0ABD13D59, 
			0x026D930AC, 0x051DE003A, 0x0C8D75180, 0x0BFD06116, 0x021B4F4B5, 0x056B3C423, 0x0CFBA9599, 0x0B8BDA50F, 
			0x02802B89E, 0x05F058808, 0x0C60CD9B2, 0x0B10BE924, 0x02F6F7C87, 0x058684C11, 0x0C1611DAB, 0x0B6662D3D, 
			0x076DC4190, 0x001DB7106, 0x098D220BC, 0x0EFD5102A, 0x071B18589, 0x006B6B51F, 0x09FBFE4A5, 0x0E8B8D433, 
			0x07807C9A2, 0x00F00F934, 0x09609A88E, 0x0E10E9818, 0x07F6A0DBB, 0x0086D3D2D, 0x091646C97, 0x0E6635C01, 
			0x06B6B51F4, 0x01C6C6162, 0x0856530D8, 0x0F262004E, 0x06C0695ED, 0x01B01A57B, 0x08208F4C1, 0x0F50FC457, 
			0x065B0D9C6, 0x012B7E950, 0x08BBEB8EA, 0x0FCB9887C, 0x062DD1DDF, 0x015DA2D49, 0x08CD37CF3, 0x0FBD44C65, 
			0x04DB26158, 0x03AB551CE, 0x0A3BC0074, 0x0D4BB30E2, 0x04ADFA541, 0x03DD895D7, 0x0A4D1C46D, 0x0D3D6F4FB, 
			0x04369E96A, 0x0346ED9FC, 0x0AD678846, 0x0DA60B8D0, 0x044042D73, 0x033031DE5, 0x0AA0A4C5F, 0x0DD0D7CC9, 
			0x05005713C, 0x0270241AA, 0x0BE0B1010, 0x0C90C2086, 0x05768B525, 0x0206F85B3, 0x0B966D409, 0x0CE61E49F, 
			0x05EDEF90E, 0x029D9C998, 0x0B0D09822, 0x0C7D7A8B4, 0x059B33D17, 0x02EB40D81, 0x0B7BD5C3B, 0x0C0BA6CAD, 
			0x0EDB88320, 0x09ABFB3B6, 0x003B6E20C, 0x074B1D29A, 0x0EAD54739, 0x09DD277AF, 0x004DB2615, 0x073DC1683, 
			0x0E3630B12, 0x094643B84, 0x00D6D6A3E, 0x07A6A5AA8, 0x0E40ECF0B, 0x09309FF9D, 0x00A00AE27, 0x07D079EB1, 
			0x0F00F9344, 0x08708A3D2, 0x01E01F268, 0x06906C2FE, 0x0F762575D, 0x0806567CB, 0x0196C3671, 0x06E6B06E7, 
			0x0FED41B76, 0x089D32BE0, 0x010DA7A5A, 0x067DD4ACC, 0x0F9B9DF6F, 0x08EBEEFF9, 0x017B7BE43, 0x060B08ED5, 
			0x0D6D6A3E8, 0x0A1D1937E, 0x038D8C2C4, 0x04FDFF252, 0x0D1BB67F1, 0x0A6BC5767, 0x03FB506DD, 0x048B2364B, 
			0x0D80D2BDA, 0x0AF0A1B4C, 0x036034AF6, 0x041047A60, 0x0DF60EFC3, 0x0A867DF55, 0x0316E8EEF, 0x04669BE79, 
			0x0CB61B38C, 0x0BC66831A, 0x0256FD2A0, 0x05268E236, 0x0CC0C7795, 0x0BB0B4703, 0x0220216B9, 0x05505262F, 
			0x0C5BA3BBE, 0x0B2BD0B28, 0x02BB45A92, 0x05CB36A04, 0x0C2D7FFA7, 0x0B5D0CF31, 0x02CD99E8B, 0x05BDEAE1D, 
			0x09B64C2B0, 0x0EC63F226, 0x0756AA39C, 0x0026D930A, 0x09C0906A9, 0x0EB0E363F, 0x072076785, 0x005005713, 
			0x095BF4A82, 0x0E2B87A14, 0x07BB12BAE, 0x00CB61B38, 0x092D28E9B, 0x0E5D5BE0D, 0x07CDCEFB7, 0x00BDBDF21, 
			0x086D3D2D4, 0x0F1D4E242, 0x068DDB3F8, 0x01FDA836E, 0x081BE16CD, 0x0F6B9265B, 0x06FB077E1, 0x018B74777, 
			0x088085AE6, 0x0FF0F6A70, 0x066063BCA, 0x011010B5C, 0x08F659EFF, 0x0F862AE69, 0x0616BFFD3, 0x0166CCF45, 
			0x0A00AE278, 0x0D70DD2EE, 0x04E048354, 0x03903B3C2, 0x0A7672661, 0x0D06016F7, 0x04969474D, 0x03E6E77DB, 
			0x0AED16A4A, 0x0D9D65ADC, 0x040DF0B66, 0x037D83BF0, 0x0A9BCAE53, 0x0DEBB9EC5, 0x047B2CF7F, 0x030B5FFE9, 
			0x0BDBDF21C, 0x0CABAC28A, 0x053B39330, 0x024B4A3A6, 0x0BAD03605, 0x0CDD70693, 0x054DE5729, 0x023D967BF, 
			0x0B3667A2E, 0x0C4614AB8, 0x05D681B02, 0x02A6F2B94, 0x0B40BBE37, 0x0C30C8EA1, 0x05A05DF1B, 0x02D02EF8D
		]);
		static private const IEND_CHUNK:ByteArray = _createChunk(0x49454E44, null);
		
		static public function encode(source:BitmapData, filterType:int = 0):ByteArray {
			CRC_TABLE.fixed = true
			
			// Create output byte array.
			var png:ByteArray = new ByteArray();
			
			// Write PNG file signature.
			png.writeBytes(SIGNATURE);
			
			// Write IHDR chunk.
			var header:ByteArray = new ByteArray();
			header.writeInt(source.width);
			header.writeInt(source.height);
			header.writeUnsignedInt((source.transparent)? 0x08060000: 0x08020000);
			header.writeByte(0);
			png.writeBytes(_createChunk(0x49484452, header));
			
			// Write IDAT chunk.
			var data:ByteArray;
			switch (filterType) {
				case PNGFilterType.NONE:    data = _createNoneFilteredImageData(source);    break;
				case PNGFilterType.SUB:     data = _createSubFilteredImageData(source);     break;
				case PNGFilterType.UP:      data = _createUpFilteredImageData(source);      break;
				case PNGFilterType.AVERAGE: data = _createAverageFilteredImageData(source); break;
				case PNGFilterType.PAETH:   data = _createPaethFilteredImageData(source);   break;
				default: throw new ArgumentError('The filterType argument must be between 0 and 4; got ' + filterType.toString() + '.'); break;
			}
			png.writeBytes(_createChunk(0x49444154, data));
			
			// Write IEND chunk.
			png.writeBytes(IEND_CHUNK);
			
			return png;
		}
		
		static private function _createSignature():ByteArray {
			var signature:ByteArray = new ByteArray();
			
			signature.writeUnsignedInt(0x89504E47);
			signature.writeUnsignedInt(0x0D0A1A0A);
			
			return signature;
		}
		
		static private function _createChunk(type:uint, data:ByteArray):ByteArray {
			var chunk:ByteArray = new ByteArray();
			
			// Write data length.(4 bytes)
			chunk.writeUnsignedInt((data)? data.length: 0);
			
			// Write chunk type.(4 bytes)
			chunk.writeUnsignedInt(type);
			
			// Write chunk data.(data.length bytes)
			if (data) chunk.writeBytes(data);
			
			// Keep CRC end position and calculate CRC length.
			var crcEnd:uint = chunk.position;
			var crcLength:int = crcEnd - 4;
			
			// Write CRC.(4 bytes)
			var c:uint = 0xFFFFFFFF;
			var i:int;
			chunk.position = 4;
			for (i = 0; i < crcLength; i ++) {
				c = CRC_TABLE[(c ^ chunk.readUnsignedByte()) & 0xFF] ^ c >>> 8;
			}
			c ^= 0xFFFFFFFF;
			chunk.position = crcEnd;
			chunk.writeUnsignedInt(c);
			
			return chunk;
		}
		
		static private function _createNoneFilteredImageData(source:BitmapData):ByteArray {
			var data:ByteArray = new ByteArray();
			const TYPE:int = PNGFilterType.NONE;
			const WIDTH:int = source.width;
			const HEIGHT:int = source.height;
			var x:int, y:int, color:uint;
			if (!source.transparent) {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel(x, y);
						data.writeShort(color >>> 8);
						data.writeByte(color & 0xFF);
					}
				}
			} else {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel32(x, y);
						data.writeUnsignedInt((color & 0xFFFFFF) << 8 | color >>> 24);
					}
				}
			}
      data.compress();
			return data;
		}
		
		static private function _createSubFilteredImageData(source:BitmapData):ByteArray {
			var data:ByteArray = new ByteArray();
			
			// Keep constants.
			const TYPE:int = PNGFilterType.SUB;
			const WIDTH:int = source.width;
			const HEIGHT:int = source.height;
			
			// Write pixels data. 
			var x:int, y:int, color:uint, 
				r:uint, g:uint, b:uint, a:uint, 
			    rLeft:uint, gLeft:uint, bLeft:uint, aLeft:uint;
			if (!source.transparent) {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					
					rLeft = 0;
					gLeft = 0;
					bLeft = 0;
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel(x, y);
						r = color >> 16 & 0xFF;
						g = color >> 8  & 0xFF;
						b = color       & 0xFF;
						
						data.writeShort(
							  (r - rLeft + 0x100 & 0xFF) << 8 
							|  g - gLeft + 0x100 & 0xFF
						);
						data.writeByte(
							   b - bLeft + 0x100 & 0xFF
						);
						
						rLeft = r;
						gLeft = g;
						bLeft = b;
					}
				}
			} else {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					
					rLeft = 0;
					gLeft = 0;
					bLeft = 0;
					aLeft = 0;
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel32(x, y);
						r = color >> 16 & 0xFF;
						g = color >> 8  & 0xFF;
						b = color       & 0xFF;
						a = color >> 24 & 0xFF;
						
						data.writeUnsignedInt(
							  (r - rLeft + 0x100 & 0xFF) << 24 
							| (g - gLeft + 0x100 & 0xFF) << 16 
							| (b - bLeft + 0x100 & 0xFF) << 8 
							|  a - aLeft + 0x100 & 0xFF
						);
						
						rLeft = r;
						gLeft = g;
						bLeft = b;
						aLeft = a;
					}
				}
			}
      data.compress();
			return data;
		}
		
		static private function _createUpFilteredImageData(source:BitmapData):ByteArray
		{
			var data:ByteArray = new ByteArray();
			
			// Keep constants.
			const TYPE:int = PNGFilterType.UP;
			const WIDTH:int = source.width;
			const HEIGHT:int = source.height;
			
			// Write pixels data. 
			var x:int, y:int, color:uint, 
				r:uint, g:uint, b:uint, a:uint;
			var rAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var gAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var bAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var aAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			if (!source.transparent) {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel(x, y);
						r = color >> 16 & 0xFF;
						g = color >> 8  & 0xFF;
						b = color       & 0xFF;
						
						data.writeShort(
							  (r - rAboves[x] + 0x100 & 0xFF) << 8 
							|  g - gAboves[x] + 0x100 & 0xFF
						);
						data.writeByte(
							   b - bAboves[x] + 0x100 & 0xFF
						);
						
						rAboves[x] = r;
						gAboves[x] = g;
						bAboves[x] = b;
					}
				}
			} else {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel32(x, y);
						r = color >> 16 & 0xFF;
						g = color >> 8  & 0xFF;
						b = color       & 0xFF;
						a = color >> 24 & 0xFF;
						
						data.writeUnsignedInt(
							  (r - rAboves[x] + 0x100 & 0xFF) << 24 
							| (g - gAboves[x] + 0x100 & 0xFF) << 16 
							| (b - bAboves[x] + 0x100 & 0xFF) << 8 
							|  a - aAboves[x] + 0x100 & 0xFF
						);
						
						rAboves[x] = r;
						gAboves[x] = g;
						bAboves[x] = b;
						aAboves[x] = a;
					}
				}
			}
      data.compress();
			return data;
		}
		
		static private function _createAverageFilteredImageData(source:BitmapData):ByteArray
		{
			var data:ByteArray = new ByteArray();
			
			// Keep constants.
			const TYPE:int = PNGFilterType.AVERAGE;
			const WIDTH:int = source.width;
			const HEIGHT:int = source.height;
			
			// Write pixels data. 
			var x:int, y:int, color:uint, 
				r:uint, g:uint, b:uint, a:uint, 
			    rLeft:uint, gLeft:uint, bLeft:uint, aLeft:uint;
			var rAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var gAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var bAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var aAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			if (!source.transparent) {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					
					rLeft = 0;
					gLeft = 0;
					bLeft = 0;
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel(x, y);
						r = color >> 16 & 0xFF;
						g = color >> 8  & 0xFF;
						b = color       & 0xFF;
						
						data.writeShort(
							  (r - (rLeft + rAboves[x] >> 1) + 0x100 & 0xFF) << 8 
							|  g - (gLeft + gAboves[x] >> 1) + 0x100 & 0xFF
						);
						data.writeByte(
							   b - (bLeft + bAboves[x] >> 1) + 0x100 & 0xFF
						);
						
						rLeft = rAboves[x] = r;
						gLeft = gAboves[x] = g;
						bLeft = bAboves[x] = b;
					}
				}
			} else {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					
					rLeft = 0;
					gLeft = 0;
					bLeft = 0;
					aLeft = 0;
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel32(x, y);
						r = color >> 16 & 0xFF;
						g = color >> 8  & 0xFF;
						b = color       & 0xFF;
						a = color >> 24 & 0xFF;
						
						data.writeUnsignedInt(
							  (r - (rLeft + rAboves[x] >> 1) + 0x100 & 0xFF) << 24 
							| (g - (gLeft + gAboves[x] >> 1) + 0x100 & 0xFF) << 16 
							| (b - (bLeft + bAboves[x] >> 1) + 0x100 & 0xFF) << 8 
							|  a - (aLeft + aAboves[x] >> 1) + 0x100 & 0xFF
						);
						
						rLeft = rAboves[x] = r;
						gLeft = gAboves[x] = g;
						bLeft = bAboves[x] = b;
						aLeft = aAboves[x] = a;
					}
				}
			}
      data.compress();
			return data;
		}
		
		static private function _createPaethFilteredImageData(source:BitmapData):ByteArray
		{
			var data:ByteArray = new ByteArray();
			
			// Keep constants.
			const TYPE:int = PNGFilterType.PAETH;
			const WIDTH:int = source.width;
			const HEIGHT:int = source.height;
			
			// Write pixels data. 
			var x:int, y:int, color:uint, 
				r:uint, g:uint, b:uint, a:uint, 
			  rLeft:uint, gLeft:uint, bLeft:uint, aLeft:uint, 
				rLeftAbove:uint, gLeftAbove:uint, bLeftAbove:uint, aLeftAbove:uint, 
				p0:int, p1:int, p2:int, 
				rPrediction:uint, gPrediction:uint, bPrediction:uint, aPrediction:uint;
			var rAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var gAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var bAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			var aAboves:Vector.<uint> = new Vector.<uint>(WIDTH, true);
			if (!source.transparent) {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					
					rLeft = gLeft = bLeft = rLeftAbove = gLeftAbove = bLeftAbove = 0;
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel(x, y);
						r = color >> 16 & 0xFF;
						g = color >> 8  & 0xFF;
						b = color       & 0xFF;
						
						p0 = (rAboves[x] > rLeftAbove)? rAboves[x] - rLeftAbove: rLeftAbove - rAboves[x];
						p1 = (rLeft > rLeftAbove)? rLeft - rLeftAbove: rLeftAbove - rLeft;
						p2 = (rAboves[x] + rLeft > (rLeftAbove << 1))? rAboves[x] + rLeft - (rLeftAbove << 1): (rLeftAbove << 1) - rAboves[x] - rLeft;
						rPrediction = (p0 <= p1 && p0 <= p2)? rLeft: (p1 <= p2)? rAboves[x]: rLeftAbove;
						p0 = (gAboves[x] > gLeftAbove)? gAboves[x] - gLeftAbove: gLeftAbove - gAboves[x];
						p1 = (gLeft > gLeftAbove)? gLeft - gLeftAbove: gLeftAbove - gLeft;
						p2 = (gAboves[x] + gLeft > (gLeftAbove << 1))? gAboves[x] + gLeft - (gLeftAbove << 1): (gLeftAbove << 1) - gAboves[x] - gLeft;
						gPrediction = (p0 <= p1 && p0 <= p2)? gLeft: (p1 <= p2)? gAboves[x]: gLeftAbove;
						p0 = (bAboves[x] > bLeftAbove)? bAboves[x] - bLeftAbove: bLeftAbove - bAboves[x];
						p1 = (bLeft > bLeftAbove)? bLeft - bLeftAbove: bLeftAbove - bLeft;
						p2 = (bAboves[x] + bLeft > (bLeftAbove << 1))? bAboves[x] + bLeft - (bLeftAbove << 1): (bLeftAbove << 1) - bAboves[x] - bLeft;
						bPrediction = (p0 <= p1 && p0 <= p2)? bLeft: (p1 <= p2)? bAboves[x]: bLeftAbove;
						
						data.writeShort(
							  (r - rPrediction + 0x100 & 0xFF) << 8 
							|  g - gPrediction + 0x100 & 0xFF
						);
						data.writeByte(
							   b - bPrediction + 0x100 & 0xFF
						);
						
						rLeftAbove = rAboves[x];
						gLeftAbove = gAboves[x];
						bLeftAbove = bAboves[x];
						rLeft = rAboves[x] = r;
						gLeft = gAboves[x] = g;
						bLeft = bAboves[x] = b;
					}
				}
			} else {
				for (y = 0; y < HEIGHT; y ++) {
					data.writeByte(TYPE);
					
					rLeft = gLeft = bLeft = aLeft = rLeftAbove = gLeftAbove = bLeftAbove = aLeftAbove = 0;
					for (x = 0; x < WIDTH; x ++) {
						color = source.getPixel32(x, y);
						r = color >> 16 & 0xFF;
						g = color >> 8  & 0xFF;
						b = color       & 0xFF;
						a = color >> 24 & 0xFF;
						
						p0 = (rAboves[x] > rLeftAbove)? rAboves[x] - rLeftAbove: rLeftAbove - rAboves[x];
						p1 = (rLeft > rLeftAbove)? rLeft - rLeftAbove: rLeftAbove - rLeft;
						p2 = (rAboves[x] + rLeft > (rLeftAbove << 1))? rAboves[x] + rLeft - (rLeftAbove << 1): (rLeftAbove << 1) - rAboves[x] - rLeft;
						rPrediction = (p0 <= p1 && p0 <= p2)? rLeft: (p1 <= p2)? rAboves[x]: rLeftAbove;
						p0 = (gAboves[x] > gLeftAbove)? gAboves[x] - gLeftAbove: gLeftAbove - gAboves[x];
						p1 = (gLeft > gLeftAbove)? gLeft - gLeftAbove: gLeftAbove - gLeft;
						p2 = (gAboves[x] + gLeft > (gLeftAbove << 1))? gAboves[x] + gLeft - (gLeftAbove << 1): (gLeftAbove << 1) - gAboves[x] - gLeft;
						gPrediction = (p0 <= p1 && p0 <= p2)? gLeft: (p1 <= p2)? gAboves[x]: gLeftAbove;
						p0 = (bAboves[x] > bLeftAbove)? bAboves[x] - bLeftAbove: bLeftAbove - bAboves[x];
						p1 = (bLeft > bLeftAbove)? bLeft - bLeftAbove: bLeftAbove - bLeft;
						p2 = (bAboves[x] + bLeft > (bLeftAbove << 1))? bAboves[x] + bLeft - (bLeftAbove << 1): (bLeftAbove << 1) - bAboves[x] - bLeft;
						bPrediction = (p0 <= p1 && p0 <= p2)? bLeft: (p1 <= p2)? bAboves[x]: bLeftAbove;
						p0 = (aAboves[x] > aLeftAbove)? aAboves[x] - aLeftAbove: aLeftAbove - aAboves[x];
						p1 = (aLeft > aLeftAbove)? aLeft - aLeftAbove: aLeftAbove - aLeft;
						p2 = (aAboves[x] + aLeft > (aLeftAbove << 1))? aAboves[x] + aLeft - (aLeftAbove << 1): (aLeftAbove << 1) - aAboves[x] - aLeft;
						aPrediction = (p0 <= p1 && p0 <= p2)? aLeft: (p1 <= p2)? aAboves[x]: aLeftAbove;
						
						data.writeUnsignedInt(
							  (r - rPrediction + 0x100 & 0xFF) << 24 
							| (g - gPrediction + 0x100 & 0xFF) << 16 
							| (b - bPrediction + 0x100 & 0xFF) << 8 
							|  a - aPrediction + 0x100 & 0xFF
						);
						
						rLeftAbove = rAboves[x];
						gLeftAbove = gAboves[x];
						bLeftAbove = bAboves[x];
						aLeftAbove = aAboves[x];
						rLeft = rAboves[x] = r;
						gLeft = gAboves[x] = g;
						bLeft = bAboves[x] = b;
						aLeft = aAboves[x] = a;
					}
				}
			}
      data.compress();
			return data;
		}
    
  }
}