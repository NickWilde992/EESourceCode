package
{
   import flash.display.BitmapData;
   import items.ItemManager;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import items.ItemBrick;
   import items.ItemAuraShape;
   
   public class ImageUtils
   {
       
      
      public function ImageUtils()
      {
         super();
      }
      
      public static function createImageForSmileyAndBlocks(param1:String, param2:int) : BitmapData
      {
         var _loc3_:BitmapData = ItemManager.getSmileyById(param2).bmd;
         var _loc4_:BitmapData = createBricksImageFromPayVaultId(param1);
         var _loc5_:BitmapData = new BitmapData(_loc3_.width + _loc4_.width,26,true,0);
         _loc5_.copyPixels(_loc3_,new Rectangle(0,0,26,26),new Point(0,0));
         _loc5_.copyPixels(_loc4_,new Rectangle(0,0,_loc4_.width,16),new Point(26,5));
         return _loc5_;
      }
      
      public static function createBricksImageFromPayVaultId(param1:String) : BitmapData
      {
         var _loc2_:Vector.<ItemBrick> = ItemManager.getBricksByPayVaultId(param1);
         if(_loc2_.length > 0)
         {
            if(_loc2_.length > 1)
            {
               return createImageFromBrickArray(_loc2_);
            }
            return _loc2_[0].bmd;
         }
         return null;
      }
      
      public static function createAuraShapeImageFromPayVaultId(param1:String) : BitmapData
      {
         var _loc2_:ItemAuraShape = ItemManager.getAuraShapeByPayVaultId(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.auras[0].bmd;
      }
      
      private static function createImageFromBrickArray(param1:Vector.<ItemBrick>) : BitmapData
      {
         var _loc2_:int = 9 * 16;
         var _loc3_:BitmapData = new BitmapData(param1.length * 16 > _loc2_?int(_loc2_):int(param1.length * 16),param1.length * 16 > _loc2_?param1.length * 16 > _loc2_ * 2?param1.length * 16 > _loc2_ * 3?64:48:32:16,true,0);
         var _loc4_:int = 0;
         var _loc5_:int = -16;
         var _loc6_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = _loc5_ + 16;
            if(_loc5_ >= _loc2_)
            {
               _loc5_ = 0;
               _loc6_ = _loc6_ + 16;
            }
            _loc3_.copyPixels(param1[_loc4_].bmd,new Rectangle(0,0,16,16),new Point(_loc5_,_loc6_));
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
