// actionscript3 HTTP POST binary class
//           copyright(c) 2007 Yosuke Matsusaka <yosuke.matsusaka@gmail.com> all rights reserved
//
// Distributed under GNU Lesser General Public License
// see: http://www.opensource.org/licenses/lgpl-license.php

// history
//  2007-03-00 test version - YM
//  2007-05-20 initial version (refactored as a library) - YM

package ym.net
{
  import flash.utils.ByteArray;
  import flash.net.URLRequestMethod;
	
  public class HTTPPostBinary
  {
    public var sessionId:String;
    public var contentType:String;
    public const method:String = URLRequestMethod.POST;

    private var buff:Array;
    private var bufftype:Array;

    public static const BINARY_TYPE:int = 1;
    public static const TEXT_TYPE:int = 2;
		
    public function HTTPPostBinary()
    {
      generateSessionId();
      contentType = "multipart/form-data; boundary=---------------------------"+sessionId;
      buff = new Array();
      bufftype = new Array();
    }
		
    public function generateSessionId():void
    {
      const str:String = "0123456789abcdef";
      sessionId = "";
      for (var i:int = 0; i < 13; i++) {
				sessionId = sessionId + str.charAt(int(Math.random()*str.length));
      }
      trace(sessionId);
    }
		
    public function addString(tag:String, dat:String):void
    {
      buff.push('-----------------------------'+sessionId+"\r\n");
      bufftype.push(TEXT_TYPE);
      buff.push('Content-Disposition: form-data; name="'+tag+'"'+"\r\n\r\n");
      bufftype.push(TEXT_TYPE);
      buff.push(dat+"\r\n");
      bufftype.push(TEXT_TYPE);
    }

    public function addBinary(tag:String, dat:ByteArray, mimetype:String, filename:String = null):void
    {
      buff.push('-----------------------------'+sessionId+"\r\n");
      bufftype.push(TEXT_TYPE);
      if (filename == null) {
				buff.push('Content-Disposition: form-data; name="'+tag+'"'+"\r\n");
      } else {
				buff.push('Content-Disposition: form-data; name="'+tag+'"; filename="'+filename+'"'+"\r\n");
      }
      bufftype.push(TEXT_TYPE);
      buff.push("Content-Type: "+mimetype+"\r\n\r\n");
      bufftype.push(TEXT_TYPE);
      buff.push(dat);
      bufftype.push(BINARY_TYPE);
      buff.push("\r\n");
      bufftype.push(TEXT_TYPE);
    }

    public function encodeData():ByteArray
    {
      buff.push("-----------------------------"+sessionId+"--");
      bufftype.push(TEXT_TYPE);
      return encodeByteArray(buff, bufftype);
    }            

    private function encodeByteArray(data:Array, datatype:Array):ByteArray
    {
      var ret:ByteArray = new ByteArray();
      var pt:int = 0;
      var i:int; var j:int;
      for (i = 0; i < data.length; i++) {
				if (datatype[i] == TEXT_TYPE) {
					var tmp:String = data[i];
					for (j = 0; j < tmp.length; j++) {
						ret[pt] = tmp.charCodeAt(j);
						pt++;
					}
				}
				else if (datatype[i] == BINARY_TYPE) {
					var tmp2:ByteArray = data[i];
					for (j = 0; j < tmp2.length; j++) {
						ret[pt] = tmp2[j];
						pt++;
					}
				}
				else {
					trace("unknown data type");
				}
      }
      return ret;
    }
  }
}
