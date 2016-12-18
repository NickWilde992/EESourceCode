package
{
   import playerio.Client;
   import flash.display.Stage;
   import flash.net.SharedObject;
   import data.SimplePlayerObject;
   import flash.display.BitmapData;
   import flash.display.StageDisplayState;
   import flash.external.ExternalInterface;
   
   public class Global
   {
      
      public static var playerInstance:Player;
      
      public static var player_is_guest:Boolean = false;
      
      public static var player_is_beta_member:Boolean = false;
      
      public static var play_sounds:Boolean = true;
      
      public static var playing_on_armorgames:Boolean = false;
      
      public static var playing_on_faceboook:Boolean = false;
      
      public static var playing_on_playedonline:Boolean = false;
      
      public static var playing_on_kongregate:Boolean = false;
      
      public static var playing_on_mousebreaker:Boolean = false;
      
      public static var playing_on_com:Boolean = false;
      
      public static var playing_on_yahoo:Boolean = false;
      
      public static var client:Client;
      
      public static var default_label_size:int = 12;
      
      public static var default_label_text:String = "";
      
      public static var default_label_hex:String = "#FFFFFF";
      
      public static var text_sign_text:String = "Enter text here.";
      
      public static var fullWidth:int = 640;
      
      public static var fullHeight:int = 500;
      
      public static var stage:Stage;
      
      public static var cookie:SharedObject;
      
      public static var sharedCookie:SharedObject;
      
      public static var playerObject:SimplePlayerObject;
      
      public static var chatIsVisible:Boolean = false;
      
      public static var affiliate:String = "";
      
      public static var base:EverybodyEdits;
      
      public static var pianoOffset:int = 0;
      
      public static var drumOffset:int = 0;
      
      public static var hasOwner:Boolean = false;
      
      public static var currentLevelname:String = "";
      
      public static var worldOwner:String = "";
      
      public static var currentLevelCrew:String = "";
      
      public static var currentLevelCrewName:String = "";
      
      public static var currentLevelStatus:int = 0;
      
      public static var hasSubscribedToCrew:Boolean = false;
      
      public static var canchat:Boolean = false;
      
      public static var showUI:Boolean = true;
      
      public static var showChatAndNames:Boolean = true;
      
      public static var getPlacer:Boolean = false;
      
      public static var myId = 0;
      
      public static var roomid:String = "";
      
      public static var is_fullscreen_allowed:Boolean = true;
      
      public static var EMBED_WIDTH:int = 0;
      
      public static var brickoverlayactive:Boolean = false;
      
      public static var loadingscreen_image:BitmapData;
      
      public static var currentCrew:String;
      
      public static var currentCrewName:String;
      
      public static var runningTutorial:Boolean = false;
      
      public static var bgColor:uint;
      
      public static var backgroundEnabled:Boolean;
      
      public static var isFirstLogin:Boolean = false;
       
      
      public function Global()
      {
         super();
      }
      
      public static function get width() : int
      {
         if(!stage)
         {
            return EMBED_WIDTH;
         }
         if(stage.displayState == StageDisplayState.NORMAL)
         {
            return Math.min(Math.max(Config.minwidth,stage.stageWidth),Config.maxwidth);
         }
         return EMBED_WIDTH;
      }
      
      public static function get height() : int
      {
         if(!stage)
         {
            return fullHeight;
         }
         if(stage.displayState == StageDisplayState.NORMAL)
         {
            return stage.stageHeight;
         }
         return stage.stageHeight;
      }
      
      public static function setPath(param1:String, param2:String = "") : *
      {
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("setPath",param1,param2 || "/games/" + roomid.split(" ").join("-"));
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }
      }
      
      public static function toPrettyDate(param1:Date) : String
      {
         var _loc2_:* = param1.date.toString();
         if(param1.date == 1 || param1.date == 21 || param1.date == 31)
         {
            _loc2_ = _loc2_ + "st";
         }
         else if(param1.date == 2 || param1.date == 22)
         {
            _loc2_ = _loc2_ + "nd";
         }
         else if(param1.date == 3 || param1.date == 23)
         {
            _loc2_ = _loc2_ + "rd";
         }
         else
         {
            _loc2_ = _loc2_ + "th";
         }
         _loc2_ = _loc2_ + " of ";
         _loc2_ = _loc2_ + ["January","February","March","April","May","June","July","August","September","October","November","December"][param1.month];
         _loc2_ = _loc2_ + (" " + param1.fullYear);
         return _loc2_;
      }
      
      public static function get showGreenOnMinimap() : Boolean
      {
         return Global.cookie.data.showGreenOnMinimap != null?Boolean(Global.cookie.data.showGreenOnMinimap):true;
      }
      
      public static function get blockPickerEnabled() : Boolean
      {
         return Global.cookie.data.blockPicker != null?Boolean(Global.cookie.data.blockPicker):false;
      }
      
      public static function get maxBlockSelectorRows() : int
      {
         return Global.cookie.data.visibleRows != null?int(Global.cookie.data.visibleRows):3;
      }
      
      public static function get blockPackageTitlesVisible() : Boolean
      {
         return Global.cookie.data.packageNames != null?Boolean(Global.cookie.data.packageNames):true;
      }
      
      public static function get blockSelectorCollapsedMode() : Boolean
      {
         return Global.cookie.data.collapsed != null?Boolean(Global.cookie.data.collapsed):false;
      }
      
      public static function get coloredUsernames() : Boolean
      {
         return Global.cookie.data.coloredUsernames != null?Boolean(Global.cookie.data.coloredUsernames):false;
      }
      
      public static function get minimapAlphaValue() : Number
      {
         return Global.cookie.data.minimapAlphaValue != null?Number(Global.cookie.data.minimapAlphaValue):Number(1);
      }
   }
}
