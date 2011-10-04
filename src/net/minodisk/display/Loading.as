package net.minodisk.display {
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.events.Event;
	
  public class Loading extends Sprite {
    
    public function Loading(color:int = 0xffffff, length:int = 10) {
      super();
      
      mouseEnabled = mouseChildren = false;
      
      var i:int = length;
      var angle:Number = 360 / length;
      var shape:Shape;
      while (i--) {
        shape = new Shape();
        shape.graphics.beginFill(color, .2 + .6 / length * i);
        shape.graphics.drawCircle(0, 12, 3);
        shape.graphics.endFill();
        shape.rotation = angle * i;
        addChild(shape);
      }
      addEventListener(Event.ENTER_FRAME, _enterFrame);
    }
    
    private function _enterFrame(e:Event):void {
      rotation += 6;
    }
    
  }
}