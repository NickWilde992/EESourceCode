package blitter
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.ColorTransform;
   
   public class BlockSprite extends BlSprite
   {
      
      private static var dp:Point = new Point();
       
      
      private var shadowRect:Rectangle;
      
      private var shadowBmd:BitmapData;
      
      private var sprImage:BitmapData;
      
      private var sprImageShadow:BitmapData;
      
      private var currentImage:BitmapData;
      
      private var currentRect:Rectangle;
      
      public function BlockSprite(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6,param7);
         this.bmd = param1;
         rect = new Rectangle(0,0,param4,param5);
         this.shadowRect = new Rectangle(0,0,param4 + 2,param5 + 2);
         this.frames = param6;
         this.offset = param2;
         this.shadow = param7;
         this.width = param4;
         this.height = param5;
         if(param7)
         {
            this.shadowBmd = this.drawWithShadow(bmd);
         }
         updateFrame();
         this.frame = 0;
      }
      
      private function drawWithShadow(param1:BitmapData) : BitmapData
      {
         var _loc4_:BitmapData = null;
         var _loc2_:BitmapData = new BitmapData(frames * (width + 2),height + 2,true,0);
         var _loc3_:int = 0;
         while(_loc3_ < frames)
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
         _loc3_.copyPixels(param1,new Rectangle((offset + param2) * width,0,width,height),new Point(0,0));
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(2,2);
         var _loc5_:BitmapData = new BitmapData(width + 2,height + 2,true,0);
         _loc5_.draw(_loc3_,_loc4_,new ColorTransform(0,0,0,0.3,0,0,0,0));
         _loc5_.draw(_loc3_);
         return _loc5_;
      }
      
      private function getImage(param1:Boolean) : BitmapData
      {
         return !!param1?this.shadowBmd:bmd;
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         dp.x = param2 + x;
         dp.y = param3 + y;
         this.currentImage = !!shadow?this.sprImageShadow:this.sprImage;
         param1.copyPixels(this.currentImage,this.currentImage.rect,dp);
      }
      
      override public function drawPoint(param1:BitmapData, param2:Point, param3:int = 0) : void
      {
         this.currentImage = this.getImage(shadow);
         this.currentRect = !!shadow?new Rectangle(param3 * 18,0,18,18):new Rectangle((offset + param3) * 16,0,16,16);
         param1.copyPixels(this.currentImage,this.currentRect,param2);
      }
   }
}
