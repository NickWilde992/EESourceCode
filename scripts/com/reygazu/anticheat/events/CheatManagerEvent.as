package com.reygazu.anticheat.events
{
   import flash.events.Event;
   
   public class CheatManagerEvent extends Event
   {
      
      public static var FORCE_HOP:String = "forceHop";
      
      public static var CHEAT_DETECTION:String = "cheatDetection";
       
      
      public var data:Object;
      
      public function CheatManagerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
