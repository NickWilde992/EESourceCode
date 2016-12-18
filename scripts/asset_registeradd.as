package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import adobe.utils.*;
   import flash.geom.Matrix3D;
   
   public dynamic class asset_registeradd extends MovieClip
   {
       
      
      public var __id0_:MovieClip;
      
      public var btnKongregate:SimpleButton;
      
      public var btnRegister:asset_registerbtnguest;
      
      public var __animFactory___id0_af1:AnimatorFactory3D;
      
      public var __animArray___id0_af1:Array;
      
      public var ____motion___id0_af1_mat3DVec__:Vector.<Number>;
      
      public var ____motion___id0_af1_matArray__:Array;
      
      public var __motion___id0_af1:MotionBase;
      
      public function asset_registeradd()
      {
         super();
         addFrameScript(0,this.frame1);
         if(this.__animFactory___id0_af1 == null)
         {
            this.__animArray___id0_af1 = new Array();
            this.__motion___id0_af1 = new MotionBase();
            this.__motion___id0_af1.duration = 2;
            this.__motion___id0_af1.overrideTargetTransform();
            this.__motion___id0_af1.addPropertyArray("blendMode",["normal","normal"]);
            this.__motion___id0_af1.addPropertyArray("cacheAsBitmap",[false,false]);
            this.__motion___id0_af1.addPropertyArray("opaqueBackground",[null,null]);
            this.__motion___id0_af1.addPropertyArray("visible",[true,true]);
            this.__motion___id0_af1.is3D = true;
            this.__motion___id0_af1.motion_internal::spanStart = 0;
            this.____motion___id0_af1_matArray__ = new Array();
            this.____motion___id0_af1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion___id0_af1_mat3DVec__[0] = 0.787837;
            this.____motion___id0_af1_mat3DVec__[1] = -0.092297;
            this.____motion___id0_af1_mat3DVec__[2] = 0.050487;
            this.____motion___id0_af1_mat3DVec__[3] = 0;
            this.____motion___id0_af1_mat3DVec__[4] = 0.07867;
            this.____motion___id0_af1_mat3DVec__[5] = 0.342879;
            this.____motion___id0_af1_mat3DVec__[6] = -0.600797;
            this.____motion___id0_af1_mat3DVec__[7] = 0;
            this.____motion___id0_af1_mat3DVec__[8] = 0.068924;
            this.____motion___id0_af1_mat3DVec__[9] = 0.862536;
            this.____motion___id0_af1_mat3DVec__[10] = 0.50128;
            this.____motion___id0_af1_mat3DVec__[11] = 0;
            this.____motion___id0_af1_mat3DVec__[12] = 14.762793;
            this.____motion___id0_af1_mat3DVec__[13] = 98.453941;
            this.____motion___id0_af1_mat3DVec__[14] = 43.809746;
            this.____motion___id0_af1_mat3DVec__[15] = 1;
            this.____motion___id0_af1_matArray__.push(new Matrix3D(this.____motion___id0_af1_mat3DVec__));
            this.____motion___id0_af1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion___id0_af1_mat3DVec__[0] = 0.758465;
            this.____motion___id0_af1_mat3DVec__[1] = -0.088856;
            this.____motion___id0_af1_mat3DVec__[2] = 0.048605;
            this.____motion___id0_af1_mat3DVec__[3] = 0;
            this.____motion___id0_af1_mat3DVec__[4] = 0.086345;
            this.____motion___id0_af1_mat3DVec__[5] = 0.376327;
            this.____motion___id0_af1_mat3DVec__[6] = -0.659406;
            this.____motion___id0_af1_mat3DVec__[7] = 0;
            this.____motion___id0_af1_mat3DVec__[8] = 0.068924;
            this.____motion___id0_af1_mat3DVec__[9] = 0.862536;
            this.____motion___id0_af1_mat3DVec__[10] = 0.50128;
            this.____motion___id0_af1_mat3DVec__[11] = 0;
            this.____motion___id0_af1_mat3DVec__[12] = 27.55957;
            this.____motion___id0_af1_mat3DVec__[13] = 74.595474;
            this.____motion___id0_af1_mat3DVec__[14] = 49.926857;
            this.____motion___id0_af1_mat3DVec__[15] = 1;
            this.____motion___id0_af1_matArray__.push(new Matrix3D(this.____motion___id0_af1_mat3DVec__));
            this.__motion___id0_af1.addPropertyArray("matrix3D",this.____motion___id0_af1_matArray__);
            this.__animArray___id0_af1.push(this.__motion___id0_af1);
            this.__animFactory___id0_af1 = new AnimatorFactory3D(null,this.__animArray___id0_af1);
            this.__animFactory___id0_af1.addTargetInfo(this,"__id0_",0,true,0,true,null,-1);
         }
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
