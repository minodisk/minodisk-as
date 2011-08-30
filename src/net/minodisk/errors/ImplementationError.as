package net.minodisk.errors {
	
  public class ImplementationError extends Error {
    
    public function ImplementationError(properties:Array) {
      var tmp:Array = [];
      for (var i:int = 0, len:int = properties.length; i < len; ++i) {
        tmp[i] = '"' + properties[i] + '"';
      }
      super(tmp.join(', ') + ' is not implemented.');
      name = 'ImplementationError';
    }
    
  }
}