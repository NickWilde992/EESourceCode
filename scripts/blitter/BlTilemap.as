package blitter
{
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import items.ItemBrick;
   import items.ItemLayer;
   import items.ItemManager;
   import flash.display.Bitmap;
   
   public class BlTilemap extends BlObject
   {
       
      
      protected var rect:Rectangle;
      
      public var size:int;
      
      protected var hitOffset:int;
      
      protected var hitEnd:int;
      
      public var depth:int = 0;
      
      protected var bmd:BitmapData;
      
      public var realmap:Vector.<Vector.<Vector.<int>>>;
      
      protected var background:Vector.<Vector.<int>>;
      
      protected var decoration:Vector.<Vector.<int>>;
      
      protected var forground:Vector.<Vector.<int>>;
      
      protected var above:Vector.<Vector.<int>>;
      
      public var lastframe:BitmapData;
      
      public function BlTilemap(param1:Bitmap, param2:int = 1, param3:int = 99, param4:int = 121)
      {
         super();
         this.bmd = param1.bitmapData;
         this.rect = new Rectangle(0,0,this.bmd.height,this.bmd.height);
         this.size = this.bmd.height;
         this.hitOffset = param2;
         this.hitEnd = param3;
      }
      
      public function setMapArray(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.depth = param1.length;
         height = param1[0].length;
         width = param1[0][0].length;
         this.background = new Vector.<Vector.<int>>(height);
         this.decoration = new Vector.<Vector.<int>>(height);
         this.forground = new Vector.<Vector.<int>>(height);
         this.above = new Vector.<Vector.<int>>(height);
         var _loc2_:int = 0;
         while(_loc2_ < height)
         {
            this.background[_loc2_] = new Vector.<int>(width);
            this.decoration[_loc2_] = new Vector.<int>(width);
            this.forground[_loc2_] = new Vector.<int>(width);
            this.above[_loc2_] = new Vector.<int>(width);
            _loc2_++;
         }
         this.realmap = new Vector.<Vector.<Vector.<int>>>(this.depth);
         var _loc3_:int = 0;
         while(_loc3_ < this.depth)
         {
            this.realmap[_loc3_] = new Vector.<Vector.<int>>(height);
            _loc4_ = 0;
            while(_loc4_ < height)
            {
               this.realmap[_loc3_][_loc4_] = new Vector.<int>(width);
               _loc5_ = 0;
               while(_loc5_ < width)
               {
                  this.realmap[_loc3_][_loc4_][_loc5_] = param1[_loc3_][_loc4_][_loc5_];
                  this.setMagicTile(_loc3_,_loc5_,_loc4_,param1[_loc3_][_loc4_][_loc5_]);
                  _loc5_++;
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function overlaps(param1:BlObject) : int
      {
         return 0;
      }
      
      protected function setMagicTile(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:ItemBrick = null;
         if(param1 == ItemLayer.BACKGROUND)
         {
            this.background[param3][param2] = param4;
         }
         else
         {
            this.decoration[param3][param2] = 0;
            this.forground[param3][param2] = 0;
            this.above[param3][param2] = 0;
            _loc5_ = ItemManager.bricks[param4];
            if(_loc5_ != null)
            {
               switch(_loc5_.layer)
               {
                  case ItemLayer.BACKGROUND:
                     break;
                  case ItemLayer.DECORATION:
                     this.decoration[param3][param2] = param4;
                     break;
                  case ItemLayer.FORGROUND:
                     this.forground[param3][param2] = param4;
                     break;
                  case ItemLayer.ABOVE:
                     this.above[param3][param2] = param4;
               }
            }
         }
      }
      
      protected function setTile(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.setMagicTile(param1,param2,param3,param4);
         if(this.realmap[param1] != null)
         {
            if(this.realmap[param1][param3] != null)
            {
               this.realmap[param1][param3][param2] = param4;
            }
         }
      }
      
      public function getTile(param1:int, param2:int, param3:int) : int
      {
         if(param1 < 0 || param1 >= this.depth || param2 < 0 || param2 >= width || param3 < 0 || param3 >= height)
         {
            return 0;
         }
         return this.realmap[param1][param3][param2];
      }
      
      public function getTypeCount(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.realmap.length)
         {
            _loc4_ = 0;
            while(_loc4_ < this.realmap[_loc3_].length)
            {
               _loc5_ = this.realmap[_loc3_][_loc4_];
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  if(_loc5_[_loc6_] == param1)
                  {
                     _loc2_++;
                  }
                  _loc6_++;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get image() : Bitmap
      {
         return new Bitmap(this.lastframe);
      }
   }
}
