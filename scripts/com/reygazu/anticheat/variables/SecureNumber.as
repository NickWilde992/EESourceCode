package com.reygazu.anticheat.variables
{
   import com.reygazu.anticheat.managers.CheatManager;
   
   public class SecureNumber
   {
       
      
      private var secureData:com.reygazu.anticheat.variables.SecureObject;
      
      private var fake:Number;
      
      public function SecureNumber(param1:String = "Unnamed SecureNumber")
      {
         super();
         this.secureData = new com.reygazu.anticheat.variables.SecureObject(param1);
         this.secureData.objectValue = this.fake;
      }
      
      public function set value(param1:Number) : void
      {
         if(this.fake != this.secureData.objectValue && !isNaN(this.secureData.objectValue as Number))
         {
            CheatManager.getInstance().detectCheat(this.secureData.name,this.fake,this.secureData.objectValue);
         }
         this.secureData.objectValue = param1;
         this.fake = param1;
      }
      
      public function get value() : Number
      {
         return this.secureData.objectValue as Number;
      }
   }
}
