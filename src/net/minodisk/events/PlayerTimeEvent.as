package net.minodisk.events {
  import flash.events.Event;
  
  public class PlayerTimeEvent extends Event {
    
    static public const UPDATE_TIME:String = 'updateTime';
    
    public var isHead:Boolean;
    public var isBuffer:Boolean;
    
    public function PlayerTimeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
      isHead:Boolean = false, isBuffer:Boolean = false) {
      super(type, bubbles, cancelable);
      this.isHead = isHead;
      this.isBuffer = isBuffer;
    }
    
    public override function clone():Event {
      return new PlayerTimeEvent(type, bubbles, cancelable, isHead, isBuffer);
    }
    
    public override function toString():String {
      return formatToString('PlayerTimeEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'isHead', 'isBuffer');
    }
    
  }
}