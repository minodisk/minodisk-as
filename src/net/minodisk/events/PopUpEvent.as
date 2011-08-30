package net.minodisk.events {
  import flash.events.Event;
  
  public class PopUpEvent extends Event {
    
    static public const OPENING:String = 'opening';
    static public const OPENED:String = 'opened';
    static public const SUBMIT:String = 'submit';
    static public const CANCEL:String = 'cancel';
    static public const CLOSING:String = 'closing';
    static public const CLOSED:String = 'closed';
    
    public var data:Object;
    
    public function PopUpEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
      data:Object = null) { 
      super(type, bubbles, cancelable);
      this.data = data;
    } 
    
    public override function clone():Event { 
      return new PopUpEvent(type, bubbles, cancelable, data);
    } 
    
    public override function toString():String { 
      return formatToString("PopUpEvent", "type", "bubbles", "cancelable", "eventPhase", "data"); 
    }
    
  }
  
}