package
{
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class SynchronizedSprite extends SynchronizedObject
   {
       
      
      protected var rect:Rectangle;
      
      protected var bmd:BitmapData;
      
      protected var size:int;
      
      protected var frames:int;
      
      public function SynchronizedSprite(param1:BitmapData, param2:int = 0, param3:int = 0)
      {
         super();
         this.bmd = param1;
         if(param2 == 0)
         {
            param2 = param1.height;
         }
         this.rect = new Rectangle(0,0,param2,param1.height);
         this.size = param2;
         width = param2;
         height = this.size;
         this.frames = param1.width / this.size;
      }
      
      public function set frame(param1:int) : void
      {
         this.rect.x = param1 * this.size;
      }
      
      public function get frame() : int
      {
         return this.rect.x / this.size;
      }
      
      public function setRectY(param1:int) : void
      {
         this.rect.y = param1;
      }
      
      public function hitTest(param1:int, param2:int) : Boolean
      {
         return param1 >= x && param2 >= y && param1 <= x + this.size && param2 <= y + this.size;
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         param1.copyPixels(this.bmd,this.rect,new Point(x + param2,y + param3));
      }
   }
}
