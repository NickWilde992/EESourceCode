package
{
   import flash.geom.Point;
   
   public class Lookup
   {
       
      
      private var lookup:Object;
      
      private var placerLookup:Object;
      
      private var portalLookup:Object;
      
      private var secretsLookup:Object;
      
      private var blinkLookup:Object;
      
      private var signLookup:Object;
      
      public function Lookup()
      {
         this.lookup = {};
         this.placerLookup = {};
         this.portalLookup = {};
         this.secretsLookup = {};
         this.blinkLookup = {};
         this.signLookup = {};
         super();
      }
      
      public function reset() : void
      {
         this.lookup = {};
         this.placerLookup = {};
         this.portalLookup = {};
         this.blinkLookup = {};
         this.signLookup = {};
         this.resetSecrets();
      }
      
      public function resetSecrets() : void
      {
         this.secretsLookup = {};
      }
      
      public function resetSign(param1:int, param2:int) : void
      {
         this.signLookup[this.getLookupId(param1,param2)] = null;
      }
      
      public function deleteLookup(param1:int, param2:int) : void
      {
         var _loc3_:String = this.getLookupId(param1,param2);
         delete this.lookup[_loc3_];
         delete this.portalLookup[_loc3_];
         delete this.placerLookup[_loc3_];
         delete this.secretsLookup[_loc3_];
         delete this.blinkLookup[_loc3_];
         delete this.signLookup[_loc3_];
      }
      
      public function deleteBlink(param1:int, param2:int) : void
      {
         delete this.blinkLookup[this.getLookupId(param1,param2)];
      }
      
      public function getPlacer(param1:int, param2:int, param3:int) : String
      {
         return this.placerLookup[this.getLookupId(param1,param2) + "x" + param3] || "";
      }
      
      public function setPlacer(param1:int, param2:int, param3:int, param4:String) : void
      {
         this.placerLookup[this.getLookupId(param1,param2) + "x" + param3] = param4;
      }
      
      public function getInt(param1:int, param2:int) : int
      {
         return int(this.getLookup(param1,param2)) || 0;
      }
      
      public function setInt(param1:int, param2:int, param3:int) : void
      {
         this.setLookup(param1,param2,param3);
      }
      
      public function getNumber(param1:int, param2:int) : Number
      {
         return Number(this.getLookup(param1,param2)) || Number(0);
      }
      
      public function setNumber(param1:int, param2:int, param3:Number) : void
      {
         this.setLookup(param1,param2,param3);
      }
      
      public function getBoolean(param1:int, param2:int) : Boolean
      {
         return this.getLookup(param1,param2) || false;
      }
      
      public function setBoolean(param1:int, param2:int, param3:Boolean) : void
      {
         this.setLookup(param1,param2,param3);
      }
      
      public function getText(param1:int, param2:int) : String
      {
         return this.getLookup(param1,param2) || "";
      }
      
      public function getTextSign(param1:int, param2:int) : TextSign
      {
         return this.signLookup[this.getLookupId(param1,param2)] || new TextSign("Undefined",-1);
      }
      
      public function setText(param1:int, param2:int, param3:String) : void
      {
         this.setLookup(param1,param2,param3);
      }
      
      public function setTextSign(param1:int, param2:int, param3:TextSign) : void
      {
         this.signLookup[this.getLookupId(param1,param2)] = param3;
      }
      
      public function getPortal(param1:int, param2:int) : Portal
      {
         return this.portalLookup[this.getLookupId(param1,param2)] || new Portal(0,0,0);
      }
      
      public function setPortal(param1:int, param2:int, param3:Portal) : void
      {
         this.portalLookup[this.getLookupId(param1,param2)] = param3;
      }
      
      public function getPortals(param1:int) : Vector.<Point>
      {
         var _loc3_:* = null;
         var _loc4_:Array = null;
         var _loc2_:Vector.<Point> = new Vector.<Point>();
         for(_loc3_ in this.portalLookup)
         {
            _loc4_ = _loc3_.split("x");
            if(this.portalLookup[_loc3_].id == param1)
            {
               _loc2_.push(new Point(parseInt(_loc4_[0]) << 4,parseInt(_loc4_[1]) << 4));
            }
         }
         return _loc2_;
      }
      
      public function getSecret(param1:int, param2:int) : Boolean
      {
         return this.secretsLookup[this.getLookupId(param1,param2)] || false;
      }
      
      public function setSecret(param1:int, param2:int, param3:Boolean) : void
      {
         this.secretsLookup[this.getLookupId(param1,param2)] = param3;
      }
      
      public function getBlink(param1:int, param2:int) : Number
      {
         return this.blinkLookup[this.getLookupId(param1,param2)];
      }
      
      public function setBlink(param1:int, param2:int, param3:Number) : void
      {
         this.blinkLookup[this.getLookupId(param1,param2)] = param3;
      }
      
      public function isBlink(param1:int, param2:int) : Boolean
      {
         return this.blinkLookup[this.getLookupId(param1,param2)] != null;
      }
      
      public function updateBlink(param1:int, param2:int, param3:Number) : Number
      {
         var _loc4_:Number = this.getBlink(param1,param2);
         var _loc5_:Number = _loc4_ + param3;
         this.setBlink(param1,param2,_loc5_);
         return _loc5_;
      }
      
      private function getLookup(param1:int, param2:int) : *
      {
         return this.lookup[this.getLookupId(param1,param2)];
      }
      
      private function setLookup(param1:int, param2:int, param3:*) : void
      {
         this.lookup[this.getLookupId(param1,param2)] = param3;
      }
      
      private function getLookupId(param1:int, param2:int) : String
      {
         return param1 + "x" + param2;
      }
   }
}
