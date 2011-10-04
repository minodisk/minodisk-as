package net.minodisk.core {
  import flash.utils.describeType;
	
  public class Core {
    
    public function Core() {
      
    }
    
    protected function formatToString(...props:Array):String {
      var tmp:Array = [String(describeType(this).@name)];
      for (var i:int = 0, len:int = props.length, prop:String; i < len; ++i) {
        prop = props[i];
        tmp.push(prop + '=' + String(this[prop]));
      }
      return '[' + tmp.join(' ') + ']';
    }
    
  }
}