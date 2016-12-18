package data
{
   import flash.display.BitmapData;
   
   public class ShopItemData
   {
      
      public static const TYPE_SMILEY:String = "smiley";
      
      public static const TYPE_BRICK:String = "brick";
      
      public static const TYPE_WORLD:String = "world";
      
      public static const TYPE_AURA_COLOR:String = "auraColor";
      
      public static const TYPE_AURA_SHAPE:String = "auraShape";
      
      public static const TYPE_OTHER:String = "other";
      
      public static const TYPE_CREW:String = "crew";
      
      public static const TYPE_GOLD:String = "gold";
      
      public static const TYPE_SERVICE:String = "service";
       
      
      public var id:String;
      
      public var priceEnergy:int;
      
      public var priceEnergyClick:int;
      
      public var priceGems:int;
      
      public var priceUSD:int;
      
      public var energyUsed:int = 0;
      
      public var owned_count:int;
      
      public var isPlayerWorldOnly:Boolean;
      
      public var isOnSale:Boolean;
      
      public var isNew:Boolean;
      
      public var isFeatured:Boolean;
      
      public var isGridFeatured:Boolean;
      
      public var isClassic:Boolean;
      
      public var isDevOnly:Boolean;
      
      public var isCrewOnly:Boolean;
      
      public var isService:Boolean;
      
      public var reusable:Boolean;
      
      public var maxPurchases:int;
      
      public var ownedInPayvault:Boolean;
      
      public var span:int = 1;
      
      public var text_header:String = "";
      
      public var text_body:String = "";
      
      public var text_label:String = "";
      
      public var label_color:uint;
      
      public var glow_color:int = 7769269;
      
      public var bitmapsheet_id:String;
      
      public var bitmapsheet_offset:int;
      
      public var type:String;
      
      public var image_bitmap:BitmapData;
      
      public var isDollars:Boolean = false;
      
      public var owned:Boolean;
      
      public var grid_x:int;
      
      public var grid_y:int;
      
      public function ShopItemData(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:String, param10:String, param11:String, param12:int, param13:Boolean, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean, param18:Boolean, param19:Boolean, param20:int, param21:Boolean, param22:int, param23:Boolean, param24:String, param25:String)
      {
         super();
         this.id = param1;
         this.type = param2;
         this.priceEnergy = param3;
         this.priceEnergyClick = param4;
         this.energyUsed = param5;
         this.priceGems = param6;
         this.owned_count = param7;
         this.span = param8;
         this.text_header = param9;
         this.text_body = param10;
         if(param2 == "brick")
         {
            this.bitmapsheet_id = "bricks";
            this.bitmapsheet_offset = 0;
         }
         else if(param2 == "world")
         {
            this.bitmapsheet_id = "worlds";
            this.bitmapsheet_offset = param12;
         }
         else if(param2 == "gold" || param2 == "service" || param2 == "crew")
         {
            this.bitmapsheet_id = "services";
            this.bitmapsheet_offset = param12;
         }
         else
         {
            this.bitmapsheet_id = param11.length > 0?param11:null;
            this.bitmapsheet_offset = param12;
         }
         this.isOnSale = param13;
         this.isFeatured = param14;
         this.isClassic = param15;
         this.isPlayerWorldOnly = param16;
         this.isNew = param17;
         this.isDevOnly = param18;
         this.isGridFeatured = param19;
         this.priceUSD = param20;
         this.reusable = param21;
         this.maxPurchases = param22;
         this.ownedInPayvault = param23;
         this.text_label = param24;
         this.label_color = uint("0x" + param25.substr(1));
      }
      
      public function get label() : String
      {
         if(this.text_label != "")
         {
            return this.text_label;
         }
         if(this.isNew)
         {
            return "new";
         }
         if(this.isOnSale)
         {
            return "sale";
         }
         return null;
      }
   }
}
