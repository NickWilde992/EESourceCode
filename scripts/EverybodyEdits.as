package
{
   import blitter.BlGame;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.BitmapData;
   import playerio.Client;
   import ui.login.MainLogin;
   import ui.LoginBox;
   import ui.chat.SideChat;
   import flash.utils.Timer;
   import ui.LoadingScreen;
   import ui.crews.MemberSettings;
   import ui.crews.RankItem;
   import ui.campaigns.CampaignComplete;
   import ui.crews.CrewProfile;
   import ui.InfoDisplay;
   import ui.tutorial.TutorialManager;
   import com.reygazu.anticheat.events.CheatManagerEvent;
   import flash.events.Event;
   import blitter.Bl;
   import flash.events.MouseEvent;
   import input.KeyState;
   import com.jac.mouse.MouseWheelEnabler;
   import com.reygazu.anticheat.managers.CheatManager;
   import playerio.Message;
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   import ui.crews.CrewRank;
   import ui.crews.CrewRanks;
   import ui.profile.Profile;
   import states.LobbyState;
   import ui.roomlist.MinimapPreview;
   import ui.profile.ConfirmEmailHandler;
   import flash.display.StageDisplayState;
   import flash.display.StageScaleMode;
   import flash.external.ExternalInterface;
   import data.SimplePlayerObject;
   import items.ItemSmiley;
   import items.ItemManager;
   import data.SimplePlayerObjectEvent;
   import playerio.Connection;
   import ui.CopyPrompt;
   import states.PlayState;
   import flash.display.Loader;
   import flash.net.SharedObject;
   import flash.events.IOErrorEvent;
   import flash.system.LoaderContext;
   import flash.display.LoaderInfo;
   import flash.display.StageAlign;
   import animations.AnimationManager;
   import sounds.SoundManager;
   import flash.utils.setInterval;
   import flash.events.FullScreenEvent;
   import states.LoadState;
   import playerio.PlayerIO;
   import events.Facebook.FB;
   import flash.system.Security;
   import flash.net.URLLoader;
   import playerio.PlayerIOError;
   import flash.utils.setTimeout;
   import ui.login.LoginWindow;
   import ui.login.ResetPassword;
   import ui.RegisterWindow;
   import playerio.PlayerIORegistrationError;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import ui.login.TermsWindow;
   import ui.login.UsernameWindow;
   import playerio.DatabaseObject;
   import items.ItemBrick;
   import ui.screens.WelcomeBack;
   import states.JoinState;
   import sounds.SoundId;
   import flash.utils.ByteArray;
   import ui.Prompt;
   import ui.ConfirmPrompt;
   import ui.LevelOptions;
   import ui.LevelComplete;
   import flash.net.URLVariables;
   import flash.net.URLRequestMethod;
   import com.greensock.easing.Back;
   import com.greensock.plugins.TweenPlugin;
   import com.greensock.plugins.GlowFilterPlugin;
   import flash.text.TextFieldAutoSize;
   import io.player.tools.Badwords;
   import ui.LobbyLoginBox;
   import flash.utils.clearTimeout;
   import com.greensock.*;
   import com.greensock.plugins.BlurFilterPlugin;
   import com.greensock.plugins.ColorTransformPlugin;
   import com.greensock.plugins.DropShadowFilterPlugin;
   
   public class EverybodyEdits extends BlGame
   {
       
      
      public var client:Client;
      
      public var ui2instance:UI2;
      
      protected var iseecom:Boolean = false;
      
      private var mainlogin:MainLogin;
      
      private var showDisconnectedMessage:Boolean = true;
      
      protected var lb:LoginBox;
      
      protected var bp:BetaProgram;
      
      protected var roomname:String = null;
      
      protected var forcejoin:String = null;
      
      protected var email_confirm_key:String = null;
      
      protected var kongregate;
      
      public var sidechat:SideChat;
      
      protected var spo_updater:Timer;
      
      public var loading:LoadingScreen;
      
      public var filterbadwords:Boolean = false;
      
      private var eiw:ExternalInterfaceWrapper;
      
      private var memberSettings:MemberSettings;
      
      private var rankItem:RankItem;
      
      private var cc:CampaignComplete;
      
      public var crewProfile:CrewProfile;
      
      private var infoBox:InfoDisplay;
      
      private var tutorialManager:TutorialManager;
      
      private var mapBG:BlackBG;
      
      private var mapPreview:MinimapPreview;
      
      public var rpcCon:Connection;
      
      private var crewLobbyCon:Connection;
      
      private var crewLobbyId:String;
      
      private var crewLobbyConnecting:Boolean = false;
      
      private var crewLobbyQueue:Vector.<Function>;
      
      private var rpcConnecting:Boolean = false;
      
      private var rpcConnectQueue:Vector.<Function>;
      
      public var liked:Boolean;
      
      public var favorited:Boolean;
      
      private var forceShowToturial:Boolean = false;
      
      private var connection:Connection;
      
      private var deltas:Array;
      
      private var inited:Boolean = false;
      
      private var upgrade:Boolean = false;
      
      private var swapittimer:SharedObject;
      
      private var loginwindow:LoginWindow;
      
      public function EverybodyEdits()
      {
         this.bp = new BetaProgram();
         this.crewLobbyQueue = new Vector.<Function>();
         this.rpcConnectQueue = new Vector.<Function>();
         this.deltas = [];
         this.swapittimer = SharedObject.getLocal("swapit");
         super(640,480,1);
         Global.base = this;
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         TweenPlugin.activate([BlurFilterPlugin,GlowFilterPlugin,ColorTransformPlugin,DropShadowFilterPlugin]);
         Bl.data.brick = 0;
         Bl.data.base = this;
         Bl.data.isbeta = false || Config.forceBeta;
         Bl.data.iskongregate = false;
         Bl.data.onsite = false;
         Bl.data.roomname = "";
         Bl.data.name = "";
         Bl.data.portal_id = 0;
         Bl.data.portal_target = 0;
         Bl.data.portal_id = 0;
         Bl.data.world_portal_id = "";
         Bl.data.world_portal_name = "";
         Bl.data.jumps = 2;
         Bl.data.coincount = 10;
         Bl.data.fromemail = false;
         Bl.data.switchid = 0;
         Bl.data.deathcount = 10;
         Bl.data.team = 0;
         Bl.data.effectDuration = 10;
         Bl.data.onStatus = true;
         addEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
         addEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage,false,0,true);
         this.eiw = new ExternalInterfaceWrapper();
         this.eiw.addEventListener(NavigationEvent.SHOW_PROFILE,this.handleShowProfile,false,0,true);
      }
      
      private static function getBitmap(param1:DisplayObject) : Bitmap
      {
         var _loc2_:Bitmap = null;
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height);
         _loc3_.draw(param1);
         _loc2_ = new Bitmap(_loc3_);
         return _loc2_;
      }
      
      private function onCheatDetected(param1:CheatManagerEvent) : void
      {
         if(this.connection && this.connection.connected)
         {
            this.connection.send("cheatDetected",param1.data.variableName);
         }
      }
      
      protected function handleAddedToStage(param1:Event) : void
      {
         Bl.stage.removeEventListener(Event.ADDED_TO_STAGE,this.handleAddedToStage);
         Bl.stage.addEventListener(NavigationEvent.SHOW_MAP_PREVIEW,this.handleShowMinimapPreview,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.SHOW_PROFILE,this.handleShowProfile,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.JOIN_WORLD,this.handleJoinWorld,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.LOGOUT,this.handleLogout,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.SHOW_GOLD_ABOUT,this.handleShowPage,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.SHOW_BLOG,this.handleShowPage,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.SHOW_HELP,this.handleShowPage,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.SHOW_TERMS,this.handleShowPage,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.SHOW_FORUMS,this.handleShowPage,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.SHOW_CREW_PROFILE,this.handleShowCrewProfile,false,0,true);
         Bl.stage.addEventListener(NavigationEvent.SHOW_PLAYER_ACTIONS,this.showPlayerActions,false,0,true);
         Bl.stage.addEventListener(MouseEvent.CLICK,this.hidePlayerActions,false,0,true);
         KeyState.activate(Bl.stage);
         MouseWheelEnabler.init(Bl.stage);
         CheatManager.getInstance().addEventListener(CheatManagerEvent.CHEAT_DETECTION,this.onCheatDetected);
         Global.EMBED_WIDTH = stage.stageWidth;
      }
      
      private function showPlayerActions(param1:NavigationEvent) : void
      {
         if(this.ui2instance != null)
         {
            this.ui2instance.showPlayerActions(param1.username,param1.userId);
         }
      }
      
      private function hidePlayerActions(param1:MouseEvent) : void
      {
         if(this.ui2instance != null)
         {
            this.ui2instance.hidePlayerActions();
         }
      }
      
      public function showTutorial(param1:TutorialManager) : void
      {
         if(param1 != null)
         {
            this.tutorialManager = param1;
            if(!Global.base.overlayContainer.contains(this.tutorialManager))
            {
               Global.base.overlayContainer.addChild(this.tutorialManager);
               this.tutorialManager.alpha = 0;
               TweenMax.to(this.tutorialManager,0.4,{"alpha":1});
            }
         }
      }
      
      public function hideTutorial() : void
      {
         if(this.tutorialManager != null && Global.base.overlayContainer.contains(this.tutorialManager))
         {
            this.tutorialManager.alpha = 1;
            TweenMax.to(this.tutorialManager,0.4,{
               "alpha":0,
               "onComplete":function():void
               {
                  Global.base.overlayContainer.removeChild(tutorialManager);
                  requestRemoteMethod("finishTutorial",function(param1:Message):void
                  {
                     Global.playerObject.tutorialVersion = Config.tutorialVersion;
                  });
               }
            });
         }
      }
      
      protected function handleShowPage(param1:NavigationEvent) : void
      {
         switch(param1.type)
         {
            case NavigationEvent.SHOW_GOLD_ABOUT:
               if(Global.playing_on_com && !Global.playing_on_faceboook)
               {
                  navigateToURL(new URLRequest("#gold"),"_top");
               }
               else
               {
                  this.openNewPage(Config.url_goldmember_about_page);
               }
               break;
            case NavigationEvent.SHOW_BLOG:
               this.openNewPage(Config.url_blog);
               break;
            case NavigationEvent.SHOW_HELP:
               this.openNewPage(Config.url_help_page);
               break;
            case NavigationEvent.SHOW_TERMS:
               this.openNewPage(Config.url_terms_page);
               break;
            case NavigationEvent.SHOW_FORUMS:
               this.openNewPage(Config.url_forums);
         }
      }
      
      public function openNewPage(param1:String) : void
      {
         var url:String = param1;
         try
         {
            navigateToURL(new URLRequest(url),"_new");
            return;
         }
         catch(e:Error)
         {
            client.errorLog.writeError("Error opening new page: " + e.name,e.message,e.getStackTrace(),e);
            return;
         }
      }
      
      public function openPage(param1:String) : void
      {
         var url:String = param1;
         try
         {
            navigateToURL(new URLRequest(url),"_top");
            return;
         }
         catch(e:Error)
         {
            client.errorLog.writeError("Error opening page: " + e.name,e.message,e.getStackTrace(),e);
            return;
         }
      }
      
      public function showMemberSettings(param1:String, param2:String, param3:CrewRank, param4:CrewRanks, param5:String) : void
      {
         this.memberSettings = new MemberSettings(param1,param2,param3,param4,param5);
         this.memberSettings.alpha = 0;
         overlayContainer.addChild(this.memberSettings);
         TweenMax.to(this.memberSettings,0.4,{"alpha":1});
      }
      
      public function hideMemberSettings() : void
      {
         if(overlayContainer.contains(this.memberSettings))
         {
            TweenMax.to(this.memberSettings,0.4,{
               "alpha":0,
               "onComplete":function():void
               {
                  overlayContainer.removeChild(memberSettings);
               }
            });
         }
      }
      
      public function showRankItem(param1:String, param2:CrewRanks) : void
      {
         this.rankItem = new RankItem(param1,param2);
         overlayContainer.addChild(this.rankItem);
      }
      
      public function hideRankItem() : void
      {
         overlayContainer.removeChild(this.rankItem);
      }
      
      protected function handleLogout(param1:NavigationEvent) : void
      {
         this.logout();
      }
      
      protected function handleShowProfile(param1:NavigationEvent) : void
      {
         this.showProfile(param1.username,Profile.MODE_INGAME);
      }
      
      private function showProfile(param1:String, param2:String = "") : void
      {
         var _loc3_:Profile = new Profile(param1,param2);
         overlayContainer.addChild(_loc3_);
      }
      
      private function handleShowCrewProfile(param1:NavigationEvent) : void
      {
         this.showCrewProfile(param1.crewname,CrewProfile.MODE_INGAME);
      }
      
      public function showCrewProfile(param1:String, param2:String = "") : void
      {
         this.crewProfile = new CrewProfile(param1,param2);
         overlayContainer.addChild(this.crewProfile);
      }
      
      public function updateMemberItems(param1:Boolean = true, param2:String = "", param3:String = "", param4:int = 0) : void
      {
         var _loc5_:LobbyState = null;
         if(param1)
         {
            if(this.crewProfile != null)
            {
               if(overlayContainer.contains(this.crewProfile))
               {
                  this.crewProfile.getMemberItemByUsername(param2).updateItem(param3,param4);
               }
            }
         }
         else if(state as LobbyState)
         {
            _loc5_ = state as LobbyState;
            if(_loc5_.mainProfile.myCrew != null)
            {
               _loc5_.mainProfile.myCrew.refreshCrew();
            }
         }
      }
      
      protected function handleShowMinimapPreview(param1:NavigationEvent) : void
      {
         this.showMapPreview(param1.world_name,param1.world_id,param1.world_description);
      }
      
      private function showMapPreview(param1:String, param2:String, param3:String) : void
      {
         this.mapBG = new BlackBG();
         this.mapPreview = new MinimapPreview(param1,param2,param3);
         overlayContainer.addChild(this.mapBG);
         overlayContainer.addChild(this.mapPreview);
         TweenMax.to(this.mapPreview,0,{"alpha":0});
         TweenMax.to(this.mapBG,0,{"alpha":0});
         TweenMax.to(this.mapPreview,0.2,{"alpha":1});
         TweenMax.to(this.mapBG,0.3,{"alpha":1});
      }
      
      public function removeMapPreview() : void
      {
         TweenMax.to(this.mapPreview,0.2,{
            "alpha":0,
            "onComplete":function():void
            {
               TweenMax.to(mapBG,0.25,{
                  "alpha":0,
                  "onComplete":function():void
                  {
                     overlayContainer.removeChild(mapPreview);
                     overlayContainer.removeChild(mapBG);
                  }
               });
            }
         });
      }
      
      private function showEmailConfirmation(param1:String) : void
      {
         var _loc2_:ConfirmEmailHandler = new ConfirmEmailHandler(param1);
         overlayContainer.addChild(_loc2_);
      }
      
      protected function handleJoinWorld(param1:NavigationEvent) : void
      {
         this.cleanUIAndConnections();
         this.joinRoom(param1.world_id);
      }
      
      private function handleFullScreen(param1:Event) : void
      {
         if(Bl.stage.displayState == StageDisplayState.NORMAL)
         {
            Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
         }
         else
         {
            Bl.stage.scaleMode = StageScaleMode.SHOW_ALL;
            Bl.stage.dispatchEvent(new Event(Event.RESIZE,false,false));
         }
         if(this.sidechat)
         {
            this.sidechat.refresh();
         }
      }
      
      private function initializeAd() : void
      {
         if(!Global.playerObject)
         {
            return;
         }
         if(ExternalInterface.available)
         {
            if(!Global.playerObject.goldmember)
            {
               ExternalInterface.call("showad");
            }
         }
      }
      
      public function updatePlayerProperties(param1:Function = null) : void
      {
         var spo:SimplePlayerObject = null;
         var callback:Function = param1;
         if(this.client != null)
         {
            if(this.client.connectUserId != "simpleguest")
            {
               this.requestRemoteMethod("getMySimplePlayerObject",function(param1:Message):void
               {
                  var _loc4_:ItemSmiley = null;
                  var _loc2_:SimplePlayerObject = new SimplePlayerObject();
                  var _loc3_:int = -1;
                  _loc2_.loaded = new Date();
                  _loc2_.name = param1.getString(++_loc3_);
                  _loc2_.smiley = param1.getInt(++_loc3_);
                  _loc2_.aura = param1.getInt(++_loc3_);
                  _loc2_.auraColor = param1.getInt(++_loc3_);
                  _loc2_.chatbanned = param1.getBoolean(++_loc3_);
                  Global.canchat = param1.getBoolean(++_loc3_);
                  _loc2_.haveSmileyPackage = param1.getBoolean(++_loc3_);
                  _loc2_.isAdministrator = param1.getBoolean(++_loc3_);
                  _loc2_.isModerator = param1.getBoolean(++_loc3_);
                  _loc2_.goldmember = param1.getBoolean(++_loc3_);
                  _loc2_.wearsGoldSmiley = param1.getBoolean(++_loc3_);
                  _loc2_.goldremain = param1.getNumber(++_loc3_);
                  _loc2_.goldtime = param1.getNumber(++_loc3_);
                  _loc2_.goldwelcome = param1.getBoolean(++_loc3_);
                  _loc2_.room0 = param1.getString(++_loc3_) != ""?param1.getString(_loc3_):null;
                  _loc2_.betaonlyroom = param1.getString(++_loc3_) != ""?param1.getString(_loc3_):null;
                  _loc2_.homeworld = param1.getString(++_loc3_) != ""?param1.getString(_loc3_):null;
                  _loc2_.setRooms(param1.getString(++_loc3_).split("᎙"),param1.getString(++_loc3_).split("᎙"),param1.getString(++_loc3_).split("᎙"));
                  _loc2_.visible = param1.getBoolean(++_loc3_);
                  _loc2_.banned = param1.getBoolean(++_loc3_);
                  _loc2_.accepted_terms = param1.getInt(++_loc3_);
                  _loc2_.tutorialVersion = param1.getInt(++_loc3_);
                  _loc2_.badge = param1.getString(++_loc3_);
                  _loc2_.confirmedEmail = param1.getBoolean(++_loc3_);
                  _loc2_.maxEnergy = param1.getInt(++_loc3_);
                  _loc2_.changename = param1.getBoolean(++_loc3_);
                  _loc2_.setFavorites(param1.getString(++_loc3_).split("᎙"),param1.getString(++_loc3_).split("᎙"));
                  Global.playerObject = _loc2_;
                  Bl.data.chatbanned = _loc2_.chatbanned || false;
                  Global.player_is_beta_member = _loc2_.haveSmileyPackage || client.payVault.has("pro");
                  Bl.data.isAdmin = _loc2_.isAdministrator;
                  Bl.data.isModerator = _loc2_.isModerator;
                  if(!ItemManager.getSmileyById(_loc2_.smiley))
                  {
                     _loc2_.smiley = 0;
                  }
                  else
                  {
                     _loc4_ = ItemManager.getSmileyById(_loc2_.smiley);
                     if(_loc4_.payvaultid != "" && !client.payVault.has(_loc4_.payvaultid) && (_loc4_.payvaultid != "goldmember" || !Global.playerObject.goldmember) && (_loc4_.payvaultid != "pro" || !Global.player_is_beta_member))
                     {
                        _loc2_.smiley = 0;
                     }
                  }
                  if(!ItemManager.getAuraByIdAndColor(_loc2_.aura,_loc2_.auraColor))
                  {
                     _loc2_.aura = 0;
                     _loc2_.auraColor = 0;
                  }
                  if(callback != null)
                  {
                     callback.call(this);
                  }
                  Global.stage.dispatchEvent(new SimplePlayerObjectEvent(SimplePlayerObjectEvent.UPDATE));
                  if(spo_updater != null)
                  {
                     spo_updater.stop();
                  }
               });
            }
            else
            {
               spo = new SimplePlayerObject();
               spo.loaded = new Date();
               spo.name = "guest";
               spo.smiley = 0;
               spo.aura = 0;
               spo.auraColor = 0;
               spo.badge = "";
               spo.maxEnergy = 0;
               spo.chatbanned = true;
               spo.haveSmileyPackage = false;
               spo.isAdministrator = false;
               spo.isModerator = false;
               spo.room0 = null;
               spo.betaonlyroom = null;
               spo.homeworld = null;
               spo.visible = false;
               spo.banned = false;
               spo.level = 0;
               spo.leveltitle = "";
               spo.levelcap_next = 5;
               spo.levelcap_prev = 0;
               spo.goldmember = false;
               spo.goldremain = 0;
               spo.goldtime = 0;
               spo.goldwelcome = false;
               Global.playerObject = spo;
               Global.canchat = false;
               Global.player_is_beta_member = false;
               Bl.data.isAdmin = false;
               Bl.data.isModerator = false;
               if(callback != null)
               {
                  callback.call(this);
               }
            }
         }
      }
      
      public function requestRemoteMethod(param1:String, param2:Function, ... rest) : void
      {
         var name:String = param1;
         var callback:Function = param2;
         var args:Array = rest;
         this.getRPCConnection(function(param1:Connection):void
         {
            var con:Connection = param1;
            con.addMessageHandler(name,function(param1:Message):void
            {
               if(callback != null)
               {
                  callback.apply(this,[param1]);
               }
               con.removeMessageHandler(name,arguments.callee);
            });
            var m:Message = con.createMessage.apply(this,[name].concat(args));
            con.sendMessage(m);
         });
      }
      
      public function requestCrewLobbyMethod(param1:String, param2:String, param3:Function, param4:Function, ... rest) : void
      {
         var crewId:String = param1;
         var name:String = param2;
         var callback:Function = param3;
         var errorCallback:Function = param4;
         var args:Array = rest;
         if(this.crewLobbyId != crewId && this.crewLobbyCon != null && this.crewLobbyCon.connected)
         {
            this.crewLobbyCon.disconnect();
         }
         this.getCrewLobbyConnection(crewId,function(param1:Connection):void
         {
            var con:Connection = param1;
            con.addMessageHandler(name,function(param1:Message):void
            {
               if(callback != null)
               {
                  callback.apply(this,[param1]);
               }
               con.removeMessageHandler(name,arguments.callee);
            });
            if(errorCallback != null)
            {
               con.addDisconnectHandler(errorCallback);
            }
            con.sendMessage(con.createMessage.apply(this,[name].concat(args)));
         });
      }
      
      private function getCrewLobbyConnection(param1:String, param2:Function) : void
      {
         var crewId:String = param1;
         var callback:Function = param2;
         if(crewId == this.crewLobbyId && this.crewLobbyCon != null && this.crewLobbyCon.connected)
         {
            callback(this.crewLobbyCon);
         }
         else
         {
            this.crewLobbyQueue.push(callback);
            this.crewLobbyId = crewId;
            if(this.crewLobbyConnecting)
            {
               return;
            }
            this.crewLobbyConnecting = true;
            this.client.multiplayer.createJoinRoom(crewId,Config.server_type_crewshop,true,{},{},function(param1:Connection):void
            {
               var con:Connection = param1;
               crewLobbyCon = con;
               con.addMessageHandler("info",function(param1:Message, param2:String, param3:String, param4:Boolean = false):void
               {
                  showInfo(param2,param3,-1,param4);
               });
               con.addDisconnectHandler(function():void
               {
               });
               crewLobbyConnecting = false;
               while(crewLobbyQueue.length)
               {
                  crewLobbyQueue.shift()(crewLobbyCon);
               }
            });
         }
      }
      
      public function getRPCConnection(param1:Function, param2:Function = null) : void
      {
         var callback:Function = param1;
         var errorHandler:Function = param2;
         if(this.rpcCon != null && this.rpcCon.connected)
         {
            callback(this.rpcCon);
         }
         else
         {
            this.rpcConnectQueue.push(callback);
            if(this.rpcConnecting)
            {
               return;
            }
            this.rpcConnecting = true;
            this.client.multiplayer.createJoinRoom(this.client.connectUserId,!!Global.player_is_guest?Config.server_type_guestserviceroom:Config.server_type_serviceroom,true,{},{},function(param1:Connection):void
            {
               var con:Connection = param1;
               rpcCon = con;
               con.addMessageHandler("info",function(param1:Message, param2:String, param3:String, param4:Boolean = false):void
               {
                  showInfo(param2,param3,-1,param4);
               });
               con.addMessageHandler("upgrade",showUpgradeScreen);
               con.addMessageHandler("copyPrompt",function(param1:Message, param2:String, param3:String, param4:String = ""):void
               {
                  showCopyPrompt(new CopyPrompt(param2,param3,param4));
               });
               con.addDisconnectHandler(function():void
               {
                  disconnectRPC();
               });
               con.addMessageHandler("connectioncomplete",function(param1:Message):void
               {
                  rpcConnecting = false;
                  while(rpcConnectQueue.length)
                  {
                     rpcConnectQueue.shift()(rpcCon);
                  }
               });
            },errorHandler);
         }
      }
      
      public function disconnectRPC() : void
      {
         if(this.rpcCon != null)
         {
            if(this.rpcCon.connected)
            {
               this.rpcCon.disconnect();
            }
            this.rpcCon = null;
            this.rpcConnecting = false;
         }
      }
      
      private function cleanUIAndConnections() : void
      {
         this.showDisconnectedMessage = false;
         if(this.ui2instance && this.ui2instance.parent)
         {
            overlayContainer.removeChild(this.ui2instance);
         }
         if(this.sidechat && this.sidechat.parent)
         {
            overlayContainer.removeChild(this.sidechat);
         }
         if(this.tutorialManager != null)
         {
            if(overlayContainer.contains(this.tutorialManager))
            {
               overlayContainer.removeChild(this.tutorialManager);
            }
         }
         if(this.connection && this.connection.connected)
         {
            this.connection.disconnect();
         }
         if(state && state is LobbyState)
         {
            LobbyState(state).reset();
            LobbyState(state).removeBackgrounds();
         }
         if(state && state is PlayState)
         {
            PlayState(state).reset();
         }
         this.showDisconnectedMessage = true;
      }
      
      public function ShowLobby(param1:String = "") : void
      {
         clearOverlayContainer();
         this.cleanUIAndConnections();
         this.showLobby(null,param1);
      }
      
      public function loadStoredCookie(param1:Function) : void
      {
         var l:Loader = null;
         var so:SharedObject = null;
         var callback:Function = param1;
         try
         {
            so = SharedObject.getLocal("check" + Math.random());
            so.flush();
         }
         catch(e:Error)
         {
            handleError("Error loading SharedObject. Please check you Flash Player settings (Right click -> Global Settings)");
            return;
         }
         if(Config.disableCookie)
         {
            Global.cookie = SharedObject.getLocal("Temp" + Math.random());
            callback();
            return;
         }
         if(Config.isMobile)
         {
            Global.cookie = SharedObject.getLocal("ssx");
            callback();
            return;
         }
         l = new Loader();
         l.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var e:Event = param1;
            try
            {
               Global.cookie = Object(l.content).data;
            }
            catch(e:Error)
            {
               handleError(e);
            }
            loadPostManCheck(callback);
         });
         l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         l.load(new URLRequest("http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/ssx.swf"),new LoaderContext(true));
      }
      
      private function loadPostManCheck(param1:Function) : void
      {
         var l:Loader = null;
         var callback:Function = param1;
         l = new Loader();
         l.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var e:Event = param1;
            try
            {
               Global.sharedCookie = Object(l.content).data;
               Bl.data.fromemail = Global.sharedCookie.data.fromemail || false;
            }
            catch(e:Error)
            {
            }
            callback();
         });
         l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         l.load(new URLRequest("http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/ss.swf"),new LoaderContext(true));
      }
      
      private function configureBasedOnLoadvariabels() : void
      {
         var _loc1_:Object = LoaderInfo(stage.root.loaderInfo).parameters;
         Global.affiliate = _loc1_.ee$affiliate || _loc1_.querystring_a;
         Global.playing_on_kongregate = !!_loc1_.kongregate_api_path?true:false;
         Global.playing_on_mousebreaker = Global.affiliate == "mousebreaker" || Config.forceMouseBreaker;
         Global.playing_on_armorgames = Global.affiliate == "armorgames" || Config.forceArmor;
         Global.playing_on_playedonline = Global.affiliate == "playedonline";
      }
      
      private function handleAttach(param1:Event) : void
      {
         var offset:int = 0;
         var e:Event = param1;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         Global.stage = stage;
         ItemManager.init();
         AnimationManager.init();
         SoundManager.init();
         var loadUser:String = Config.debug_profile;
         var loadCrew:String = Config.debug_crew_profile;
         if(ExternalInterface.available)
         {
            try
            {
               loadUser = ExternalInterface.call("load_user.toString") || loadUser;
               loadCrew = ExternalInterface.call("load_crew.toString") || loadCrew;
               this.email_confirm_key = ExternalInterface.call("ee_confirmkey.toString");
            }
            catch(e:Error)
            {
            }
         }
         if(loadUser != "")
         {
            this.showProfile(loadUser);
            return;
         }
         if(loadCrew != "")
         {
            this.showCrewProfile(loadCrew);
            return;
         }
         offset = 5;
         setInterval(function():void
         {
            offset = offset + 5;
         },60 * 5 * 1000);
         this.loadStoredCookie(this.handleLoadCookie);
      }
      
      private function handleLoadCookie() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(this.email_confirm_key != null && this.email_confirm_key.length > 0)
         {
            this.showEmailConfirmation(this.email_confirm_key);
            return;
         }
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.handleFullScreen);
         Bl.data.showMap = false;
         Bl.data.canEdit = false;
         Bl.data.canToggleGodMode = false;
         var _loc1_:LoadState = new LoadState();
         state = _loc1_;
         if(Global.cookie.data.filterbadwords != null)
         {
            this.filterbadwords = Global.cookie.data.filterbadwords;
         }
         else
         {
            this.filterbadwords = true;
         }
         this.configureBasedOnLoadvariabels();
         this.iseecom = ((LoaderInfo(stage.root.loaderInfo).parameters.nonoba$referer || "") + "").toLowerCase().indexOf("kongregate") == -1;
         Global.affiliate = Global.affiliate || Global.cookie.data.affiliate || null;
         if(ExternalInterface.available)
         {
            try
            {
               this.forcejoin = ExternalInterface.call("ee_forcejoin.toString");
               this.roomname = ExternalInterface.call("ee_roomname.toString");
               Bl.data.isbeta = ExternalInterface.call("isbeta.toString") == "true" || Config.forceBeta;
               Global.playing_on_com = Bl.data.onsite = ExternalInterface.call("iseecom.toString") == "true" && !Bl.data.isbeta || true;
               Global.affiliate = ExternalInterface.call("affiliate.toString") || Global.affiliate;
            }
            catch(e:Error)
            {
            }
         }
         if(!Global.cookie.data.affiliate && Global.affiliate)
         {
            Global.cookie.data.affiliate = Global.affiliate;
            Global.cookie.flush();
         }
         if(Config.run_in_development_mode)
         {
            this.roomname = Config.development_mode_autojoin_room;
         }
         if(this.roomname != null)
         {
            if(this.roomname.substring(0,2) == "PW" || this.roomname.substring(0,2) == "BW" || this.roomname.substring(0,2) == "OW")
            {
               this.roomname = this.roomname.split("-").join(" ");
            }
         }
         if(Global.cookie.data.username == "guest")
         {
            Global.cookie.data.username = "";
            Global.cookie.data.password = "";
         }
         if(Global.cookie.data.currentCrew != null)
         {
            Global.currentCrew = Global.cookie.data.currentCrew;
         }
         else
         {
            Global.currentCrew = "";
         }
         if(Global.cookie.data.currentCrewName != null)
         {
            Global.currentCrewName = Global.cookie.data.currentCrewName;
         }
         else
         {
            Global.currentCrewName = "";
         }
         var _loc2_:Object = LoaderInfo(this.root.loaderInfo).parameters;
         if(_loc2_.GameUserId && _loc2_.UserAuthCode)
         {
            Bl.data.isswappit = true;
            Bl.data.swappitusername = ExternalInterface.call("top.$.userName.toString");
            PlayerIO.authenticate(stage,Config.playerio_game_id,"secure",{
               "userId":_loc2_.GameUserId,
               "authToken":_loc2_.UserAuthCode
            },Global.affiliate,this.simpleConnect,this.handleFailedAuth);
         }
         else if(_loc2_.fb_access_token)
         {
            PlayerIO.quickConnect.facebookOAuthConnect(stage,Config.playerio_game_id,_loc2_.fb_access_token,Global.affiliate,this.simpleConnect,this.handleError);
            FB.init({
               "access_token":_loc2_.fb_access_token,
               "app_id":"132690750091157",
               "debug":true
            });
            Global.playing_on_faceboook = true;
         }
         else
         {
            if(Global.cookie.data.remember && this.lb && this.lb.keeplogin)
            {
               this.lb.keeplogin.gotoAndStop(2);
            }
            if(this.forcejoin != null && this.forcejoin != "")
            {
               this.forcejoin = unescape(this.forcejoin);
               _loc3_ = this.forcejoin.split(",")[0];
               _loc4_ = this.forcejoin.split(",")[1];
               PlayerIO.quickConnect.simpleConnect(Bl.stage,Config.playerio_game_id,_loc3_,_loc4_,this.simpleConnect,this.handleFailedAuth);
            }
            else if(Global.cookie.data.username && Global.cookie.data.password && !Global.playing_on_armorgames && !Global.playing_on_kongregate && !Global.playing_on_mousebreaker)
            {
               PlayerIO.quickConnect.simpleConnect(Bl.stage,Config.playerio_game_id,Global.cookie.data.username,Global.cookie.data.password,this.simpleConnect,this.handleFailedAuth);
            }
            else
            {
               this.authenticateUser();
            }
         }
      }
      
      private function authenticateWithKongregate(param1:String) : void
      {
         var apiPath:String = param1;
         if(this.lb && this.lb.recoverpass)
         {
            this.lb.recoverpass.visible = false;
         }
         Bl.data.iskongregate = true;
         Security.allowDomain(apiPath);
         var request:URLRequest = new URLRequest(apiPath);
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var user_id:String = null;
            var token:String = null;
            var e:Event = param1;
            kongregate = e.target.content;
            kongregate.services.connect();
            var isKongregateGuest:Boolean = kongregate.services.isGuest();
            if(isKongregateGuest)
            {
               baseInit();
               kongregate.services.addEventListener("login",function():void
               {
                  var _loc1_:String = kongregate.services.getUserId();
                  var _loc2_:String = kongregate.services.getGameAuthToken();
                  PlayerIO.quickConnect.kongregateConnect(stage,Config.playerio_game_id,_loc1_,_loc2_,simpleConnect,handleError);
               });
            }
            else
            {
               user_id = kongregate.services.getUserId();
               token = kongregate.services.getGameAuthToken();
               PlayerIO.quickConnect.kongregateConnect(stage,Config.playerio_game_id,user_id,token,simpleConnect,handleError);
            }
         });
         loader.load(request);
         overlayContainer.addChild(loader);
      }
      
      public function authenticateWithArmorgames(param1:String, param2:String, param3:Function) : void
      {
         PlayerIO.authenticate(stage,Config.playerio_game_id,"secure",{
            "userId":param2,
            "authToken":param1
         },["parter:" + Global.affiliate],param3,this.handleFailedAuth);
      }
      
      public function authenticateWithMouseBreaker(param1:String, param2:Function) : void
      {
         var urlloader:URLLoader = null;
         var token:String = param1;
         var callback:Function = param2;
         var request:URLRequest = new URLRequest("http://api.playerio.com/clientintegrations/mousebreaker/auth?game=3&token=" + token);
         urlloader = new URLLoader();
         urlloader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var e:Event = param1;
            var vars:Array = urlloader.data.toString().split("\n");
            var mbuid:String = vars[0];
            var mbauth:String = vars[1];
            PlayerIO.connect(stage,Config.playerio_game_id,"secure",mbuid,mbauth,Global.affiliate,function(param1:Client):void
            {
               callback(param1);
            },function(param1:PlayerIOError):void
            {
            });
         });
         urlloader.load(request);
      }
      
      private function handleReturnToLobbyError(param1:PlayerIOError) : void
      {
         this.showLobby();
      }
      
      private function handleFailedAuth(param1:PlayerIOError) : void
      {
         this.authenticateUser();
      }
      
      private function authenticateUser() : void
      {
         var _loc1_:Object = LoaderInfo(root.loaderInfo).parameters;
         var _loc2_:String = _loc1_.kongregate_api_path;
         if(Global.playing_on_kongregate && _loc2_)
         {
            this.authenticateWithKongregate(_loc2_);
         }
         else if(this.roomname != null && this.roomname != "")
         {
            this.authenticateAsGuest();
         }
         else
         {
            this.baseInit();
         }
      }
      
      public function authenticateAsGuest(param1:Function = null) : void
      {
         var callback:Function = param1;
         PlayerIO.quickConnect.simpleConnect(stage,Config.playerio_game_id,"guest","guest",function(param1:Client):void
         {
            if(Config.use_debug_server)
            {
               param1.multiplayer.developmentServer = Config.developer_server;
            }
            Global.player_is_guest = true;
            if(callback != null)
            {
               callback(param1);
               return;
            }
            simpleConnect(param1);
         },this.handleError);
      }
      
      private function baseInit() : void
      {
         setTimeout(function():void
         {
            showMainLogin();
         },!!Config.run_in_development_mode?Number(0):Number(400));
      }
      
      public function cleanCookie() : void
      {
         Global.cookie.data.access_token = "";
         Global.cookie.data.facebookuserid = "";
         Global.cookie.data.username = "";
         Global.cookie.data.password = "";
         Global.cookie.data.remember = false;
         Global.cookie.data.currentCrew = "";
         Global.cookie.data.currentCrewName = "";
         Global.cookie.data.hotbarSmileys = [];
         Global.cookie.flush();
      }
      
      public function logout(param1:Function = null) : void
      {
         Bl.data.brick = 0;
         Bl.data.base = this;
         Bl.data.iskongregate = false;
         Bl.data.config = [0,9,10,11,16,17,18,29,32,2,100];
         Global.chatIsVisible = false;
         Global.player_is_beta_member = false;
         Bl.data.roomname = "";
         Bl.data.name = "";
         Global.currentCrew = "";
         Global.currentCrewName = "";
         if(this.bp && this.bp.parent)
         {
            this.bp.parent.removeChild(this.bp);
         }
         this.cleanCookie();
         if(state && state is LobbyState)
         {
            LobbyState(state).reset();
            LobbyState(state).removeBackgrounds();
         }
         var _loc2_:LoadState = new LoadState();
         state = _loc2_;
         Global.client = this.client = null;
         Global.isFirstLogin = false;
         Global.player_is_guest = true;
         this.disconnectRPC();
         this.baseInit();
         if(param1 != null)
         {
            param1();
         }
      }
      
      public function showMainLogin() : void
      {
         clearOverlayContainer();
         this.cleanUIAndConnections();
         this.mainlogin = new MainLogin();
         overlayContainer.addChild(this.mainlogin);
      }
      
      public function showLoginWindow() : void
      {
         clearOverlayContainer();
         this.cleanUIAndConnections();
         this.loginwindow = new LoginWindow();
         overlayContainer.addChild(this.loginwindow);
      }
      
      public function showKongregateLoginWindow() : void
      {
         this.kongregate.services.showSignInBox();
      }
      
      private function handleLoginClose(param1:MouseEvent) : void
      {
         this.lb.stopAll();
         this.lb.parent.removeChild(this.lb);
         this.authenticateAsGuest();
      }
      
      private function hideLogin() : void
      {
         if(this.lb)
         {
            this.lb.stopAll();
            if(this.lb.parent)
            {
               this.lb.parent.removeChild(this.lb);
            }
         }
      }
      
      public function setCrewName(param1:String) : void
      {
         if(state as LobbyState != null)
         {
            if((state as LobbyState).shopbar != null)
            {
               (state as LobbyState).shopbar.setCrewName(param1);
            }
         }
      }
      
      public function refresShop() : void
      {
         this.showLoadingScreen("Loading Shop");
         Shop.refresh(function():void
         {
            hideLoadingScreen();
         });
      }
      
      public function refreshCrewShop() : void
      {
         Shop.refreshCrewShop(function():void
         {
            hideLoadingScreen();
         });
      }
      
      public function buyGemsWithKongregate(param1:int, param2:Function) : void
      {
         var count:int = param1;
         var callback:Function = param2;
         this.kongregate.mtx.purchaseItems(["coins" + count],function(param1:Object):void
         {
            var result:Object = param1;
            setTimeout(function():void
            {
               Shop.refresh(callback(count));
            },1000);
         });
      }
      
      public function buyGemsWithFacebook(param1:int, param2:Function) : void
      {
         var count:int = param1;
         var callback:Function = param2;
         this.client.payVault.getBuyCoinsInfo("facebookv2",{
            "coinamount":count,
            "title":count + " Gems",
            "description":"Buy " + count + " Gems for Everybdoy Edits",
            "image":"http://cdn.playerio.com/everybody-edits-su9rn58o40itdbnw69plyw/Everybody%20Edits/img/ee100x100.png"
         },function(param1:Object):void
         {
            var info:Object = param1;
            FB.ui(info,function(param1:Object):void
            {
               var fbdata:Object = param1;
               if(fbdata.order_id)
               {
                  setTimeout(function():void
                  {
                     Shop.refresh(callback(count));
                  },1000);
               }
               else
               {
                  Shop.refresh(callback(count));
               }
            });
         },function(param1:PlayerIOError):void
         {
         });
      }
      
      public function addToFavorites() : void
      {
         if(this.connection != null && !Bl.data.inFavorites)
         {
            this.connection.send("favorite");
         }
      }
      
      public function removeFromFavorites() : void
      {
         if(this.connection != null && Bl.data.inFavorites)
         {
            this.connection.send("unfavorite");
         }
      }
      
      public function giveLike() : void
      {
         if(this.connection != null && !Bl.data.liked)
         {
            this.connection.send("like");
         }
      }
      
      public function removeLike() : void
      {
         if(this.connection != null && Bl.data.liked)
         {
            this.connection.send("unlike");
         }
      }
      
      public function setGoldBorder(param1:Boolean) : void
      {
         if(this.connection != null && Global.playerObject.goldmember)
         {
            this.connection.send("smileyGoldBorder",param1);
         }
      }
      
      public function showRecoverPassword(param1:Boolean = false) : void
      {
         var r:ResetPassword = null;
         var bg:BlackBG = null;
         var loggedIn:Boolean = param1;
         if(!loggedIn)
         {
            clearOverlayContainer();
         }
         r = new ResetPassword();
         bg = new BlackBG();
         if(loggedIn)
         {
            overlayContainer.addChild(bg);
            r.x = Config.maxwidth / 2 - r.width / 2;
            r.y = 8;
         }
         overlayContainer.addChild(r);
         r.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         r.close.addEventListener(MouseEvent.CLICK,function():void
         {
            if(!loggedIn)
            {
               showMainLogin();
            }
            else
            {
               overlayContainer.removeChild(r);
            }
            overlayContainer.removeChild(bg);
         });
      }
      
      public function showRegister(param1:Number = -1) : void
      {
         var r:RegisterWindow = null;
         var captchaKeyStr:String = null;
         var ox:Number = param1;
         var getCaptcha:Function = function():void
         {
            PlayerIO.quickConnect.simpleGetCaptcha(Config.playerio_game_id,107,37,function(param1:String, param2:String):void
            {
               captchaKeyStr = param1;
               r.setCaptchaImage(param2);
            },function():void
            {
            });
         };
         clearOverlayContainer();
         if(Global.playing_on_kongregate)
         {
            Global.base.showKongregateLoginWindow();
            return;
         }
         if(this.client == null)
         {
            this.authenticateAsGuest(function(param1:Client):void
            {
               client = param1;
               showRegister();
            });
            return;
         }
         r = new RegisterWindow();
         captchaKeyStr = "noKey";
         if(ox == -1)
         {
            r.x = (850 - r.width) / 2 - 35;
         }
         else
         {
            r.x = ox;
         }
         r.name = "RegisterWindow";
         r.stop();
         r.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         overlayContainer.addChild(r);
         getCaptcha();
         r.btnReloadCaptcha.addEventListener(MouseEvent.CLICK,function():void
         {
            getCaptcha();
         });
         r.close.tabEnabled = false;
         r.close.addEventListener(MouseEvent.CLICK,function():void
         {
            if(state is LobbyState)
            {
               clearOverlayContainer();
            }
            else
            {
               showMainLogin();
            }
         });
         r.termsbutton.addEventListener(MouseEvent.CLICK,function():void
         {
            var _loc1_:* = r.termsbutton.currentFrame == 2;
            r.termsbutton.gotoAndStop(!!_loc1_?1:2);
            r.registerbutton.gotoAndStop(!!_loc1_?2:1);
            r.registerbutton.mouseEnabled = !_loc1_;
         });
         r.registerbutton.addEventListener(MouseEvent.CLICK,function():void
         {
            r.bg_mail.gotoAndStop(1);
            r.bg_password.gotoAndStop(1);
            r.bg_password2.gotoAndStop(1);
            r.bg_captcha.gotoAndStop(1);
            r.errors.text = "";
            if(r.hasEmptyFields())
            {
               r.errors.text = "All fields should be filled out";
               return;
            }
            var validEmailRegExp:RegExp = /([a-z0-9._-]+)@([a-z0-9.-]+)\.([a-z]{2,4})/;
            if(!validEmailRegExp.test(r.inpemail.text))
            {
               r.bg_mail.gotoAndStop(2);
               r.errors.text = "Not a proper email.";
               return;
            }
            if(r.inppassword.text != r.inppassword2.text)
            {
               r.bg_password.gotoAndStop(2);
               r.bg_password2.gotoAndStop(2);
               r.errors.text = "Passwords does not match";
               return;
            }
            r.lock(true);
            r.registerbutton.visible = false;
            PlayerIO.quickConnect.simpleRegister(Bl.stage,Config.playerio_game_id,new Date().time + "x" + (Math.random() * 100 >> 0),r.inppassword.text,r.inpemail.text,captchaKeyStr,r.inpcaptcha.text,!!Global.affiliate?{"affiliate":Global.affiliate}:{},Global.affiliate,function(param1:Client):void
            {
               var requests:int = 0;
               var c:Client = param1;
               disconnectRPC();
               client = c;
               Global.player_is_guest = false;
               if(Config.use_debug_server)
               {
                  client.multiplayer.developmentServer = Config.developer_server;
               }
               requests = 1;
               var returned:int = 0;
               var onNameAndTerms:Function = function():void
               {
                  if(++returned == requests)
                  {
                     forceShowToturial = true;
                     overlayContainer.removeChild(r);
                     cleanUIAndConnections();
                     Global.isFirstLogin = true;
                     state = new LoadState();
                     simpleConnect(c);
                  }
               };
               requestRemoteMethod("acceptTerms",onNameAndTerms);
            },function(param1:PlayerIORegistrationError):void
            {
               r.errors.text = "";
               if(param1.usernameError != null)
               {
                  r.errors.appendText(param1.usernameError + "\n");
               }
               if(param1.emailError != null)
               {
                  r.errors.appendText(param1.emailError + "\n");
                  r.bg_mail.gotoAndStop(2);
               }
               if(param1.passwordError != null)
               {
                  r.errors.appendText(param1.passwordError + "\n");
                  r.bg_password.gotoAndStop(2);
                  r.bg_password2.gotoAndStop(2);
               }
               if(param1.captchaError != null)
               {
                  r.errors.appendText(param1.captchaError + "\n");
                  r.bg_captcha.gotoAndStop(2);
               }
               r.registerbutton.visible = true;
               r.lock(false);
            });
         });
      }
      
      private function setError(param1:TextField, param2:Boolean) : void
      {
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.color = !!param2?16711680:16777215;
         param1.setTextFormat(_loc3_,-1,-1);
      }
      
      public function simpleConnect(param1:Client, param2:String = "") : void
      {
         var c:Client = param1;
         var id:String = param2;
         clearOverlayContainer();
         this.loadAndInitPlayer(c,function():void
         {
            if(roomname)
            {
               setTimeout(function():void
               {
                  LoadState(state).fadeOut(function():void
                  {
                     joinRoom(roomname,true);
                  });
               },!!Config.run_in_development_mode?Number(0):Number(500));
            }
            else if(Global.isFirstLogin && c.connectUserId != "simpleguest")
            {
               joinRoom(Global.playerObject.homeworld,true);
            }
            else
            {
               showLobby(LoadState(state));
            }
         });
      }
      
      public function SystemSay(param1:String, param2:String = "* Warning") : void
      {
         if(this.sidechat)
         {
            this.sidechat.addLine(param2,param1,16777215);
         }
      }
      
      public function showKongregatePayment() : void
      {
         var kongbox:BetaProgramInfoKong = null;
         LobbyState(state).reset();
         LobbyState(state).removeBackgrounds();
         kongbox = new BetaProgramInfoKong();
         kongbox.closebtn.addEventListener(MouseEvent.CLICK,function():void
         {
            if(kongbox.parent)
            {
               kongbox.parent.removeChild(kongbox);
            }
            showLobby();
         });
         kongbox.buybtn.addEventListener(MouseEvent.CLICK,function():void
         {
            kongbox.buybtn.visible = false;
            kongregate.mtx.purchaseItems(["itempro"],function(param1:Object):void
            {
               if(param1.success)
               {
                  if(kongbox.parent)
                  {
                     kongbox.parent.removeChild(kongbox);
                  }
                  Global.player_is_beta_member = true;
                  showLobby();
               }
               else
               {
                  kongbox.buybtn.visible = true;
               }
            });
         });
         overlayContainer.addChild(kongbox);
      }
      
      private function handleFacebookAuthSuccess(param1:Client, param2:String, param3:String) : void
      {
         var c:Client = param1;
         var access_token:String = param2;
         var facebookuserid:String = param3;
         clearOverlayContainer();
         Global.cookie.data.access_token = access_token;
         Global.cookie.data.facebookuserid = facebookuserid;
         Global.cookie.data.remember = true;
         Global.cookie.flush();
         this.loadAndInitPlayer(c,function():void
         {
            if(roomname)
            {
               setTimeout(function():void
               {
                  LoadState(state).fadeOut(function():void
                  {
                     joinRoom(roomname,true);
                  });
               },!!Config.run_in_development_mode?Number(0):Number(500));
            }
            else
            {
               showLobby(LoadState(state));
            }
         });
      }
      
      private function acceptTermsAndConditions(param1:SimplePlayerObject, param2:Client, param3:Function) : void
      {
         var o:SimplePlayerObject = param1;
         var c:Client = param2;
         var callback:Function = param3;
         this.getRPCConnection(function(param1:Connection):void
         {
            var _loc2_:TermsWindow = null;
            if(o.accepted_terms != Config.termsVersion && c.connectUserId != "simpleguest")
            {
               clearOverlayContainer();
               _loc2_ = new TermsWindow(callback);
               overlayContainer.addChild(_loc2_);
            }
            else
            {
               callback();
            }
         },this.handleError);
      }
      
      private function migrateUsername(param1:SimplePlayerObject, param2:Client, param3:Function) : void
      {
         var o:SimplePlayerObject = param1;
         var c:Client = param2;
         var callback:Function = param3;
         this.getRPCConnection(function(param1:Connection):void
         {
            var _loc2_:UsernameWindow = null;
            if(!o.name && c.connectUserId != "simpleguest")
            {
               clearOverlayContainer();
               _loc2_ = new UsernameWindow(callback,false);
               overlayContainer.addChild(_loc2_);
            }
            else
            {
               callback();
            }
         },this.handleError);
      }
      
      public function checkChangeUsername(param1:SimplePlayerObject, param2:Client, param3:Function) : void
      {
         var o:SimplePlayerObject = param1;
         var c:Client = param2;
         var callback:Function = param3;
         this.getRPCConnection(function(param1:Connection):void
         {
            var _loc2_:UsernameWindow = null;
            var _loc3_:BlackBG = null;
            if(o.changename && c.connectUserId != "simpleguest")
            {
               clearOverlayContainer();
               _loc2_ = new UsernameWindow(callback,true);
               if(state is LobbyState)
               {
                  _loc3_ = new BlackBG();
                  _loc2_.x = Global.fullWidth / 2 - _loc2_.x / 2;
                  overlayContainer.addChild(_loc3_);
               }
               overlayContainer.addChild(_loc2_);
            }
            else
            {
               callback();
            }
         },this.handleError);
      }
      
      private function loadAndInitPlayer(param1:Client, param2:Function, param3:Boolean = true) : void
      {
         var c:Client = param1;
         var callback:Function = param2;
         var showlog:Boolean = param3;
         this.client = c;
         Shop.setBase(this,c);
         Global.client = c;
         c.bigDB.load("Config","staff",function(param1:DatabaseObject):void
         {
            Bl.StaffObject = param1;
         });
         if(Config.use_debug_server)
         {
            this.client.multiplayer.developmentServer = Config.developer_server;
         }
         if(c.connectUserId == "simpleguest")
         {
            Global.player_is_guest = true;
            Global.sharedCookie.data.guestvisit = (Global.sharedCookie.data.guestvisit || 0) + 1;
         }
         else
         {
            Global.player_is_guest = false;
            Global.sharedCookie.data.guestvisit = 0;
            Global.sharedCookie.data.hasLoggedIn = true;
         }
         c.payVault.refresh(function():void
         {
            updatePlayerProperties(function():void
            {
               acceptTermsAndConditions(Global.playerObject,c,function():void
               {
                  checkChangeUsername(Global.playerObject,c,function():void
                  {
                     migrateUsername(Global.playerObject,c,callback);
                  });
               });
               if(!Global.player_is_guest)
               {
                  setTimezone();
               }
               try
               {
                  initializeAd();
                  return;
               }
               catch(error:Error)
               {
                  return;
               }
            });
         });
      }
      
      public function canUseBlock(param1:ItemBrick) : Boolean
      {
         if(param1.payvaultid == "" || this.client.payVault.has(param1.payvaultid) || param1.payvaultid == "pro" && Global.player_is_beta_member || param1.payvaultid == "goldmember" && Global.playerObject.goldmember)
         {
            if((param1.id == 77 || param1.id == 83) && !Global.hasOwner)
            {
               return false;
            }
            if((!param1.requiresAdmin || Bl.data.isAdmin) && !param1.requiresOwnership || (Bl.data.owner || Bl.data.isAdmin))
            {
               return true;
            }
         }
         return false;
      }
      
      private function setTimezone() : void
      {
         this.requestRemoteMethod("timezone",null,new Date().timezoneOffset);
      }
      
      public function fbconnect(param1:Boolean) : void
      {
         PlayerIO.quickConnect.facebookOAuthConnectPopup(stage,Config.playerio_game_id,"facebookpopup",!!param1?["offline_access"]:[],Global.affiliate || null,this.handleFacebookAuthSuccess,this.handleError);
      }
      
      private function showLobby(param1:LoadState = null, param2:String = "") : void
      {
         var self:EverybodyEdits = null;
         var lstate:LoadState = param1;
         var tab:String = param2;
         Global.setPath("Everybody Edits","/");
         Global.getPlacer = false;
         this.cleanUIAndConnections();
         state = lstate = lstate || new LoadState();
         if(this.upgrade)
         {
            return;
         }
         self = this;
         setTimeout(function():void
         {
            var rooms1:Array = null;
            var rooms2:Array = null;
            var to_load:int = 0;
            var welcomeBack:WelcomeBack = null;
            var firstDailyLogin:Boolean = false;
            var ready:Function = function():void
            {
               var cookieConfirmEmailKey:String = Global.sharedCookie.data.confirmkey;
               if(cookieConfirmEmailKey != null && cookieConfirmEmailKey != "")
               {
                  requestRemoteMethod("confirmEmail",function(param1:Message):void
                  {
                     Global.sharedCookie.data.confirmkey = null;
                     Global.sharedCookie.flush();
                     if(param1.getBoolean(0))
                     {
                        showLobby();
                     }
                     else
                     {
                        ready();
                     }
                  },cookieConfirmEmailKey);
                  return;
               }
               lstate.fadeOut(function():void
               {
                  state = new LobbyState(rooms1.concat(rooms2),joinRoom,createRoom,joinMyRoom,iseecom,self,handleJoinSaved,welcomeBack,firstDailyLogin,tab);
               });
            };
            rooms1 = [];
            rooms2 = [];
            var loaded:int = 0;
            to_load = 3;
            Badges.refresh(function():void
            {
               if(++loaded == to_load)
               {
                  ready();
               }
            });
            updatePlayerProperties(function():void
            {
               if(++loaded == to_load)
               {
                  ready();
               }
            });
            welcomeBack = null;
            firstDailyLogin = false;
            if(Global.player_is_guest)
            {
               if(++loaded == to_load)
               {
                  ready();
               }
            }
            else
            {
               requestRemoteMethod("getLobbyProperties",function(param1:Message):void
               {
                  var msg:Message = param1;
                  firstDailyLogin = msg.getBoolean(0);
                  var streak:int = msg.getInt(1);
                  if(firstDailyLogin && streak >= 0)
                  {
                     welcomeBack = new WelcomeBack(streak,msg);
                  }
                  Shop.reset(function():void
                  {
                     if(++loaded == to_load)
                     {
                        ready();
                     }
                  });
               });
            }
         },!!Config.run_in_development_mode?Number(0):Number(500));
      }
      
      private function getBetaRooms(param1:Function) : void
      {
         if(Global.player_is_beta_member)
         {
            this.client.multiplayer.listRooms(Config.server_type_betaroom,{},0,0,param1);
         }
         else
         {
            param1([]);
         }
      }
      
      private function joinRoom(param1:String, param2:Boolean = false) : void
      {
         var rid:String = param1;
         var direct:Boolean = param2;
         this.cleanUIAndConnections();
         state = new JoinState();
         if(rid.substring(0,2) == "PW" || rid.substring(0,2) == "BW")
         {
            this.joinSaved(rid);
         }
         else
         {
            this.client.multiplayer.joinRoom(rid,{},function(param1:Connection):void
            {
               handleJoin(param1,rid,direct);
            },this.handleReturnToLobbyError);
         }
      }
      
      private function joinSaved(param1:String) : void
      {
         var roomid:String = param1;
         this.cleanUIAndConnections();
         roomid = roomid.split(" ").join("-");
         this.client.multiplayer.createJoinRoom(roomid,roomid.substring(0,2) == "BW"?Config.server_type_betaroom:Config.server_type_normalroom,true,{"owned":"true"},{},function(param1:Connection):void
         {
            handleJoin(param1,roomid,false,true);
         },this.handleReturnToLobbyError);
      }
      
      private function handleJoinSaved(param1:int, param2:int) : void
      {
         var type:int = param1;
         var offset:int = param2;
         state = new JoinState();
         this.getRPCConnection(function(param1:Connection):void
         {
            var con:Connection = param1;
            con.addMessageHandler("r",function(param1:Message, param2:String):void
            {
               joinSaved(param2);
               con.removeMessageHandler("r",arguments.callee);
            });
            con.send("getSavedLevel",type,offset);
         },this.handleReturnToLobbyError);
      }
      
      private function joinMyRoom(param1:Boolean = false) : void
      {
         var isbetaroom:Boolean = param1;
         if(!Global.player_is_beta_member)
         {
            return;
         }
         state = new JoinState();
         this.getRPCConnection(function(param1:Connection):void
         {
            var con:Connection = param1;
            con.addMessageHandler("r",function(param1:Message, param2:String):void
            {
               joinSaved(param2);
               con.removeMessageHandler("r",arguments.callee);
            });
            con.send(!!isbetaroom?"getBetaRoom":"getRoom");
         },this.handleReturnToLobbyError);
      }
      
      private function showUpgradeScreen(param1:Message) : void
      {
         var m:Message = param1;
         this.showDisconnectedMessage = false;
         if(this.upgrade)
         {
            return;
         }
         var upg:Upgrade = new Upgrade();
         upg.blog.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            openNewPage(Config.url_blog);
         });
         upg.reload.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            openPage(Config.site);
         });
         upg.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopPropagation();
            param1.stopImmediatePropagation();
         });
         overlayContainer.addChild(upg);
         this.upgrade = true;
      }
      
      private function handleJoin(param1:Connection, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
         var self:EverybodyEdits = null;
         var connection:Connection = param1;
         var roomid:String = param2;
         var direct:Boolean = param3;
         var isLockedRoom:Boolean = param4;
         Global.roomid = roomid;
         if(Bl.data.isbeta || Bl.data.onsite || Bl.stage.stageWidth > 700)
         {
            this.sidechat = new SideChat(connection);
            this.sidechat.x = 640 - 1;
         }
         this.deltas = [];
         this.inited = false;
         self = this;
         this.connection = connection;
         connection.addMessageHandler("banned",function(param1:Message):void
         {
            SoundManager.playSound(SoundId.BANNED);
         });
         connection.addMessageHandler("upgrade",this.showUpgradeScreen);
         connection.addMessageHandler("info",function(param1:Message, param2:String, param3:String):void
         {
            showInfo(param2,param3);
         });
         connection.addMessageHandler("info2",function(param1:Message, param2:String, param3:String):void
         {
            if(infoBox != null)
            {
               if(overlayContainer.contains(infoBox))
               {
                  if(infoBox.timer.running)
                  {
                     infoBox.timer.stop();
                  }
                  overlayContainer.removeChild(infoBox);
               }
               showInfo2(param2,param3);
            }
            else
            {
               showInfo2(param2,param3);
            }
         });
         connection.addMessageHandler("copyPrompt",function(param1:Message, param2:String, param3:String, param4:String = ""):void
         {
            showCopyPrompt(new CopyPrompt(param2,param3,param4));
         });
         connection.addMessageHandler("init",function(param1:Message, param2:String, param3:String, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Boolean, param12:int, param13:int, param14:uint, param15:String, param16:Boolean, param17:Boolean, param18:Boolean, param19:Boolean, param20:int, param21:int, param22:Number, param23:uint, param24:Boolean, param25:Boolean, param26:Boolean, param27:String, param28:int, param29:int, param30:Boolean, param31:String, param32:String, param33:Boolean, param34:int, param35:String, param36:Boolean, param37:Boolean, param38:Boolean, param39:ByteArray):void
         {
            if(sidechat)
            {
               sidechat.setMe(param7.toString(),param15,Global.canchat,0,Global.playerObject.goldmember,param14);
               sidechat.setMetaData(param2,param3,param4,param5,param6);
            }
            Bl.data.isLockedRoom = isLockedRoom || !param16 || param17;
            Bl.data.isOpenWorld = !isLockedRoom;
            Bl.data.isCampaignRoom = param30;
            Bl.data.owner = param17;
            Bl.data.inFavorites = param18;
            Bl.data.liked = param19;
            Bl.data.canChangeWorldOptions = param33;
            Global.hasOwner = param2 != "";
            Global.currentLevelname = param3;
            Global.worldOwner = param2;
            Global.currentLevelCrew = param31;
            Global.currentLevelCrewName = param32;
            Global.currentLevelStatus = param34;
            if(Bl.data.canChangeWorldOptions)
            {
               Global.bgColor = param23;
               Global.backgroundEnabled = (param23 >> 24 & 255) == 255;
            }
            if(param31 == "everybodyeditsstaff")
            {
               Global.hasSubscribedToCrew = true;
            }
            else
            {
               Global.hasSubscribedToCrew = false;
               Global.base.requestRemoteMethod("isSubscribedToCrew",handleSubscribeCheck,param31);
            }
            state = new PlayState(connection,param1,param7,param15,param8,param9,param10,param11,param12,param13,param14,param35,param20,param21,param22,param23,param36,param39);
            Bl.data.canEdit = param16;
            Bl.data.canToggleGodMode = param16;
            ui2instance = new UI2(self,connection,param1,param7,param16,roomid,sidechat,param24,param25,param26,param27,param28,param29,param37,param38);
            ui2instance.y = 500;
            overlayContainer.addChild(ui2instance);
            if(sidechat)
            {
               overlayContainer.addChild(sidechat);
            }
         });
         connection.addDisconnectHandler(function():void
         {
            if(showDisconnectedMessage)
            {
               showInfo("Disconnected","Lost connection with Everybody Edits :(");
            }
            showLobby();
            if(ui2instance && ui2instance.parent)
            {
               overlayContainer.removeChild(ui2instance);
            }
            if(sidechat && sidechat.parent)
            {
               overlayContainer.removeChild(sidechat);
            }
         });
         this.inited = true;
         connection.send("init");
      }
      
      private function handleSubscribeCheck(param1:Message) : void
      {
         Global.hasSubscribedToCrew = param1.getBoolean(0);
      }
      
      public function showPrompt(param1:Prompt) : void
      {
         overlayContainer.addChild(param1);
         TweenMax.to(param1,0,{"alpha":0});
         TweenMax.to(param1,0.2,{"alpha":1});
      }
      
      public function showCopyPrompt(param1:CopyPrompt) : void
      {
         overlayContainer.addChild(param1);
         TweenMax.to(param1,0,{"alpha":0});
         TweenMax.to(param1,0.2,{"alpha":1});
      }
      
      public function showConfirmPrompt(param1:ConfirmPrompt) : void
      {
         overlayContainer.addChild(param1);
         TweenMax.to(param1,0,{"alpha":0});
         TweenMax.to(param1,0.2,{"alpha":1});
      }
      
      public function showLevelOptions(param1:LevelOptions) : void
      {
         overlayContainer.addChild(param1);
         TweenMax.to(param1,0,{"alpha":0});
         TweenMax.to(param1,0.2,{"alpha":1});
      }
      
      public function showLevelComplete(param1:LevelComplete) : void
      {
         if(overlayContainer.getChildByName("LevelCompleteScreen"))
         {
            return;
         }
         overlayContainer.addChild(param1);
         TweenMax.to(param1,0,{"alpha":0});
         TweenMax.to(param1,0.2,{"alpha":1});
      }
      
      public function showCampaignComplete(param1:CampaignComplete) : void
      {
         this.cc = param1;
         if(overlayContainer.getChildByName("CampaignCompleteScreen"))
         {
            return;
         }
         overlayContainer.addChild(this.cc);
         TweenMax.to(this.cc,0,{"alpha":0});
         TweenMax.to(this.cc,0.2,{"alpha":1});
      }
      
      public function hideCampaignComplete() : void
      {
         if(this.cc)
         {
            TweenMax.to(this.cc,0.5,{
               "alpha":0,
               "onComplete":function():void
               {
                  overlayContainer.removeChild(cc);
               }
            });
         }
      }
      
      public function showUi() : void
      {
         if(this.ui2instance != null)
         {
            this.ui2instance.configureInterface();
         }
      }
      
      public function hideUi() : void
      {
         if(this.ui2instance != null)
         {
            this.ui2instance.configureInterface();
         }
      }
      
      public function toggleUI() : void
      {
         Global.showUI = !Global.showUI;
         Global.base.ui2instance.toggleVisible(Global.showUI);
         Global.base.sidechat.toggleVisible(Global.showUI);
      }
      
      public function awardSwappits() : void
      {
         if(new Date().time - this.swapittimer.data.lastCoin < 1000 * 60 * 60 * 1)
         {
            return;
         }
         this.swapittimer.data.lastCoin = this.swapittimer.data.lastCoin || 0;
         this.swapittimer.data.lastCoin = new Date().time;
         this.swapittimer.flush();
         if(!Bl.data.isswappit)
         {
            return;
         }
         var req:URLRequest = new URLRequest("http://playerio.com/clientintegrations/swapits/award");
         req.method = URLRequestMethod.GET;
         var vars:URLVariables = new URLVariables();
         vars.username = Bl.data.swappitusername;
         vars.swapits = 10;
         vars.reason = "You earned 10 swapits for finding a swapit coin in Everybody Edits!";
         req.data = vars;
         var loader:URLLoader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,function():void
         {
            showInfo("Congratulations","You just found an Everybody Edits swapit coin and earned 10 swapits!");
         });
         loader.load(req);
      }
      
      public function showInfo2(param1:String, param2:String) : void
      {
         var mouseDown:Boolean = false;
         var title:String = param1;
         var body:String = param2;
         mouseDown = false;
         this.infoBox = new InfoDisplay(title,body);
         this.infoBox.alpha = 0;
         this.infoBox.x = (640 - this.infoBox.width) / 2;
         this.infoBox.y = -this.infoBox.height - 10;
         overlayContainer.addChild(this.infoBox);
         var pullDownY:Number = this.infoBox.y + 10;
         TweenMax.to(this.infoBox,0.4,{
            "alpha":1,
            "y":10,
            "ease":Back.easeOut
         });
         TweenPlugin.activate([GlowFilterPlugin]);
         TweenMax.to(this.infoBox,1,{
            "repeat":3,
            "yoyo":true,
            "glowFilter":{
               "color":11184810,
               "blurX":7,
               "blurY":7,
               "strength":1,
               "alpha":1
            }
         });
         this.infoBox.buttonMode = true;
         this.infoBox.useHandCursor = true;
         this.infoBox.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            if(infoBox.timer.running)
            {
               infoBox.timer.stop();
            }
            mouseDown = true;
            TweenMax.to(infoBox,0.4,{"y":infoBox.y + 10});
         });
         this.infoBox.addEventListener(MouseEvent.MOUSE_UP,function(param1:MouseEvent):void
         {
            mouseDown = false;
            hideInfoDisplay();
         });
         this.infoBox.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):void
         {
            if(mouseDown)
            {
               if(!infoBox.timer.running)
               {
                  infoBox.timer.start();
               }
               mouseDown = false;
               TweenMax.to(infoBox,0.4,{"y":infoBox.y - 10});
            }
         });
      }
      
      public function hideInfoDisplay() : void
      {
         TweenMax.to(this.infoBox,0.2,{
            "y":-this.infoBox.height - 10,
            "alpha":0,
            "onComplete":function():void
            {
               if(overlayContainer.contains(infoBox))
               {
                  overlayContainer.removeChild(infoBox);
               }
            },
            "ease":Back.easeIn
         });
      }
      
      public function showInfo(param1:String, param2:String, param3:Number = -1, param4:Boolean = false) : void
      {
         var bg:BlackBG = null;
         var inf:InfoBox = null;
         var title:String = param1;
         var body:String = param2;
         var prefferedWidth:Number = param3;
         var modal:Boolean = param4;
         this.showDisconnectedMessage = false;
         bg = new BlackBG();
         inf = new InfoBox();
         inf.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         bg.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         inf.ttitle.autoSize = TextFieldAutoSize.LEFT;
         inf.ttitle.text = Badwords.Filter(title);
         inf.tbody.autoSize = TextFieldAutoSize.LEFT;
         inf.tbody.text = Badwords.Filter(body);
         if(prefferedWidth != -1)
         {
            inf.tbody.width = prefferedWidth;
         }
         var newwidth:int = Math.max(inf.ttitle.width,inf.tbody.width) + 30;
         var offset_x:Number = (newwidth - inf.bg.width) / 2;
         inf.bg.x = inf.bg.x - offset_x;
         inf.ttitle.x = inf.ttitle.x - offset_x;
         inf.ttitle.y = inf.ttitle.y - 5;
         inf.tbody.x = inf.tbody.x - offset_x;
         inf.bg.width = newwidth;
         inf.bg.height = inf.tbody.y - inf.bg.y + inf.tbody.height + 40;
         inf.closebtn.x = inf.bg.x + inf.bg.width;
         inf.closebtn.addEventListener(MouseEvent.CLICK,function():void
         {
            TweenMax.to(inf,0.2,{
               "alpha":0,
               "onComplete":function():void
               {
                  TweenMax.to(bg,0.25,{
                     "alpha":0,
                     "onComplete":function():void
                     {
                        overlayContainer.removeChild(bg);
                        overlayContainer.removeChild(inf);
                     }
                  });
               }
            });
            showDisconnectedMessage = true;
         });
         if(modal)
         {
            inf.closebtn.visible = false;
         }
         overlayContainer.addChild(bg);
         overlayContainer.addChild(inf);
         TweenMax.to(inf,0,{"alpha":0});
         TweenMax.to(bg,0,{"alpha":0});
         TweenMax.to(inf,0.2,{"alpha":1});
         TweenMax.to(bg,0.3,{"alpha":1});
      }
      
      public function showLoadingScreen(param1:String) : void
      {
         if(this.loading != null)
         {
            overlayContainer.removeChild(this.loading);
         }
         var _loc2_:* = this.loading == null;
         this.loading = new LoadingScreen(param1);
         this.loading.alpha = 0;
         overlayContainer.addChild(this.loading);
         if(_loc2_)
         {
            TweenMax.to(this.loading,0.4,{"alpha":1});
         }
         else
         {
            this.loading.alpha = 1;
         }
      }
      
      public function hideLoadingScreen() : void
      {
         if(this.loading != null)
         {
            this.loading.close();
         }
      }
      
      private function createRoom(param1:String, param2:String = "") : void
      {
         var roomid:String = null;
         var rid:String = param1;
         var editkey:String = param2;
         Bl.data.roomname = rid;
         state = new JoinState();
         roomid = "OW" + this.generateUniqueRoomId(rid);
         this.client.multiplayer.createJoinRoom(roomid,Config.server_type_normalroom,true,editkey == ""?{"name":rid}:{
            "editkey":editkey,
            "name":rid
         },editkey == ""?{}:{"editkey":editkey},function(param1:Connection):void
         {
            handleJoin(param1,roomid,false,false);
         },this.handleReturnToLobbyError);
      }
      
      private function generateUniqueRoomId(param1:String) : String
      {
         return ((Math.random() * 1000 >> 0) + new Date().getMilliseconds()).toString(36) + " " + param1;
      }
      
      private function handleError(param1:Object) : void
      {
         var _loc2_:String = !!param1.hasOwnProperty("message")?param1.message:!!param1.hasOwnProperty("text")?param1.text:param1.toString();
         "We saved the error to our servers and are working on fixing it already!\n\n\nHorrible Error:\n" + _loc2_;
      }
      
      private function showBuyBetaMembershipOverlay(param1:Function) : void
      {
         var that:EverybodyEdits = null;
         var callback:Function = param1;
         that = this;
         this.client.payVault.getBuyCoinsInfo("superrewards",{},function(param1:Object):void
         {
            var info:Object = param1;
            hideLogin();
            bp.earnnowbtn.visible = bp.buywithcoinsbtn.visible = true;
            if(client.payVault.coins >= 100)
            {
               bp.cointext.text = "Success!!";
               bp.earnnowbtn.visible = false;
            }
            else
            {
               bp.cointext.text = "You need " + (100 - client.payVault.coins) + " Gems";
               bp.buywithcoinsbtn.visible = false;
               setTimeout(function():void
               {
                  var t:Number = NaN;
                  bp.cointext.text = "Refreshing, please wait...";
                  t = setTimeout(function():void
                  {
                     if(!bp.parent)
                     {
                        clearTimeout(t);
                        return;
                     }
                     loadAndInitPlayer(client,callback,false);
                  },1000);
               },10000);
            }
            if(!bp.parent)
            {
               bp.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
               {
                  param1.preventDefault();
                  param1.stopImmediatePropagation();
                  param1.stopPropagation();
               });
               bp.buybtn.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
               {
                  var e:MouseEvent = param1;
                  var paypalargs:Object = {
                     "currency":"USD",
                     "item_name":"Everybody Edits Beta Access",
                     "cpp_header_image":"http://playerio-a.akamaihd.net/everybody-edits-su9rn58o40itdbnw69plyw/Everybody%20Edits%20Website/images/ee_paypal_logo.png",
                     "on0":"UserID",
                     "os0":client.connectUserId,
                     "cancel_return":"http://beta.everybodyedits.com/",
                     "lc":"US"
                  };
                  paypalargs["return"] = "http://beta.everybodyedits.com/welcometobeta";
                  client.payVault.getBuyDirectInfo("paypal",paypalargs,[{"itemKey":"pro"}],function(param1:Object):void
                  {
                     navigateToURL(new URLRequest(param1.paypalurl),"_self");
                  },function(param1:PlayerIOError):void
                  {
                  });
                  bp.buybtn.visible = false;
               });
               bp.buywithcoinsbtn.addEventListener(MouseEvent.MOUSE_DOWN,function():void
               {
                  bp.buywithcoinsbtn.visible = false;
                  client.payVault.buy([{"itemKey":"pro"}],true,function():void
                  {
                     if(bp.parent)
                     {
                        bp.parent.removeChild(bp);
                     }
                     callback();
                  });
               });
               bp.earnnowbtn.addEventListener(MouseEvent.MOUSE_DOWN,function():void
               {
                  Shop.getMoreGems();
               });
            }
            overlayContainer.addChild(bp);
            var loginbox:LobbyLoginBox = new LobbyLoginBox(that);
            loginbox.ShowLogout();
            loginbox.y = 420 + 60 - 5;
            overlayContainer.addChild(loginbox);
            Shop.doFocus();
         });
      }
   }
}
