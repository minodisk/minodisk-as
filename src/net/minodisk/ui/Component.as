package net.minodisk.ui {
	import flash.display.Sprite;
  import net.minodisk.errors.ImplementationError;
	
	public class Component extends Sprite {
		
		public var userData:Object;
		
		public function Component(...requiredProperties:Array) {
			super();
			
			userData = { };
      
      var notImplemented:Array = [];
      for (var i:int = 0, len:int = requiredProperties.length; i < len; ++i) {
        if (this[requiredProperties[i]] === null) {
          notImplemented.push(requiredProperties[i]);
        }
      }
      if (notImplemented.length !== 0) {
        throw new ImplementationError(notImplemented);
      }
		}
		
	}
}