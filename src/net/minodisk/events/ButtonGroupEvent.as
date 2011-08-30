package net.minodisk.events {
  import flash.events.Event;
  import net.minodisk.ui.Button;
  
  public class ButtonGroupEvent extends Event {
    
    static public const SELECTED_CHANGE:String = 'selectedChange';
    
    public var selectedIndex:int;
    public var selectedButton:Button;
    
    public function ButtonGroupEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
      selectedIndex:int = -1, selectedButton:Button = null) { 
      super(type, bubbles, cancelable);
      this.selectedIndex = selectedIndex;
      this.selectedButton = selectedButton;
    } 
    
    public override function clone():Event { 
      return new ButtonGroupEvent(type, bubbles, cancelable, selectedIndex, selectedButton);
    }
    
    public override function toString():String { 
      return formatToString('ButtonGroupEvent', 'type', 'bubbles', 'cancelable', 'eventPhase', 'selectedIndex'); 
    }
    
  }
  
}