package net.minodisk.ui
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @langversion ActionScript 3.0
	 * @playerversion 9.0
	 * @author dsk
	 * @since 2010/05/14
	 */
	public class Button extends Base
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		public static const OUT:String = 'out';
		public static const OVER:String = 'over';
		public static const DOWN:String = 'down';
		public static const DISABLED:String = 'disabled';
		
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------
		
		public var out:MovieClip;
		public var over:MovieClip;
		public var down:MovieClip;
		public var disabled:MovieClip;
		
		
		//--------------------------------------
		// PROTECTED VARIABLES
		//--------------------------------------
		
		protected var _buttons:Object;
		protected var _status:String;
		protected var _isOver:Boolean;
		protected var _isDown:Boolean;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		public function get enabled():Boolean
		{
			return _status != DISABLED;
		}
		
		public function set enabled(value:Boolean):void
		{
			mouseEnabled = value;
			
			update((!value)? DISABLED: (_isOver)? OVER :OUT);
		}
		
		public function get isOver():Boolean { return _isOver; }
		
		public function get isDown():Boolean { return _isDown; }
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function Button()
		{
			super();
			
			_buttons = {
				out: out,
				over: over,
				down: down,
				disabled: disabled
			};
			_isOver = false;
			_isDown = false;
			_status = OUT;
			for (var prop:String in _buttons)
			{
				if (_buttons[prop])
				{
					_buttons[prop].visible = (prop == OUT);
				}
			}
			
			mouseChildren = false;
			buttonMode = true;
			enabled = true;
			
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			addEventListener(MouseEvent.ROLL_OUT, _onRollOut);
			addEventListener(MouseEvent.ROLL_OVER, _onRollOver);
			addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		public function update(newStatus:String):void
		{
			if (newStatus != _status && _buttons[newStatus])
			{
				_buttons[_status].visible = false;
				_status = newStatus;
				_buttons[_status].visible = true;
			}
		}
		
		//--------------------------------------
		// PROTECTED METHODS
		//--------------------------------------
		
		protected function _onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
		}
		
		protected function _onStageMouseUp(e:MouseEvent):void 
		{
			_isDown = false;
		}
		
		protected function _onRollOut(e:MouseEvent):void
		{
			_isOver = false;
			
			update((_status == DISABLED) ? DISABLED : OUT);
		}
		
		protected function _onRollOver(e:MouseEvent):void
		{
			_isOver = true;
			
			update((_buttons.down && _isDown) ? DOWN : OVER);
		}
		
		protected function _onMouseDown(e:MouseEvent):void
		{
			_isDown = true;
			
			update(DOWN);
		}
		
		protected function _onMouseUp(e:MouseEvent):void
		{
			_isDown = false;
			
			update((_buttons.over && _isOver) ? OVER : OUT);
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
		
	}
	
	
}

