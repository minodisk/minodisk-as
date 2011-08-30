package net.minodisk.events {
  import flash.events.Event;
  
  public class LifeCycleEvent extends Event {
    
    static public const INITIALIZED:String = 'initialized';
    static public const READY:String = 'ready';
    static public const FINALIZED:String = 'finalized';
    
    public function LifeCycleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
      super(type, bubbles, cancelable);
    } 
    
    public override function clone():Event { 
      return new LifeCycleEvent(type, bubbles, cancelable);
    } 
    
    public override function toString():String { 
      return formatToString("LifeCycleEvent", "type", "bubbles", "cancelable", "eventPhase"); 
    }
    
  }
  
}