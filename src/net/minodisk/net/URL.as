package net.minodisk.net {
  import net.minodisk.core.Core;
	
  public class URL extends Core {
    
    public var protocol:String;
    public var port:String;
    public var hostname:String;
    public var pathname:String;
    public var query:Object;
    
    public function get url():String {
      var queryStr:String;
      if (query) {
        var tmp:Array = [];
        for (var key:String in query) {
          tmp.push(key + '=' + query[key]);
        }
        queryStr = tmp.join('&');
      }
      return protocol + '//' + hostname + ((port) ? ':' + String(port) : '') + pathname + ((queryStr) ? '?' + queryStr : '');
    }
    
    public function set url(value:String):void {
      if (value !== null) {
        var matched:Array = value.match(/^([^:\/\?#]+:)?\/\/([^\/\?#]*)?:?(\d+)?(\/[^\?#]*)\??([^#]*)?(#(.*))?/);
        if (matched) {
          protocol = matched[1];
          hostname = matched[2];
          port = matched[3];
          pathname = matched[4];
          if (matched[5]) {
            var queryStr:String = matched[5];
            var tmp:Array = queryStr.split('&');
            query = { };
            for (var i:int, len:int = tmp.length, kvc:Array; i < len; ++i) {
              kvc = tmp[i].split('=');
              query[kvc[0]] = kvc[1];
              trace(kvc[0], ':', kvc[1]);
            }
          } else {
            query = null;
          }
        } else {
          protocol = port = hostname = pathname = null;
          query = null;
        }
      }
    }
    
    public function URL(url:String = null) {
      this.url = url;
    }
    
    public function toString():String {
      return formatToString('protocol', 'port', 'hostname', 'pathname', 'query');
    }
    
  }
}