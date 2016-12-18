package blitter
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Matrix;
   import flash.geom.ColorTransform;
   
   public class BlSprite extends BlObject
   {
      
      private static var dp:Point = new Point();
       
      
      public var rect:Rectangle;
      
      public var bmd:BitmapData;
      
      private var shadowRect:Rectangle;
      
      private var shadowBmd:BitmapData;
      
      protected var frames:int;
      
      protected var offset:int;
      
      protected var bmdAlpha:BitmapData;
      
      protected var shadow:Boolean;
      
      private var sprImage:BitmapData;
      
      private var sprImageShadow:BitmapData;
      
      private var currentImage:BitmapData;
      
      public function BlSprite(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Boolean = false)
      {
         super();
         this.bmd = param1;
         this.rect = new Rectangle(0,0,param4,param5);
         this.shadowRect = new Rectangle(0,0,param4 + 2,param5 + 2);
         this.frames = param6;
         this.offset = param2;
         this.shadow = param7;
         this.width = param4;
         this.height = param5;
         if(param7)
         {
            this.shadowBmd = this.drawWithShadow(this.bmd);
         }
         this.updateFrame();
         this.frame = 0;
      }
      
      public static function createFromBitmapData(param1:BitmapData) : BlSprite
      {
         return new BlSprite(param1,0,0,param1.width,param1.height,1);
      }
      
      public function updateFrame() : void
      {
         if(this.shadow)
         {
            this.sprImageShadow = this.getImage(true);
         }
         this.sprImage = this.getImage(false);
      }
      
      public function set frame(param1:int) : void
      {
         if(param1 != this.frame)
         {
            this.rect.x = (param1 + this.offset) * width;
            this.shadowRect.x = param1 * (width + 2);
            this.updateFrame();
         }
      }
      
      public function get frame() : int
      {
         return this.rect.x / width - this.offset;
      }
      
      public function get totalFrames() : int
      {
         return this.frames;
      }
      
      public function hitTest(param1:int, param2:int) : Boolean
      {
         return param1 >= x && param2 >= y && param1 <= x + width && param2 <= y + height;
      }
      
      private function drawWithShadow(param1:BitmapData) : BitmapData
      {
         var _loc4_:BitmapData = null;
         var _loc2_:BitmapData = new BitmapData(this.frames * (width + 2),height + 2,true,0);
         var _loc3_:int = 0;
         while(_loc3_ < this.frames)
         {
            _loc4_ = this.drawWithShadowSingle(param1,_loc3_);
            _loc2_.copyPixels(_loc4_,_loc4_.rect,new Point(_loc3_ * (width + 2),0));
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function drawWithShadowSingle(param1:BitmapData, param2:int) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(width,height,true,0);
         _loc3_.copyPixels(param1,new Rectangle((this.offset + param2) * width,0,width,height),new Point(0,0));
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(2,2);
         var _loc5_:BitmapData = new BitmapData(width + 2,height + 2,true,0);
         _loc5_.draw(_loc3_,_loc4_,new ColorTransform(0,0,0,0.3,0,0,0,0));
         _loc5_.draw(_loc3_);
         return _loc5_;
      }
      
      private function getImage(param1:Boolean) : BitmapData
      {
         var _loc2_:int = width;
         var _loc3_:int = height;
         if(param1)
         {
            _loc2_ = _loc2_ + 2;
            _loc3_ = _loc3_ + 2;
         }
         var _loc4_:BitmapData = new BitmapData(_loc2_,_loc3_,true,0);
         _loc4_.copyPixels(!!param1?this.shadowBmd:this.bmd,!!param1?this.shadowRect:this.rect,new Point(0,0));
         return _loc4_;
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         dp.x = param2 + x;
         dp.y = param3 + y;
         this.currentImage = !!this.shadow?this.sprImageShadow:this.sprImage;
         param1.copyPixels(this.currentImage,this.currentImage.rect,dp);
      }
      
      public function drawPoint(param1:BitmapData, param2:Point, param3:int = 0) : void
      {
         this.currentImage = !!this.shadow?this.sprImageShadow:this.sprImage;
         param1.copyPixels(this.currentImage,this.currentImage.rect,param2);
      }
   }
}
