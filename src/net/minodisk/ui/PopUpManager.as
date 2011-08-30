package net.minodisk.ui {
  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import net.minodisk.core.Manager;
  import net.minodisk.events.PopUpEvent;
	
  public class PopUpManager extends Manager {
    
    private var _layer:DisplayObjectContainer;
    private var _currentPopUp:PopUp;
    
    public function get currentPopUp():PopUp {
      return _currentPopUp;
    }
    
    public function PopUpManager(layer:DisplayObjectContainer, ...popUps:Array) {
      super(popUps);
      _layer = layer;
    }
    
    public function open(popUpId:String):void {
      var next:PopUp = _list[popUpId];
      if (_currentPopUp && next !== currentPopUp) {
        close();
      }
      _currentPopUp = next;
      _currentPopUp.addEventListener(PopUpEvent.CLOSING, _closed);
      _currentPopUp.open(_layer);
    }
    
    public function close():void {
      _currentPopUp.removeEventListener(PopUpEvent.CLOSING, _closed);
      _currentPopUp.close();
      _currentPopUp = null;
    }
    
    private function _closed(e:Event = null):void {
      _currentPopUp.removeEventListener(PopUpEvent.CLOSING, _closed);
      _currentPopUp = null;
    }
    
  }
}