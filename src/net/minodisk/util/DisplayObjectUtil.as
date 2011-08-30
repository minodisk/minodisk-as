package net.minodisk.util {
  import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
  import flash.geom.Rectangle;
	
	public class DisplayObjectUtil {
		
		static public function removeChildren(context:DisplayObjectContainer, ...children:Array):void {
			var i:int;
      if (children.length) {
        i = children.length;
        while (i--) {
          context.removeChild(children[i]);
        }
      } else {
        i = context.numChildren;
        while (i--) {
          context.removeChildAt(0);
        }
      }
		}
		
		static public function getChildren(context:DisplayObjectContainer):Array {
			var children:Array = [];
      var i:int = context.numChildren;
      while (i--) {
        children[i] = context.getChildAt(i);
      }
			return children;
		}
    
    static public function containedIn(target:DisplayObject, rect:Rectangle):void {
      if (target.x < rect.left) {
        target.x = rect.left;
      }
      if (target.y < rect.top) {
        target.y = rect.top;
      }
      if (target.x > rect.right) {
        target.x = rect.right;
      }
      if (target.y > rect.bottom) {
        target.y = rect.bottom;
      }
    }
    
    static public function removeFromParent(child:DisplayObject):void {
      if (child.parent && child.parent is DisplayObjectContainer) {
        (child.parent as DisplayObjectContainer).removeChild(child);
      }
    }
		
	}
}