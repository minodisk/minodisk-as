package net.minodisk.debugger {
	import fl.controls.Button;
	import fl.controls.ComboBox;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/03/10
	 */
	public class RequestTest extends Sprite {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------
		
		public var urlTextInput:TextInput;
		public var methodComboBox:ComboBox;
		public var dataTextArea:TextArea;
		public var sendButton:Button;
		public var httpStatusTextField:TextField;
		public var responseTextArea:TextArea;
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _urlLoader:URLLoader;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function RequestTest() {
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, _onHTTPStatus);
			_urlLoader.addEventListener(Event.COMPLETE, _onComplete);
			
			sendButton.addEventListener(MouseEvent.CLICK, _onClickSendButton);
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _onClickSendButton(e:MouseEvent):void {
			httpStatusTextField.text = '';
			responseTextArea.text = '';
			
			var request:URLRequest = new URLRequest(urlTextInput.text);
			request.method = methodComboBox.selectedItem.data;
			request.data = dataTextArea.text;
			_urlLoader.load(request);
			
			trace(new Date(), 'SEND REQUEST');
			trace(' url :', request.url);
			trace(' method :',request.method);
			trace(' data :',request.data);
		}
		
		private function _onIOError(e:IOErrorEvent):void {
			responseTextArea.text = e.type + ' : ' + e.text;
		}
		
		private function _onSecurityError(e:SecurityErrorEvent):void {
			responseTextArea.text = e.type + ' : ' + e.text;
		}
		
		private function _onHTTPStatus(e:HTTPStatusEvent):void {
			httpStatusTextField.text = e.status.toString();
		}
		
		private function _onComplete(e:Event):void {
			responseTextArea.text = String(_urlLoader.data);
			responseTextArea.horizontalScrollPosition = 0;
			responseTextArea.verticalScrollPosition = 0;
		}
		
		
	}
	
	
}
