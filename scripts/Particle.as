package
{
   import flash.display.BitmapData;
   import states.PlayState;
   import items.ItemManager;
   import flash.geom.Point;
   
   public class Particle extends SynchronizedSprite
   {
       
      
      public var life:int = 0;
      
      public var maxlife:int = 0;
      
      public var dir:Number;
      
      public var cx:Number;
      
      public var cy:Number;
      
      public var rd:Boolean;
      
      public var world:World;
      
      private var bm:BitmapData;
      
      public function Particle(param1:World, param2:int, param3:int, param4:int, param5:Number, param6:Number, param7:Number, param8:Number, param9:int, param10:int, param11:Boolean = false)
      {
         this.bm = new BitmapData(5,5);
         this.world = param1;
         ItemManager.sprParticles.frame = param2;
         ItemManager.sprParticles.drawPoint(this.bm,new Point(0,0));
         super(this.bm,5,5);
         this.maxlife = param10;
         this.x = param3;
         this.y = param4;
         this.cx = param3;
         this.cy = param4;
         this.modifierX = param7;
         this.modifierY = param8;
         this.rd = param11;
         this.speedX = param5;
         this.speedY = param6;
         this.mox = 0.5;
         this.moy = 0.5;
         this.dir = param9;
      }
      
      override public function tick() : void
      {
         var _loc2_:PlayState = null;
         super.tick();
         this.life++;
         var _loc1_:Number = this.dir * Math.PI / 180;
         this.cx = this.cx + speedX * Math.cos(_loc1_);
         this.cy = this.cy + speedY * Math.sin(_loc1_);
         this.x = this.cx;
         this.y = this.cy;
         speedX = speedX - modifierX;
         speedY = speedY - modifierY;
         if(speedX < 0 && !this.rd)
         {
            speedX = 0;
         }
         if(speedY < 0 && !this.rd)
         {
            speedY = 0;
         }
         if(this.life >= this.maxlife)
         {
            _loc2_ = Global.base.state as PlayState;
            _loc2_.world.particlecontainer.remove(this);
         }
      }
   }
}
