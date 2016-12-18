package
{
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.net.FileReference;
   import com.adobe.images.PNGEncoder;
   import states.PlayState;
   
   public class Screenshot
   {
       
      
      public function Screenshot()
      {
         super();
      }
      
      public static function SavePNG(param1:MouseEvent) : void
      {
         var _loc3_:ByteArray = null;
         var _loc2_:FileReference = new FileReference();
         if(param1.buttonDown)
         {
            _loc3_ = PNGEncoder.encode((Global.base.state as PlayState).lastframe);
            _loc2_.save(_loc3_,Global.currentLevelname + ".png");
            Global.base.showInfo2("Screenshot taken","Your screenshot was taken!");
         }
      }
      
      public static function SavePNGWithFullWorld(param1:MouseEvent) : void
      {
         var _loc3_:ByteArray = null;
         var _loc2_:FileReference = new FileReference();
         if(param1.buttonDown)
         {
            (Global.base.state as PlayState).world.drawFull();
            _loc3_ = PNGEncoder.encode((Global.base.state as PlayState).world.fullImage);
            _loc2_.save(_loc3_,Global.currentLevelname + ".png");
            Global.base.showInfo2("Screenshot taken","Your screenshot was taken!");
         }
      }
   }
}
