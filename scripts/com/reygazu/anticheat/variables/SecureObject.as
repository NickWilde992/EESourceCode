package com.reygazu.anticheat.variables
{
   import com.reygazu.anticheat.events.CheatManagerEvent;
   import com.reygazu.anticheat.managers.CheatManager;
   
   public dynamic class SecureObject
   {
       
      
      private var id:String;
      
      private var _name:String;
      
      public function SecureObject(param1:String = "Unnamed SecureObject")
      {
         super();
         this._name = param1;
         this.hop();
         CheatManager.getInstance().addEventListener(CheatManagerEvent.FORCE_HOP,this.onForceHop);
      }
      
      public function set objectValue(param1:Object) : void
      {
         if(this.hasOwnProperty(this.id))
         {
            delete this[this.id];
         }
         this.hop();
         this[this.id] = param1;
         this["fake"] = param1;
      }
      
      public function get objectValue() : Object
      {
         return this[this.id];
      }
      
      private function hop() : void
      {
         var _loc1_:String = this.id;
         while(this.id == _loc1_)
         {
            this.id = String(Math.round(Math.random() * 1048575));
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      private function onForceHop(param1:CheatManagerEvent) : void
      {
         var _loc2_:Object = this.objectValue;
         this.objectValue = _loc2_;
      }
   }
}
