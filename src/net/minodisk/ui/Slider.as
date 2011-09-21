package net.minodisk.ui {
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import net.minodisk.events.SliderEvent;
  import net.minodisk.util.MathUtil;
  
	[Event(name='change', type='net.minodisk.events.SliderEvent')]
	[Event(name='changing', type='net.minodisk.events.SliderEvent')]
	[Event(name='changed', type='net.minodisk.events.SliderEvent')]
  
  public dynamic class Slider extends Component {
    
    public var head:Sprite;
    public var rail:Sprite;
    public var direction:String;
    
    private var _stage:Stage;
    
    public function get position():Number {
      var bounds:Rectangle = _getBounds();
      var value:Number;
      switch (direction) {
        case Direction.HORIZONTAL:
          value = (head.x - bounds.x) / bounds.width;
          break;
        case Direction.VERTICAL:
          value = (head.y - bounds.y) / bounds.height;
          break;
      }
      return value;
    }
    
    public function set position(value:Number):void {
      value = MathUtil.convergeBetween(value, 0, 1);
      var bounds:Rectangle = _getBounds();
      var position:Number;
      switch (direction) {
        case Direction.HORIZONTAL:
          head.x = bounds.x + bounds.width * value;
          break;
        case Direction.VERTICAL:
          head.y = bounds.y + bounds.height * value;
          break;
      }
    }
    
    public function Slider() {
      super('rail', 'head');
      
      buttonMode = true;
      direction = Direction.HORIZONTAL;
      addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
    }
    
    private function _mouseDown(e:MouseEvent):void {
      if (stage) {
        _stage = stage;
        _stage.addEventListener(MouseEvent.MOUSE_MOVE, _mouseMove);
        _stage.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
        head.startDrag(true, _getBounds());
        _dispatchChange(e, SliderEvent.CHANGING);
        e.updateAfterEvent();
      }
    }
    
    private function _mouseMove(e:MouseEvent):void {
      _dispatchChange(e, SliderEvent.CHANGING);
      e.updateAfterEvent();
    }
    
    private function _mouseUp(e:MouseEvent):void {
      _stage.removeEventListener(MouseEvent.MOUSE_MOVE, _mouseMove);
      _stage.removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
      _stage = null;
      head.stopDrag();
      _dispatchChange(e, SliderEvent.CHANGED);
      e.updateAfterEvent();
    }
    
    private function _dispatchChange(e:MouseEvent, name:String):void {
      var pos:Number = _getMousePosition(e);
      dispatchEvent(new SliderEvent(SliderEvent.CHANGE, false, false, pos));
      dispatchEvent(new SliderEvent(name, false, false, pos));
    }
    
    private function _getMousePosition(e:MouseEvent):Number {
      var point:Point = new Point(e.stageX, e.stageY);
      point = globalToLocal(point);
      var bounds:Rectangle = _getBounds();
      var value:Number;
      switch (direction) {
        case Direction.HORIZONTAL:
          value = (point.x - bounds.x) / bounds.width;
          break;
        case Direction.VERTICAL:
          value = (point.y - bounds.y) / bounds.height;
          break;
      }
      return (value < 0) ? 0 : (value > 1) ? 1 : value;
    }
    
    private function _getBounds():Rectangle {
      var bounds:Rectangle = rail.getBounds(this);
      switch (direction) {
        case Direction.HORIZONTAL:
          bounds.y = head.y;
          bounds.height = 0;
          break;
        case Direction.VERTICAL:
          bounds.x = head.x;
          bounds.width = 0;
          break;
      }
      return bounds;
    }
    
  }
}