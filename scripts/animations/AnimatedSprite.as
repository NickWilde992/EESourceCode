package animations
{
   import blitter.BlContainer;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AnimatedSprite extends SynchronizedSprite
   {
       
      
      public var angle:int = 0;
      
      public var speedx:Number = 0;
      
      public var speedy:Number = 0;
      
      public var radius:Number = 0;
      
      public var lifetime:Number = 0;
      
      public var life:Number = 0;
      
      public var cont:BlContainer;
      
      public var d:int = 0;
      
      public function AnimatedSprite(param1:BitmapData, param2:int)
      {
         super(param1,param2);
      }
      
      public function set scale(param1:Number) : void
      {
         frame = Math.round(frames * (1 - param1));
      }
      
      public function get scale() : Number
      {
         return 1 - frame / frames;
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         param1.copyPixels(bmd,rect,new Point(x + param2,y + param3));
         if(this.lifetime > 0)
         {
            this.upd();
         }
      }
      
      public function upd() : void
      {
         if(this.life > this.lifetime)
         {
            this.cont.remove(this);
         }
         this.x = this.x + this.speedx * Math.cos(this.angle);
         this.y = this.y + this.speedy * Math.sin(this.angle);
         this.life++;
      }
   }
}
