package net.minodisk.scene {
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import net.minodisk.core.Manager;
  import org.libspark.betweenas3.BetweenAS3;
  import org.libspark.betweenas3.tweens.ITween;
	
  public class SceneManager extends Manager {
    
    public var method:String;
    public var delay:Number;
    public var sameSceneEnabled:Boolean;
    
    private var _layer:DisplayObjectContainer;
    private var _currentScene:IScene;
    private var _tween:ITween;
    
    public function get currentScene():IScene {
      return _currentScene;
    }
    
    public function SceneManager(layer:DisplayObjectContainer, ...scenes:Array) {
      super(scenes);
      
      method = 'serial';
      delay = 0;
      sameSceneEnabled = false;
      
      _layer = layer;
    }
    
    public function start(sceneId:String):void {
      if (sceneId !== null && !_list.hasOwnProperty(sceneId)) {
        throw new Error('ID "' + sceneId + '" is not registered.');
      }
      
      var scene:IScene = _list[sceneId];
      if (sameSceneEnabled || scene !== _currentScene) {
        var tweens:Array = [];
        var tween:ITween;
        tweens.push(
          BetweenAS3.func(function ():void {
            _layer.stage.mouseChildren = false;
          })
        );
        if (_currentScene) {
          if ((tween = _currentScene.getStopTween()) !== null) {
            tweens.push(tween);
          }
          tweens.push(
            BetweenAS3.removeFromParent(_currentScene as DisplayObject),
            BetweenAS3.delay(BetweenAS3.func(_currentScene.finalize), 0, delay)
          );
        }
        _currentScene = scene;
        if (_currentScene) {
          tweens.push(
            BetweenAS3.delay(BetweenAS3.func(_currentScene.initialize), delay / 2),
            BetweenAS3.addChild(_currentScene as DisplayObject, _layer)
          );
          if ((tween = _currentScene.getStartTween()) !== null) {
            tweens.push(tween);
          }
        }
        tweens.push(
          BetweenAS3.func(function ():void {
            _layer.stage.mouseChildren = true;
          })
        );
        
        if (_tween && _tween.isPlaying) {
          _tween.stop();
        }
        _tween = BetweenAS3[method + 'Tweens'](tweens);
        _tween.play();
      }
    }
    
    
  }
}