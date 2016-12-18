package
{
   import blitter.BlObject;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import blitter.Bl;
   
   public class MiniMap extends BlObject
   {
       
      
      private var bmd:BitmapData;
      
      private var playermap:BitmapData;
      
      private var alphaData:BitmapData;
      
      private var alphaBox:Sprite;
      
      private var ct:ColorTransform;
      
      public function MiniMap(param1:World, param2:int, param3:int)
      {
         super();
         this.bmd = new BitmapData(param2,param3,true,0);
         this.playermap = new BitmapData(param2,param3,true,0);
         this.x = 640 - param2 - 2;
         this.y = 470 - param3 - 2;
         this.ct = new ColorTransform();
         this.alphaBox = new Sprite();
         this.alphaData = new BitmapData(param2,param3,true,0);
         this.setAlpha(Global.minimapAlphaValue);
         this.reset(param1);
      }
      
      public function updatePixel(param1:int, param2:int, param3:Number) : void
      {
         this.bmd.setPixel32(param1,param2,param3);
      }
      
      public function showPlayer(param1:Player, param2:uint) : void
      {
         this.playermap.setPixel32(param1.x >> 4,param1.y >> 4,param2);
      }
      
      public function clear() : void
      {
         this.playermap.colorTransform(this.playermap.rect,new ColorTransform(1,1,1,1 - 1 / 64));
      }
      
      public function reset(param1:World) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.width)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.height)
            {
               this.bmd.setPixel32(_loc2_,_loc3_,param1.getMinimapColor(_loc2_,_loc3_));
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function drawDirect(param1:BitmapData) : void
      {
         param1.copyPixels(this.bmd,this.bmd.rect,new Point(0,0));
      }
      
      public function setAlpha(param1:Number) : void
      {
         this.ct.alphaMultiplier = param1;
         this.alphaBox.graphics.clear();
         this.alphaBox.graphics.beginFill(0,1);
         this.alphaBox.graphics.drawRect(0,0,this.bmd.width,this.bmd.height);
         this.alphaBox.graphics.endFill();
         this.alphaData = new BitmapData(this.bmd.width,this.bmd.height,true,0);
         this.alphaData.draw(this.alphaBox,null,this.ct);
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         var _loc4_:Point = new Point(x,y - 3);
         if(Bl.data.moreisvisible)
         {
            _loc4_.y = y + Bl.data.bselector.y;
            if(this.bmd.width > 150)
            {
               _loc4_.y = _loc4_.y - 15;
            }
         }
         param1.copyPixels(this.bmd,this.bmd.rect,_loc4_,this.alphaData,new Point(),true);
         param1.copyPixels(this.playermap,this.playermap.rect,_loc4_,this.alphaData,new Point(),true);
         this.clear();
      }
   }
}
