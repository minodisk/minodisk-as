package net.minodisk.ui {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2011/04/03
	 */
	public class ScrollPane extends Sprite {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------
		
		public var bar:Sprite;
		public var contentMask:DisplayObject;
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _hit:Sprite;
		private var _content:Sprite;
		private var _barMinY:Number;
		private var _barMaxY:Number;
		private var _barMouseY:Number;
		private var _targetContentY:Number;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get content():Sprite { return _content; }
		
		public function set content(value:Sprite):void {
			
			if (_content) {
				removeChild(_content);
			}
			_content = value;
			if (_content) {
				_content.x = _content.y = 0;
				_content.mask = contentMask;
				addChildAt(_content, getChildIndex(contentMask));
				_updateBarHeight();
				resetPosition();
			}
		}
		
		public function get barMinY():Number { return _barMinY; }
		
		public function set barMinY(value:Number):void {
			
			_barMinY = value;
			
			_updateBarHeight();
			resetPosition();
		}
		
		public function get barMaxY():Number { return _barMaxY; }
		
		public function set barMaxY(value:Number):void {
			
			_barMaxY = value;
			
			_updateBarHeight();
			resetPosition();
		}
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function ScrollPane() {
			
			super();
			
			_hit = new Sprite();
			_hit.graphics.beginFill(0, 0);
			_hit.graphics.drawRect(0, 0, contentMask.width, contentMask.height);
			_hit.graphics.endFill();
			hitArea = _hit;
			addChildAt(_hit, 0);
			bar.buttonMode = true;
			_barMinY = bar.y;
			_barMaxY = contentMask.height - (_barMinY - contentMask.y);
			resetPosition();
			
			bar.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			addEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel);
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		public function resetPosition():void {
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
			
			_targetContentY = 0;
			bar.y = _barMinY;
			if (_content) {
				_content.y = contentMask.y;
			}
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _updateBarHeight():void {
			
			bar.visible = _content.height > contentMask.height;
			bar.height = (_barMaxY - _barMinY) * (contentMask.height / _content.height);
		}
		
		private function _onMouseDown(e:MouseEvent):void {
			
			_barMouseY = e.localY * bar.scaleY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		}
		
		private function _onMouseMove(e:MouseEvent):void {
			
			_onDragBar(e);
		}
		
		private function _onMouseUp(e:MouseEvent):void {
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_onDragBar(e);
		}
		
		private function _onDragBar(e:MouseEvent):void {
			var barMinY:Number, barMaxY:Number, barY:Number;
			
			barMinY = _barMinY;
			barMaxY = _barMaxY - bar.height;
			barY = globalToLocal(new Point(0, e.stageY)).y - _barMouseY;
			barY = (barY < barMinY) ? barMinY : (barY > barMaxY) ? barMaxY : barY;
			bar.y = barY;
			_targetContentY = (contentMask.height - _content.height) * (barY - barMinY) / (barMaxY - barMinY);
			e.updateAfterEvent();
			
			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		private function _onMouseWheel(e:MouseEvent):void {
			var barMinY:Number, barMaxY:Number, barY:Number;
			
			barMinY = _barMinY;
			barMaxY = _barMaxY - bar.height;
			barY = bar.y + 100 * ((e.delta < 0) ? -1 : 1) * (barMaxY - barMinY) / (contentMask.height - _content.height);
			barY = (barY < barMinY) ? barMinY : (barY > barMaxY) ? barMaxY : barY;
			bar.y = barY;
			_targetContentY = (contentMask.height - _content.height) * (barY - barMinY) / (barMaxY - barMinY);
			e.updateAfterEvent();
			
			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		private function _onEnterFrame(e:Event):void {
			var deltaY:Number;
			
			deltaY = (_targetContentY - _content.y) * 0.2;
			
			if (deltaY > -.1 && deltaY < .1) {
				_content.y = _targetContentY;
				removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
			} else {
				_content.y += deltaY;
			}
		}
		
		
	}
	
	
}
