package net.minodisk.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import org.libspark.betweenas3.BetweenAS3;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2010/11/04
	 */
	public class Image extends Button
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _rectangle:Rectangle;
		private var _progressCircle:ProgressCircle;
		protected var _loader:Loader;
		protected var _caption:Loader;
		
		private var _bitmapData:BitmapData;
		private var _xml:XML;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get bitmapData():BitmapData { return _bitmapData; }
		
		public function get caption():Loader { return _caption; }
		
		public function get loader():Loader { return _loader; }
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function Image(rectangle:Rectangle) 
		{
			super();
			
			_rectangle = rectangle;
			x = _rectangle.x;
			y = _rectangle.y;
			
			_progressCircle = new ProgressCircle();
			addChild(_progressCircle);
			
			_loader = new Loader();
			_loader.alpha = 0;
			addChild(_loader);
			
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		public function load(xml:XML):void
		{
			_xml = xml;
			
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onCompleteLoad);
			_loader.load(new URLRequest(Config.pathToImage + _xml.@src.toString()));
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _onCompleteLoad(e:Event):void 
		{
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onCompleteLoad);
			
			var bitmap:Bitmap = (_loader.content as Bitmap);
			bitmap.smoothing = true;
			_bitmapData = bitmap.bitmapData;
			
			_loader.width = _rectangle.width;
			_loader.height = _rectangle.height;
			
			if (_xml.hasOwnProperty('@caption'))
			{
				_caption = new Loader();
				_caption.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
				_caption.contentLoaderInfo.addEventListener(Event.COMPLETE, _onCompleteCaption);
				_caption.load(new URLRequest(Config.pathToImage + _xml.@caption.toString()));
			}
			else
			{
				_show();
			}
		}
		
		private function _onIOError(e:IOErrorEvent):void 
		{
			(e.currentTarget as LoaderInfo).removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			(e.currentTarget as LoaderInfo).removeEventListener(Event.COMPLETE, _onCompleteLoad);
			
			trace(e);
		}
		
		private function _onCompleteCaption(e:Event):void 
		{
			_caption.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			_caption.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onCompleteCaption);
			
			_show();
		}
		
		protected function _show():void 
		{
			BetweenAS3.serial(
				BetweenAS3.to(
					_loader, {
						alpha: 1
					}, 0.2
				),
				BetweenAS3.removeFromParent(_progressCircle)
			).play();
			
			mouseEnabled = true;
			dispatchEvent(new Event(Event.COMPLETE, false, false));
		}
		
		
	}
	
	
}
