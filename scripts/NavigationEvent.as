package
{
   import flash.events.Event;
   
   public class NavigationEvent extends Event
   {
      
      public static const SHOW_CREW_PROFILE:String = "show_crew_profile";
      
      public static const SHOW_MAP_PREVIEW:String = "show_map";
      
      public static const SHOW_PROFILE:String = "show_profile";
      
      public static const JOIN_WORLD:String = "join_world";
      
      public static const INVITE_FRIEND:String = "invite_friend";
      
      public static const LOGOUT:String = "logout";
      
      public static const SHOW_GOLD_ABOUT:String = "show_gold_about";
      
      public static const SHOW_HELP:String = "show_help";
      
      public static const SHOW_TERMS:String = "show_terms";
      
      public static const SHOW_BLOG:String = "show_blog";
      
      public static const SHOW_FORUMS:String = "show_forums";
      
      public static const SHOW_PLAYER_ACTIONS:String = "show_player_actions";
      
      public static const START_OPENWORLD:String = "start_openworld";
       
      
      public var username:String;
      
      public var crewname:String;
      
      public var userId:String;
      
      public var world_id:String;
      
      public var world_name:String;
      
      public var world_description:String = "";
      
      public function NavigationEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
