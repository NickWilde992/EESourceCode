package com.reygazu.anticheat.variables
{
   import com.reygazu.anticheat.managers.CheatManager;
   
   public class SecureInt
   {
       
      
      private var secureData:com.reygazu.anticheat.variables.SecureObject;
      
      private var fake:int;
      
      public function SecureInt(param1:String = "Unnamed SecureInt")
      {
         super();
         this.secureData = new com.reygazu.anticheat.variables.SecureObject(param1);
         this.secureData.objectValue = this.fake;
      }
      
      public function set value(param1:int) : void
      {
         if(this.fake != this.secureData.objectValue)
         {
            CheatManager.getInstance().detectCheat(this.secureData.name,this.fake,this.secureData.objectValue);
         }
         this.secureData.objectValue = param1;
         this.fake = param1;
      }
      
      public function get value() : int
      {
         return this.secureData.objectValue as int;
      }
   }
}
