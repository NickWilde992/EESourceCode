package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class VisiblePlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _progress:int;
      
      protected var _target:Object;
      
      protected var _initVal:Boolean;
      
      protected var _visible:Boolean;
      
      protected var _tween:TweenLite;
      
      public function VisiblePlugin()
      {
         super();
         this.propName = "visible";
         this.overwriteProps = ["visible"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         _target = param1;
         _tween = param3;
         _progress = !!_tween.vars.runBackwards?0:1;
         _initVal = _target.visible;
         _visible = Boolean(param2);
         return true;
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         _target.visible = (param1 == 1 || param1 == 0) && _tween.cachedTime / _tween.cachedDuration == _progress?_visible:_initVal;
      }
   }
}
