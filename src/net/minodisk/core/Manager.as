package net.minodisk.core {
	
  public class Manager {
    
    protected var _list:Object;
    
    public function Manager(items:Array) {
      _list = { };
      for (var i:int = 0, len:int = items.length; i < len; ++i) {
        register(items[i]);
      }
    }
    
    public function register(item:Object):void {
      if (!item.hasOwnProperty('id')) {
        throw new Error('Property "id" is not implemented.');
      }
      if (_list.hasOwnProperty(item.id)) {
        throw new Error('ID "' + item.id + '" has already registered.');
      }
      _list[item.id] = item;
    }
    
  }
}