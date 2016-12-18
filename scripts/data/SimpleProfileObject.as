package data
{
   public class SimpleProfileObject
   {
       
      
      public var key:String;
      
      public var smiley:int;
      
      public var roomkeys:Array;
      
      public var roomids:Array;
      
      public var rooms:Object;
      
      public var roomnames:Object;
      
      public var isOldBeta:Boolean;
      
      public var isAdministrator:Boolean;
      
      public var isModerator:Boolean;
      
      public var name:String;
      
      public var oldname:String;
      
      public var status:String;
      
      public var room0:Object;
      
      public var betaonlyroom:Object;
      
      public var goldmember:Boolean;
      
      public var goldremain:Number;
      
      public var goldtime:Number;
      
      public var maxEnergy:int;
      
      public function SimpleProfileObject()
      {
         super();
      }
      
      public function setRooms(param1:Array, param2:Array, param3:Array) : void
      {
         this.roomkeys = param1;
         this.roomids = param2;
         this.rooms = {};
         this.roomnames = {};
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            this.rooms[param1[_loc4_]] = param2[_loc4_];
            this.roomnames[param1[_loc4_]] = param3[_loc4_];
            _loc4_++;
         }
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
