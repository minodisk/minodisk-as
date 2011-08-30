package net.minodisk.scene {
  import flash.display.DisplayObjectContainer;
  import org.libspark.betweenas3.tweens.ITween;
  
  public interface IScene {
    
    function get id():String;
    
    function getStartTween():ITween;
    function getStopTween():ITween;
    
    function initialize():void;
    function finalize():void;
    
  }
}