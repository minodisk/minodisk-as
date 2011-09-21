package net.minodisk.events {
  import flash.events.Event;
  
  public class SliderEvent extends Event {
    
    static public const CHANGE:String = 'change';
    static public const CHANGING:String = 'changing';
    static public const CHANGED:String = 'changed';
    
    public var position:Number;
    
    public function SliderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, position:Number = -1) {
      super(type, bubbles, cancelable);
      this.position = position;
    }
    
    public override function clone():Event {
      return new SliderEvent(type, bubbles, cancelable, position);
    }
    
    public override function toString():String {
      return formatToString('SliderEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'position');
    }
    
  }
  
}