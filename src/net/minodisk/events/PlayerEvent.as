package net.minodisk.events {
  import flash.events.Event;
  
  public class PlayerEvent extends Event {
    
    static public const READY:String = 'ready';
    static public const STATUS_CHANGE:String = 'statusChange';
    static public const LOAD_PROGRESS:String = 'loadProgress';
    static public const SEEK_START:String = 'seekStart';
    static public const SEEK_COMPLETE:String = 'seekComplete';
    
    public function PlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
      super(type, bubbles, cancelable);
    }
    
    public override function clone():Event {
      return new PlayerEvent(type, bubbles, cancelable);
    }
    
    public override function toString():String {
      return formatToString('PlayerEvent', 'type', 'bubbles', 'cancelable', 'eventPhase');
    }
    
  }
}