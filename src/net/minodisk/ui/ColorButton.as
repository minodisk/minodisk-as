package net.minodisk.ui {
  import com.quasimondo.geom.ColorMatrix;
  import flash.display.DisplayObject;
  import flash.display.MovieClip;
  import org.libspark.betweenas3.BetweenAS3;
  import org.libspark.betweenas3.tweens.ITween;
	
	public class ColorButton extends Button {
    
    public var outMatrix:ColorMatrix;
    public var overMatrix:ColorMatrix;
    public var downMatrix:ColorMatrix;
    public var selectMatrix:ColorMatrix;
    public var disableMatrix:ColorMatrix;
    
    public var background:MovieClip;
    
    protected var _tween:ITween;
		
		public function ColorButton(outMatrix:ColorMatrix = null, overMatrix:ColorMatrix = null, downMatrix:ColorMatrix = null,
      selectMatrix:ColorMatrix = null, disableMatrix:ColorMatrix = null) {
      if (!outMatrix) {
        outMatrix = new ColorMatrix();
      }
      if (!overMatrix) {
        overMatrix = new ColorMatrix();
        overMatrix.adjustBrightness(.1);
      }
      if (!downMatrix) {
        downMatrix = new ColorMatrix();
        downMatrix.adjustBrightness( -.1);
      }
      if (!selectMatrix) {
        selectMatrix = new ColorMatrix();
        selectMatrix.adjustSaturation(.2);
      }
      if (!disableMatrix) {
        disableMatrix = new ColorMatrix();
        disableMatrix.adjustColor(0, 0, .5, 0);
      }
      this.outMatrix = outMatrix;
      this.overMatrix = overMatrix;
      this.downMatrix = downMatrix;
      this.selectMatrix = selectMatrix;
      this.disableMatrix = disableMatrix;
			super();
		}
    
    override protected function _updateTo(newStatus:String):void {
      if (_tween && _tween.isPlaying) {
        _tween.stop();
      }
      var time:Number = (newStatus === OVER) ? .2 : .1;
      var tweens:Array = [];
      try {
        tweens = [
          BetweenAS3.to(
            (background) ? background : this, {
              _colorMatrixFilter: {
                matrix: this[newStatus + 'Matrix'].matrix
              }
            }, time
          )
        ];
      } catch (err:Error) {
        trace(this, this[newStatus + 'Matrix']);
        tweens = [];
      }
      _tween = BetweenAS3.parallelTweens(tweens);
      _tween.play();
    }
		
	}
}