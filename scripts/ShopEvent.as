package
{
   import flash.events.Event;
   
   public class ShopEvent extends Event
   {
      
      public static const OPEN_MAINSHOP:String = "open_mainshop";
      
      public static const UPDATE:String = "shop_update";
      
      public static const ITEM_AQUIRED:String = "shop_item_aquired";
       
      
      public var tab:int = 0;
      
      private var _payvaultid:String = "";
      
      public function ShopEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set payvaultId(param1:String) : void
      {
         this._payvaultid = param1;
      }
      
      public function get payvaultId() : String
      {
         return this._payvaultid;
      }
   }
}
