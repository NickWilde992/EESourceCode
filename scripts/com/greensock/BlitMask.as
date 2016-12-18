package com.greensock
{
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import flash.geom.Matrix;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.geom.Transform;
   
   public class BlitMask extends Sprite
   {
      
      protected static var _colorTransform:ColorTransform = new ColorTransform();
      
      protected static var _mouseEvents:Array = [MouseEvent.CLICK,MouseEvent.DOUBLE_CLICK,MouseEvent.MOUSE_DOWN,MouseEvent.MOUSE_MOVE,MouseEvent.MOUSE_OUT,MouseEvent.MOUSE_OVER,MouseEvent.MOUSE_UP,MouseEvent.MOUSE_WHEEL,MouseEvent.ROLL_OUT,MouseEvent.ROLL_OVER];
      
      protected static var _drawRect:Rectangle = new Rectangle();
      
      protected static var _emptyArray:Array = [];
      
      protected static var _destPoint:Point = new Point();
      
      protected static var _tempMatrix:Matrix = new Matrix();
      
      protected static var _sliceRect:Rectangle = new Rectangle();
      
      public static var version:Number = 0.6;
      
      protected static var _tempContainer:Sprite = new Sprite();
       
      
      protected var _bitmapMode:Boolean;
      
      protected var _columns:int;
      
      protected var _fillColor:uint;
      
      protected var _grid:Array;
      
      protected var _wrap:Boolean;
      
      protected var _target:DisplayObject;
      
      protected var _prevRotation:Number;
      
      protected var _rows:int;
      
      protected var _clipRect:Rectangle;
      
      protected var _wrapOffsetX:Number = 0;
      
      protected var _wrapOffsetY:Number = 0;
      
      protected var _height:Number;
      
      protected var _width:Number;
      
      protected var _gridSize:int = 2879;
      
      protected var _bounds:Rectangle;
      
      protected var _bd:BitmapData;
      
      protected var _scaleX:Number;
      
      protected var _scaleY:Number;
      
      protected var _prevMatrix:Matrix;
      
      protected var _transform:Transform;
      
      protected var _smoothing:Boolean;
      
      protected var _autoUpdate:Boolean;
      
      public function BlitMask(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:Number = 100, param5:Number = 100, param6:Boolean = false, param7:Boolean = false, param8:uint = 0, param9:Boolean = false)
      {
         super();
         if(param4 < 0 || param5 < 0)
         {
            throw new Error("A FlexBlitMask cannot have a negative width or height.");
         }
         _width = param4;
         _height = param5;
         _scaleX = _scaleY = 1;
         _smoothing = param6;
         _fillColor = param8;
         _autoUpdate = param7;
         _wrap = param9;
         _grid = [];
         _bounds = new Rectangle();
         if(_smoothing)
         {
            super.x = param2;
            super.y = param3;
         }
         else
         {
            super.x = param2 < 0?Number(param2 - 0.5 >> 0):Number(param2 + 0.5 >> 0);
            super.y = param3 < 0?Number(param3 - 0.5 >> 0):Number(param3 + 0.5 >> 0);
         }
         _clipRect = new Rectangle(0,0,_gridSize + 1,_gridSize + 1);
         _bd = new BitmapData(param4 + 1,param5 + 1,true,_fillColor);
         _bitmapMode = true;
         this.target = param1;
      }
      
      public function disableBitmapMode(param1:Event = null) : void
      {
         this.bitmapMode = false;
      }
      
      public function get wrapOffsetX() : Number
      {
         return _wrapOffsetX;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         if(_width == param1 && _height == param2)
         {
            return;
         }
         if(param1 < 0 || param2 < 0)
         {
            throw new Error("A BlitMask cannot have a negative width or height.");
         }
         if(_bd != null)
         {
            _bd.dispose();
         }
         _width = param1;
         _height = param2;
         _bd = new BitmapData(param1 + 1,param2 + 1,true,_fillColor);
         _render();
      }
      
      public function set wrapOffsetY(param1:Number) : void
      {
         if(_wrapOffsetY != param1)
         {
            _wrapOffsetY = param1;
            if(_bitmapMode)
            {
               _render();
            }
         }
      }
      
      override public function set x(param1:Number) : void
      {
         if(_smoothing)
         {
            super.x = param1;
         }
         else if(param1 >= 0)
         {
            super.x = param1 + 0.5 >> 0;
         }
         else
         {
            super.x = param1 - 0.5 >> 0;
         }
         if(_bitmapMode)
         {
            _render();
         }
      }
      
      override public function set y(param1:Number) : void
      {
         if(_smoothing)
         {
            super.y = param1;
         }
         else if(param1 >= 0)
         {
            super.y = param1 + 0.5 >> 0;
         }
         else
         {
            super.y = param1 - 0.5 >> 0;
         }
         if(_bitmapMode)
         {
            _render();
         }
      }
      
      public function get wrapOffsetY() : Number
      {
         return _wrapOffsetY;
      }
      
      public function set wrap(param1:Boolean) : void
      {
         if(_wrap != param1)
         {
            _wrap = param1;
            if(_bitmapMode)
            {
               _render();
            }
         }
      }
      
      public function get smoothing() : Boolean
      {
         return _smoothing;
      }
      
      public function get target() : DisplayObject
      {
         return _target;
      }
      
      override public function set width(param1:Number) : void
      {
         setSize(param1,_height);
      }
      
      override public function set scaleX(param1:Number) : void
      {
         var _loc2_:Number = _scaleX;
         _scaleX = param1;
         setSize(_width * (_scaleX / _loc2_),_height);
      }
      
      public function dispose() : void
      {
         if(_bd == null)
         {
            return;
         }
         _disposeGrid();
         _bd.dispose();
         _bd = null;
         this.bitmapMode = false;
         this.autoUpdate = false;
         if(_target != null)
         {
            _target.mask = null;
         }
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         this.target = null;
      }
      
      public function get fillColor() : uint
      {
         return _fillColor;
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      public function get scrollX() : Number
      {
         return (super.x - _bounds.x) / (_bounds.width - _width);
      }
      
      public function get scrollY() : Number
      {
         return (super.y - _bounds.y) / (_bounds.height - _height);
      }
      
      override public function set scaleY(param1:Number) : void
      {
         var _loc2_:Number = _scaleY;
         _scaleY = param1;
         setSize(_width,_height * (_scaleY / _loc2_));
      }
      
      public function set target(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         if(_target != param1)
         {
            _loc2_ = _mouseEvents.length;
            if(_target != null)
            {
               while(--_loc2_ > -1)
               {
                  _target.removeEventListener(_mouseEvents[_loc2_],_mouseEventPassthrough);
               }
            }
            _target = param1;
            if(_target != null)
            {
               _loc2_ = _mouseEvents.length;
               while(--_loc2_ > -1)
               {
                  _target.addEventListener(_mouseEvents[_loc2_],_mouseEventPassthrough,false,0,true);
               }
               _prevMatrix = null;
               _transform = _target.transform;
               _bitmapMode = !_bitmapMode;
               this.bitmapMode = !_bitmapMode;
            }
            else
            {
               _bounds = new Rectangle();
            }
         }
      }
      
      protected function _render(param1:Number = 0, param2:Number = 0, param3:Boolean = true, param4:Boolean = false) : void
      {
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:int = 0;
         var _loc19_:BitmapData = null;
         if(param3)
         {
            _sliceRect.x = _sliceRect.y = 0;
            _sliceRect.width = _width + 1;
            _sliceRect.height = _height + 1;
            _bd.fillRect(_sliceRect,_fillColor);
            if(_bitmapMode && _target != null)
            {
               this.filters = _target.filters;
               this.transform.colorTransform = _transform.colorTransform;
            }
            else
            {
               this.filters = _emptyArray;
               this.transform.colorTransform = _colorTransform;
            }
         }
         if(_bd == null)
         {
            return;
         }
         if(_rows == 0)
         {
            _captureTargetBitmap();
         }
         var _loc5_:Number = super.x + param1;
         var _loc6_:Number = super.y + param2;
         var _loc7_:* = _bounds.width + _wrapOffsetX + 0.5 >> 0;
         var _loc8_:* = _bounds.height + _wrapOffsetY + 0.5 >> 0;
         var _loc9_:Graphics = this.graphics;
         if(_bounds.width == 0 || _bounds.height == 0 || _wrap && (_loc7_ == 0 || _loc8_ == 0) || !_wrap && (_loc5_ + _width < _bounds.x || _loc6_ + _height < _bounds.y || _loc5_ > _bounds.right || _loc6_ > _bounds.bottom))
         {
            _loc9_.clear();
            _loc9_.beginBitmapFill(_bd);
            _loc9_.drawRect(0,0,_width,_height);
            _loc9_.endFill();
            return;
         }
         var _loc10_:int = int((_loc5_ - _bounds.x) / _gridSize);
         if(_loc10_ < 0)
         {
            _loc10_ = 0;
         }
         var _loc11_:int = int((_loc6_ - _bounds.y) / _gridSize);
         if(_loc11_ < 0)
         {
            _loc11_ = 0;
         }
         var _loc12_:int = int((_loc5_ + _width - _bounds.x) / _gridSize);
         if(_loc12_ >= _columns)
         {
            _loc12_ = _columns - 1;
         }
         var _loc13_:uint = int((_loc6_ + _height - _bounds.y) / _gridSize);
         if(_loc13_ >= _rows)
         {
            _loc13_ = _rows - 1;
         }
         var _loc14_:Number = (_bounds.x - _loc5_) % 1;
         var _loc15_:Number = (_bounds.y - _loc6_) % 1;
         if(_loc6_ <= _bounds.y)
         {
            _destPoint.y = _bounds.y - _loc6_ >> 0;
            _sliceRect.y = -1;
         }
         else
         {
            _destPoint.y = 0;
            _sliceRect.y = Math.ceil(_loc6_ - _bounds.y) - _loc11_ * _gridSize - 1;
            if(param3 && _loc15_ != 0)
            {
               _loc15_ = _loc15_ + 1;
            }
         }
         if(_loc5_ <= _bounds.x)
         {
            _destPoint.x = _bounds.x - _loc5_ >> 0;
            _sliceRect.x = -1;
         }
         else
         {
            _destPoint.x = 0;
            _sliceRect.x = Math.ceil(_loc5_ - _bounds.x) - _loc10_ * _gridSize - 1;
            if(param3 && _loc14_ != 0)
            {
               _loc14_ = _loc14_ + 1;
            }
         }
         if(_wrap && param3)
         {
            _render(Math.ceil((_bounds.x - _loc5_) / _loc7_) * _loc7_,Math.ceil((_bounds.y - _loc6_) / _loc8_) * _loc8_,false,false);
         }
         else if(_rows != 0)
         {
            _loc16_ = _destPoint.x;
            _loc17_ = _sliceRect.x;
            _loc18_ = _loc10_;
            while(_loc11_ <= _loc13_)
            {
               _loc19_ = _grid[_loc11_][0];
               _sliceRect.height = _loc19_.height - _sliceRect.y;
               _destPoint.x = _loc16_;
               _sliceRect.x = _loc17_;
               _loc10_ = _loc18_;
               while(_loc10_ <= _loc12_)
               {
                  _loc19_ = _grid[_loc11_][_loc10_];
                  _sliceRect.width = _loc19_.width - _sliceRect.x;
                  _bd.copyPixels(_loc19_,_sliceRect,_destPoint);
                  _destPoint.x = _destPoint.x + (_sliceRect.width - 1);
                  _sliceRect.x = 0;
                  _loc10_++;
               }
               _destPoint.y = _destPoint.y + (_sliceRect.height - 1);
               _sliceRect.y = 0;
               _loc11_++;
            }
         }
         if(param3)
         {
            _tempMatrix.tx = _loc14_ - 1;
            _tempMatrix.ty = _loc15_ - 1;
            _loc9_.clear();
            _loc9_.beginBitmapFill(_bd,_tempMatrix,false,_smoothing);
            _loc9_.drawRect(0,0,_width,_height);
            _loc9_.endFill();
         }
         else if(_wrap)
         {
            if(_loc5_ + _width > _bounds.right)
            {
               _render(param1 - _loc7_,param2,false,true);
            }
            if(!param4 && _loc6_ + _height > _bounds.bottom)
            {
               _render(param1,param2 - _loc8_,false,false);
            }
         }
      }
      
      public function set autoUpdate(param1:Boolean) : void
      {
         if(_autoUpdate != param1)
         {
            _autoUpdate = param1;
            if(_bitmapMode && _autoUpdate)
            {
               this.addEventListener(Event.ENTER_FRAME,update,false,-10,true);
            }
            else
            {
               this.removeEventListener(Event.ENTER_FRAME,update);
            }
         }
      }
      
      public function set fillColor(param1:uint) : void
      {
         if(_fillColor != param1)
         {
            _fillColor = param1;
            if(_bitmapMode)
            {
               _render();
            }
         }
      }
      
      protected function _captureTargetBitmap() : void
      {
         var _loc10_:BitmapData = null;
         var _loc11_:Number = NaN;
         var _loc13_:int = 0;
         if(_bd == null || _target == null)
         {
            return;
         }
         _disposeGrid();
         var _loc1_:DisplayObject = _target.mask;
         if(_loc1_ != null)
         {
            _target.mask = null;
         }
         var _loc2_:Rectangle = _target.scrollRect;
         if(_loc2_ != null)
         {
            _target.scrollRect = null;
         }
         var _loc3_:Array = _target.filters;
         if(_loc3_.length != 0)
         {
            _target.filters = _emptyArray;
         }
         _grid = [];
         if(_target.parent == null)
         {
            _tempContainer.addChild(_target);
         }
         _bounds = _target.getBounds(_target.parent);
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         _columns = Math.ceil(_bounds.width / _gridSize);
         _rows = Math.ceil(_bounds.height / _gridSize);
         var _loc6_:Number = 0;
         var _loc7_:Matrix = _transform.matrix;
         var _loc8_:Number = _loc7_.tx - _bounds.x;
         var _loc9_:Number = _loc7_.ty - _bounds.y;
         if(!_smoothing)
         {
            _loc8_ = _loc8_ + 0.5 >> 0;
            _loc9_ = _loc9_ + 0.5 >> 0;
         }
         var _loc12_:int = 0;
         while(_loc12_ < _rows)
         {
            _loc5_ = _bounds.height - _loc6_ > _gridSize?Number(_gridSize):Number(_bounds.height - _loc6_);
            _loc7_.ty = -_loc6_ + _loc9_;
            _loc11_ = 0;
            _grid[_loc12_] = [];
            _loc13_ = 0;
            while(_loc13_ < _columns)
            {
               _loc4_ = _bounds.width - _loc11_ > _gridSize?Number(_gridSize):Number(_bounds.width - _loc11_);
               _grid[_loc12_][_loc13_] = _loc10_ = new BitmapData(_loc4_ + 1,_loc5_ + 1,true,_fillColor);
               _loc7_.tx = -_loc11_ + _loc8_;
               _loc10_.draw(_target,_loc7_,null,null,_clipRect,_smoothing);
               _loc11_ = _loc11_ + _loc4_;
               _loc13_++;
            }
            _loc6_ = _loc6_ + _loc5_;
            _loc12_++;
         }
         if(_target.parent == _tempContainer)
         {
            _tempContainer.removeChild(_target);
         }
         if(_loc1_ != null)
         {
            _target.mask = _loc1_;
         }
         if(_loc2_ != null)
         {
            _target.scrollRect = _loc2_;
         }
         if(_loc3_.length != 0)
         {
            _target.filters = _loc3_;
         }
      }
      
      override public function get scaleY() : Number
      {
         return 1;
      }
      
      public function update(param1:Event = null, param2:Boolean = false) : void
      {
         var _loc3_:Matrix = null;
         if(_bd == null)
         {
            return;
         }
         if(_target == null)
         {
            _render();
         }
         else if(_target.parent)
         {
            _bounds = _target.getBounds(_target.parent);
            if(this.parent != _target.parent)
            {
               _target.parent.addChildAt(this,_target.parent.getChildIndex(_target));
            }
         }
         if(_bitmapMode || param2)
         {
            _loc3_ = _transform.matrix;
            if(param2 || _prevMatrix == null || _loc3_.a != _prevMatrix.a || _loc3_.b != _prevMatrix.b || _loc3_.c != _prevMatrix.c || _loc3_.d != _prevMatrix.d)
            {
               _captureTargetBitmap();
               _render();
            }
            else if(_loc3_.tx != _prevMatrix.tx || _loc3_.ty != _prevMatrix.ty)
            {
               _render();
            }
            else if(_bitmapMode && _target != null)
            {
               this.filters = _target.filters;
               this.transform.colorTransform = _transform.colorTransform;
            }
            _prevMatrix = _loc3_;
         }
      }
      
      public function get wrap() : Boolean
      {
         return _wrap;
      }
      
      protected function _disposeGrid() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc1_:int = _grid.length;
         while(--_loc1_ > -1)
         {
            _loc3_ = _grid[_loc1_];
            _loc2_ = _loc3_.length;
            while(--_loc2_ > -1)
            {
               BitmapData(_loc3_[_loc2_]).dispose();
            }
         }
      }
      
      public function normalizePosition() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(_target && _bounds)
         {
            _loc1_ = _bounds.width + _wrapOffsetX + 0.5 >> 0;
            _loc2_ = _bounds.height + _wrapOffsetY + 0.5 >> 0;
            _loc3_ = (_bounds.x - this.x) % _loc1_;
            _loc4_ = (_bounds.y - this.y) % _loc2_;
            if(_loc3_ > (_width + _wrapOffsetX) / 2)
            {
               _loc3_ = _loc3_ - _loc1_;
            }
            else if(_loc3_ < (_width + _wrapOffsetX) / -2)
            {
               _loc3_ = _loc3_ + _loc1_;
            }
            if(_loc4_ > (_height + _wrapOffsetY) / 2)
            {
               _loc4_ = _loc4_ - _loc2_;
            }
            else if(_loc4_ < (_height + _wrapOffsetY) / -2)
            {
               _loc4_ = _loc4_ + _loc2_;
            }
            _target.x = _target.x + (this.x + _loc3_ - _bounds.x);
            _target.y = _target.y + (this.y + _loc4_ - _bounds.y);
         }
      }
      
      public function get autoUpdate() : Boolean
      {
         return _autoUpdate;
      }
      
      override public function set height(param1:Number) : void
      {
         setSize(_width,param1);
      }
      
      override public function get width() : Number
      {
         return _width;
      }
      
      public function set scrollY(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(_target != null && _target.parent)
         {
            _bounds = _target.getBounds(_target.parent);
            _loc2_ = super.y - (_bounds.height - _height) * param1 - _bounds.y;
            _target.y = _target.y + _loc2_;
            _bounds.y = _bounds.y + _loc2_;
            if(_bitmapMode)
            {
               _render();
            }
         }
      }
      
      protected function _mouseEventPassthrough(param1:MouseEvent) : void
      {
         if(this.mouseEnabled && (!_bitmapMode || this.hitTestPoint(param1.stageX,param1.stageY,false)))
         {
            dispatchEvent(param1);
         }
      }
      
      public function enableBitmapMode(param1:Event = null) : void
      {
         this.bitmapMode = true;
      }
      
      public function set scrollX(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(_target != null && _target.parent)
         {
            _bounds = _target.getBounds(_target.parent);
            _loc2_ = super.x - (_bounds.width - _width) * param1 - _bounds.x;
            _target.x = _target.x + _loc2_;
            _bounds.x = _bounds.x + _loc2_;
            if(_bitmapMode)
            {
               _render();
            }
         }
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         if(_smoothing != param1)
         {
            _smoothing = param1;
            _captureTargetBitmap();
            if(_bitmapMode)
            {
               _render();
            }
         }
      }
      
      public function set bitmapMode(param1:Boolean) : void
      {
         if(_bitmapMode != param1)
         {
            _bitmapMode = param1;
            if(_target != null)
            {
               _target.visible = !_bitmapMode;
               update(null);
               if(_bitmapMode)
               {
                  this.filters = _target.filters;
                  this.transform.colorTransform = _transform.colorTransform;
                  this.blendMode = _target.blendMode;
                  _target.mask = null;
               }
               else
               {
                  this.filters = _emptyArray;
                  this.transform.colorTransform = _colorTransform;
                  this.blendMode = "normal";
                  this.cacheAsBitmap = false;
                  _target.mask = this;
                  if(_wrap)
                  {
                     normalizePosition();
                  }
               }
               if(_bitmapMode && _autoUpdate)
               {
                  this.addEventListener(Event.ENTER_FRAME,update,false,-10,true);
               }
               else
               {
                  this.removeEventListener(Event.ENTER_FRAME,update);
               }
            }
         }
      }
      
      public function get bitmapMode() : Boolean
      {
         return _bitmapMode;
      }
      
      public function set wrapOffsetX(param1:Number) : void
      {
         if(_wrapOffsetX != param1)
         {
            _wrapOffsetX = param1;
            if(_bitmapMode)
            {
               _render();
            }
         }
      }
      
      override public function get y() : Number
      {
         return super.y;
      }
      
      override public function get scaleX() : Number
      {
         return 1;
      }
      
      override public function set rotation(param1:Number) : void
      {
         if(param1 != 0)
         {
            throw new Error("Cannot set the rotation of a BlitMask to a non-zero number. BlitMasks should remain unrotated.");
         }
      }
      
      override public function get x() : Number
      {
         return super.x;
      }
   }
}
