/*
 * BetweenAS3
 * 
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 BeInteractive! (www.be-interactive.org) and
 *                    Spark project  (www.libspark.org)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */
package org.libspark.betweenas3.core.tweens.actions
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import org.libspark.betweenas3.core.ticker.ITicker;
	import org.libspark.betweenas3.core.tweens.AbstractActionTween;
	
	/**
	 * 指定された DisplayObject の子を全て削除する動作を行うアクショントゥイーンです.
	 * 
	 * @author	minodisk
	 */
	public class RemoveChildrenAction extends AbstractActionTween
	{
		public function RemoveChildrenAction(ticker:ITicker, target:DisplayObjectContainer, children:Array)
		{
			super(ticker);
			
			_target = target;
      _children = children;
		}
		
		private var _target:DisplayObjectContainer;
		private var _children:Array;
    private var _childList:Array;
    
		public function get target():DisplayObject
		{
			return _target;
		}
		
		override protected function action():void 
		{
			if (_target != null && _children != null) {
        var i:int;
        _childList = [];
        if (_children.length === 0) {
          i = _target.numChildren;
          while (i--) {
            _childList[i] = _target.removeChildAt(i);
          }
        } else {
          i = _target.numChildren;
          while (i--) {
            if (_children.indexOf(_target.getChildAt(i)) !== -1) {
              _childList[i] = _target.removeChildAt(i);
            }
          }
        }
			}
		}
		
		override protected function rollback():void 
		{
			if (_target != null && _children != null && _childList != null) {
				var i:int, len:int;
        for (i = 0, len = _childList.length; i < len; ++i) {
          trace(_childList[i]);
          if (_childList[i]) {
            _target.addChildAt(_childList[i], i);
          }
        }
        _childList = null;
			}
		}
	}
}