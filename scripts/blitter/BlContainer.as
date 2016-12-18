package blitter
{
   import flash.display.BitmapData;
   
   public class BlContainer extends blitter.BlObject
   {
       
      
      protected var content:Array;
      
      public var target:blitter.BlObject;
      
      public function BlContainer()
      {
         this.content = [];
         super();
      }
      
      public function add(param1:blitter.BlObject) : blitter.BlObject
      {
         this.content.push(param1);
         return param1;
      }
      
      public function addAt(param1:blitter.BlObject, param2:int) : blitter.BlObject
      {
         this.content.splice(param2,0,param1);
         return param1;
      }
      
      public function addBefore(param1:blitter.BlObject, param2:blitter.BlObject) : blitter.BlObject
      {
         var _loc3_:int = 0;
         while(_loc3_ < this.content.length)
         {
            if(this.content[_loc3_] == param2)
            {
               return this.addAt(param1,_loc3_);
            }
            _loc3_++;
         }
         return this.add(param1);
      }
      
      public function remove(param1:blitter.BlObject) : blitter.BlObject
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.content.length)
         {
            if(this.content[_loc2_] === param1)
            {
               this.content.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
         return param1;
      }
      
      public function removeAll() : void
      {
         this.content = [];
      }
      
      public function get children() : Vector.<blitter.BlObject>
      {
         var _loc1_:Vector.<blitter.BlObject> = new Vector.<blitter.BlObject>();
         var _loc2_:int = 0;
         while(_loc2_ < this.content.length)
         {
            _loc1_[_loc2_] = this.content[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function offset(param1:int, param2:int) : void
      {
         this.x = this.x + param1;
         this.y = this.y + param2;
      }
      
      override public function tick() : void
      {
         var _loc1_:blitter.BlObject = null;
         for each(_loc1_ in this.content)
         {
            _loc1_.tick();
         }
         super.tick();
         if(this.target != null)
         {
            this.x = this.x - (this.x - (-this.target.x + Bl.width / 2)) * Config.camera_lag;
            this.y = this.y - (this.y - (-this.target.y + Bl.height / 2)) * Config.camera_lag;
         }
      }
      
      override public function exitFrame() : void
      {
         var _loc1_:blitter.BlObject = null;
         for each(_loc1_ in this.content)
         {
            _loc1_.exitFrame();
         }
      }
      
      override public function enterFrame() : void
      {
         var _loc1_:blitter.BlObject = null;
         for each(_loc1_ in this.content)
         {
            _loc1_.enterFrame();
         }
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         var _loc4_:blitter.BlObject = null;
         for each(_loc4_ in this.content)
         {
            _loc4_.draw(param1,param2 + x,param3 + y);
         }
      }
   }
}
