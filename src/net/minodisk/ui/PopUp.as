package net.minodisk.ui {
  import flash.display.DisplayObjectContainer;
  import flash.display.MovieClip;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import net.minodisk.events.PopUpEvent;
  import net.minodisk.ui.Button;
  import org.libspark.betweenas3.BetweenAS3;
  import org.libspark.betweenas3.events.TweenEvent;
  import org.libspark.betweenas3.tweens.ITween;
  
  [Event(name='opening', type='net.minodisk.events.PopUpEvent')]
  [Event(name='opened', type='net.minodisk.events.PopUpEvent')]
  [Event(name='submit', type='net.minodisk.events.PopUpEvent')]
  [Event(name='cancel', type='net.minodisk.events.PopUpEvent')]
  [Event(name='closing', type='net.minodisk.events.PopUpEvent')]
  [Event(name='closed', type='net.minodisk.events.PopUpEvent')]
	
  public class PopUp extends Component {
    
    public var id:String;
    
    public var closeButton:Button;
    public var foreground:MovieClip;
    public var background:MovieClip;
    public var overlay:MovieClip;
    
    private var _tween:ITween;
    
    public function PopUp() {
      super('closeButton', 'foreground', 'background', 'overlay');
      
      closeButton.alpha = 0;
      foreground.alpha = 0;
      background.alpha = 0;
      overlay.alpha = 0;
      
      closeButton.addEventListener(MouseEvent.CLICK, _close);
      overlay.addEventListener(MouseEvent.CLICK, _close);
      if (foreground.submitButton) {
        foreground.submitButton.addEventListener(MouseEvent.CLICK, _submitClicked);
      }
      if (foreground.cancelButton) {
        foreground.cancelButton.addEventListener(MouseEvent.CLICK, _cancelClicked);
      }
    }
    
    public function open(layer:DisplayObjectContainer):void {
      if (_tween && _tween.isPlaying) {
        _tween.stop();
      }
      _tween = BetweenAS3.serial(
        BetweenAS3.func(_initialize),
        BetweenAS3.addChild(this, layer),
        BetweenAS3.to(
          overlay, {
            alpha: 1
          }, .2
        ),
        BetweenAS3.parallel(
          BetweenAS3.to(
            background, {
              alpha: 1
            }, .2
          ),
          BetweenAS3.to(
            closeButton, {
              alpha: 1
            }, .2
          )
        ),
        BetweenAS3.to(
          foreground, {
            alpha: 1
          }, .2
        )
      );
      _tween.addEventListener(TweenEvent.COMPLETE, _opened);
      _tween.play();
      dispatchEvent(new PopUpEvent(PopUpEvent.OPENING, false, false));
    }
    
    protected function _initialize():void {
    }
    
    private function _opened(e:TweenEvent):void {
      _tween.removeEventListener(TweenEvent.COMPLETE, _opened);
      _tween = null;
      dispatchEvent(new PopUpEvent(PopUpEvent.OPENED, false, false));
    }
    
    public function close():void {
      if (_tween && _tween.isPlaying) {
        _tween.stop();
      }
      _tween = BetweenAS3.serial(
        BetweenAS3.to(
          foreground, {
            alpha: 0
          }, .2
        ),
        BetweenAS3.parallel(
          BetweenAS3.to(
            background, {
              alpha: 0
            }, .2
          ),
          BetweenAS3.to(
            closeButton, {
              alpha: 0
            }, .2
          )
        ),
        BetweenAS3.to(
          overlay, {
            alpha: 0
          }, .2
        ),
        BetweenAS3.removeFromParent(this),
        BetweenAS3.func(_finalize)
      );
      _tween.addEventListener(TweenEvent.COMPLETE, _closed);
      _tween.play();
      dispatchEvent(new PopUpEvent(PopUpEvent.CLOSING, false, false));
    }
    
    protected function _finalize():void {
    }
    
    private function _closed(e:TweenEvent):void {
      _tween.removeEventListener(TweenEvent.COMPLETE, _closed);
      _tween = null;
      dispatchEvent(new PopUpEvent(PopUpEvent.CLOSED, false, false));
    }
    
    
    private function _cancelClicked(e:MouseEvent):void {
      _cancel();
    }
    
    protected function _cancel():void {
      dispatchEvent(new PopUpEvent(PopUpEvent.CANCEL, false, false));
    }
    
    private function _submitClicked(e:MouseEvent):void {
      _submit();
    }
    
    protected function _submit():void {
      dispatchEvent(new PopUpEvent(PopUpEvent.SUBMIT, false, false));
    }
    
    private function _close(e:MouseEvent):void {
      close();
    }
    
  }
}