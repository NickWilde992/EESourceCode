package com.reygazu.anticheat.managers
{
   import flash.events.EventDispatcher;
   import flash.display.Stage;
   import blitter.Bl;
   import flash.events.Event;
   import com.reygazu.anticheat.events.CheatManagerEvent;
   
   public class CheatManager extends EventDispatcher
   {
      
      protected static var _instance:com.reygazu.anticheat.managers.CheatManager;
       
      
      private var _focusHop:Boolean;
      
      private var _secureVars:Array;
      
      private var stage:Stage;
      
      public function CheatManager(param1:Function = null)
      {
         super();
         if(param1 != com.reygazu.anticheat.managers.CheatManager.getInstance)
         {
            throw new Error("CheatManager is a singleton class, use getInstance() instead");
         }
         if(com.reygazu.anticheat.managers.CheatManager._instance != null)
         {
            throw new Error("Only one CheatManager instance should be instantiated");
         }
      }
      
      public static function getInstance() : com.reygazu.anticheat.managers.CheatManager
      {
         if(_instance == null)
         {
            _instance = new com.reygazu.anticheat.managers.CheatManager(arguments.callee);
            _instance.init();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this._secureVars = new Array();
         this._focusHop = false;
         this.stage = Bl.stage;
         this.stage.addEventListener(Event.DEACTIVATE,this.onLostFocusHandler);
      }
      
      public function set enableFocusHop(param1:Boolean) : void
      {
         this._focusHop = param1;
      }
      
      private function onLostFocusHandler(param1:Event) : void
      {
         if(this._focusHop)
         {
            this.doHop();
         }
      }
      
      public function doHop() : void
      {
         this.dispatchEvent(new CheatManagerEvent(CheatManagerEvent.FORCE_HOP));
      }
      
      public function detectCheat(param1:String, param2:Object, param3:Object) : void
      {
         var _loc4_:CheatManagerEvent = new CheatManagerEvent(CheatManagerEvent.CHEAT_DETECTION);
         _loc4_.data = {
            "variableName":param1,
            "fakeValue":param2,
            "realValue":param3
         };
         com.reygazu.anticheat.managers.CheatManager.getInstance().dispatchEvent(_loc4_);
      }
   }
}
