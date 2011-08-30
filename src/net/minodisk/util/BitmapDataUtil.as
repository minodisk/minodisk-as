package net.minodisk.util {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.geom.Matrix;
  
  public class BitmapDataUtil {
    
    static public function resize(src:BitmapData, width:Number, height:Number):BitmapData {
      var bitmap:Bitmap = new Bitmap(src, 'auto', true);
      bitmap.width = width;
      bitmap.height = height;
      var tmp:Sprite = new Sprite();
      tmp.addChild(bitmap);
      var dst:BitmapData = new BitmapData(width, height, true, 0);
      dst.draw(tmp, null, null, null, null, true);
      return dst;
      
      /*var matrix:Matrix = new Matrix();
      matrix.scale(width / src.width, height / src.height);
      var dst:BitmapData = new BitmapData(width, height, true, 0);
      dst.draw(src, matrix, null, null, null, true);
      return dst;*/
    }
    
  }
}