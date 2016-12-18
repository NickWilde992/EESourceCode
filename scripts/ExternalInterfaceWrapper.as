package
{
   import flash.events.EventDispatcher;
   import flash.system.Security;
   import flash.external.ExternalInterface;
   
   public class ExternalInterfaceWrapper extends EventDispatcher
   {
       
      
      public function ExternalInterfaceWrapper()
      {
         super();
         Security.allowDomain("*");
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.addCallback("showUserProfile",this.showUserProfile);
            }
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function showUserProfile(param1:String) : void
      {
         var _loc2_:NavigationEvent = new NavigationEvent(NavigationEvent.SHOW_PROFILE);
         _loc2_.username = param1;
         dispatchEvent(_loc2_);
      }
   }
}
