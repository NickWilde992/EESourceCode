package utilities
{
   public class ColorUtil
   {
      
      private static var hexArray:Array = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
       
      
      public function ColorUtil()
      {
         super();
      }
      
      public static function DecimalToHex(param1:Number, param2:Boolean = true) : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Number = param1;
         var _loc4_:String = "";
         while(Math.floor(_loc3_) != 0)
         {
            _loc3_ = _loc3_ / 16;
            _loc6_ = (_loc3_ - Math.floor(_loc3_)) * 16;
            _loc4_ = _loc4_ + hexArray[_loc6_];
         }
         var _loc5_:Array = _loc4_.split("");
         _loc5_.reverse();
         _loc4_ = _loc5_.join("");
         if(param2)
         {
            if(_loc4_.length == 8)
            {
               _loc4_ = _loc4_.slice(2,8);
            }
            if(_loc4_.length < 6)
            {
               _loc7_ = _loc4_.length;
               while(_loc7_ < 6)
               {
                  _loc4_ = "0" + _loc4_;
                  _loc7_++;
               }
            }
         }
         return _loc4_;
      }
   }
}
