package net.minodisk.movie {
	
  public class Cue {
    
    public var time:Number;
    public var data:*;
    
    public function Cue(time:Number = -1, data:* = null) {
      this.time = time;
      this.data = data;
    }
    
    public function toString():String {
      return '[Cue time=' + time + ' data=' + data + ']';
    }
    
  }
}