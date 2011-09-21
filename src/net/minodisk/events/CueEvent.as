package net.minodisk.events {
  import flash.events.Event;
  import net.minodisk.movie.Cue;
  
  public class CueEvent extends Event {
    
    static public const CUE:String = 'cue';
    
    public var cue:Cue;
    public var layer:String;
    
    public function CueEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
      cue:Cue = null, layer:String = null) {
      super(type, bubbles, cancelable);
      this.cue = cue;
      this.layer = layer;
    }
    
    public override function clone():Event {
      return new CueEvent(type, bubbles, cancelable, cue);
    }
    
    public override function toString():String {
      return formatToString('CueEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'cue', 'layer');
    }
    
  }
}