package net.minodisk.ui {
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import net.minodisk.events.ButtonGroupEvent;
	
  [Event(name='selectedChange', type='net.minodisk.events.ButtonGroupEvent')]
  
  public class ButtonGroup extends EventDispatcher {
    
    private var _buttons:Array;
    private var _selectedButton:Button;
    private var _enabled:Boolean;
    
    public function get selectedIndex():int {
      return _buttons.indexOf(_selectedButton);
    }
    
    public function set selectedIndex(index:int):void {
      selectedButton = (_buttons[index]) ? _buttons[index] : null;
    }
    
    public function get selectedButton():Button {
      return _selectedButton;
    }
    
    public function set selectedButton(value:Button):void {
      if (value !== _selectedButton) {
        _selectedButton = value;
        var i:int = _buttons.length;
        var button:Button;
        while (i--) {
          button = _buttons[i];
          button.selected = (button === _selectedButton);
        }
      }
    }
    
    public function get enabled():Boolean {
      return _enabled;
    }
    
    public function set enabled(value:Boolean):void {
      _enabled = value;
      var i:int = _buttons.length;
      while (i--) {
        _buttons[i].enabled = _enabled;
      }
    }
    
    public function get buttons():Array {
      return _buttons;
    }
    
    public function ButtonGroup(...buttons:Array) {
      _buttons = [];
      for (var i:int = 0, len:int = buttons.length, button:Button; i < len; ++i) {
        button = buttons[i];
        register(button);
      }
      _selectedButton = null;
      _enabled = true;
    }
    
    public function register(button:Button):void {
      button.autoSelect = true;
      button.addEventListener(Event.SELECT, _select);
      _buttons.push(button);
    }
    
    private function _select(e:Event):void {
      var prev:Button = _selectedButton;
      selectedButton = e.currentTarget as Button;
      if (_selectedButton !== prev) {
        dispatchEvent(new ButtonGroupEvent(ButtonGroupEvent.SELECTED_CHANGE, false, false, selectedIndex, _selectedButton));
      }
    }
    
  }
}