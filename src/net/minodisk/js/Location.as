package net.minodisk.js {
	import flash.external.ExternalInterface;
	
	public class Location {
		
		public static const JS_LOCATION:String = <![CDATA[
			function () {
				return {
					href: location.href,
					protocol: location.protocol,
					host: location.host,
					hostname: location.hostname,
					port: location.port,
					pathname: location.pathname,
					search: location.search,
					hash: location.hash
				};
			}
		]]>.toString().replace(/[\r\n\t]/g, '');
		
		private var _href:String;
		private var _protocol:String;
		private var _host:String;
		private var _hostname:String;
		private var _port:String;
		private var _pathname:String;
		private var _search:String;
		private var _hash:String;
		
		
		public static function get available():Boolean { return ExternalInterface.available; }
		
		public function get href():String { return _href; }
		public function set href(value:String):void {
			_href = value;
		}
		
		public function get protocol():String { return _protocol; }
		
		public function get host():String { return _host; }
		
		public function get hostname():String { return _hostname; }
		
		public function get port():String { return _port; }
		
		public function get pathname():String { return _pathname; }
		
		public function get search():String { return _search; }
		
		public function get hash():String { return _hash; }
		
		public function Location() {
			if (ExternalInterface.available) {
				var location:Object = ExternalInterface.call(JS_LOCATION);
				_href = location.href;
				_protocol = location.protocol;
				_host = location.host;
				_hostname = location.hostname;
				_port = location.port;
				_pathname = location.pathname;
				_search = location.search;
				_hash = location.hash;
			}
		}
		
		public function replace(url:String):void {
			if (ExternalInterface.available) {
				ExternalInterface.call("location.replace", url);
			}
		}
		
		public function reload(noCache:Boolean = false):void {
			if (ExternalInterface.available) {
				ExternalInterface.call("location.reload", noCache);
			}
		}
		
		public function toString():String {
			return '[Location ' + 
			        'href=' + href + ', ' + 
					'protocol=' + protocol + ', ' + 
					'host=' + host + ', ' + 
					'hostname=' + hostname + ', ' + 
					'port=' + port + ', ' + 
					'pathname=' + pathname + ', ' + 
					'search=' + search + ', ' + 
					'hash=' + hash + ']';
		}
	}
}