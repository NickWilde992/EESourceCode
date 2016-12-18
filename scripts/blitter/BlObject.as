package blitter
{
   import flash.display.BitmapData;
   
   public class BlObject
   {
       
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      public var width:int = 1;
      
      public var height:int = 1;
      
      public var moving:Boolean = false;
      
      public var hitmap:blitter.BlTilemap;
      
      public function BlObject()
      {
         super();
      }
      
      public function update() : void
      {
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
      }
      
      public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         param1.setPixel(this.x + param2,this.y + param3,16777215);
      }
      
      public function enterFrame() : void
      {
      }
      
      public function tick() : void
      {
         this.update();
      }
      
      public function exitFrame() : void
      {
      }
   }
}
