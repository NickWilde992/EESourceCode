package data
{
   public class SimplePlayerObject
   {
       
      
      public var loaded:Date;
      
      public var name:String;
      
      public var smiley:int;
      
      public var aura:int;
      
      public var auraColor:int;
      
      public var badge:String = "testbadge";
      
      public var maxEnergy:int;
      
      public var chatbanned:Boolean;
      
      public var haveSmileyPackage:Boolean;
      
      public var isAdministrator:Boolean;
      
      public var isModerator:Boolean;
      
      public var room0:String;
      
      public var betaonlyroom:String;
      
      public var homeworld:String;
      
      public var roomkeys:Array;
      
      public var roomids:Array;
      
      public var rooms:Object;
      
      public var roomnames:Object;
      
      public var roomnamesid:Object;
      
      public var visible:Boolean;
      
      public var banned:Boolean;
      
      public var tutorialVersion:int;
      
      public var accepted_terms:int;
      
      public var confirmedEmail:Boolean;
      
      public var level:int = 1;
      
      public var levelcap_prev:int;
      
      public var levelcap_next:int;
      
      public var leveltitle:String;
      
      public var goldmember:Boolean;
      
      public var goldremain:Number;
      
      public var goldtime:Number;
      
      public var goldwelcome:Boolean;
      
      public var changename:Boolean;
      
      public var favorites:Object;
      
      public var wearsGoldSmiley:Boolean;
      
      public function SimplePlayerObject()
      {
         super();
      }
      
      public function setRooms(param1:Array, param2:Array, param3:Array) : void
      {
         this.roomkeys = param1;
         this.roomids = param2;
         this.rooms = {};
         this.roomnames = {};
         this.roomnamesid = {};
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            this.rooms[param1[_loc4_]] = param2[_loc4_];
            this.roomnames[param1[_loc4_]] = param3[_loc4_];
            this.roomnamesid[param2[_loc4_]] = param3[_loc4_];
            _loc4_++;
         }
      }
      
      public function setFavorites(param1:Array, param2:Array) : void
      {
         this.favorites = {};
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            this.favorites[param1[_loc3_]] = param2[_loc3_];
            _loc3_++;
         }
      }
      
      public function removeFavorite(param1:String) : void
      {
         delete this.favorites[param1];
      }
      
      public function getRoomName(param1:String) : String
      {
         return this.roomnamesid[param1];
      }
      
      public function get goldexpire() : Date
      {
         var _loc1_:Date = new Date();
         _loc1_.time = _loc1_.time + this.goldremain;
         return _loc1_;
      }
      
      public function get goldjoin() : Date
      {
         var _loc1_:Date = new Date();
         _loc1_.time = _loc1_.time + this.goldtime;
         return _loc1_;
      }
   }
}
