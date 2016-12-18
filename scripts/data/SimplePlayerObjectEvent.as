package data
{
   import flash.events.Event;
   
   public class SimplePlayerObjectEvent extends Event
   {
      
      public static const UPDATE:String = "update";
       
      
      public function SimplePlayerObjectEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
