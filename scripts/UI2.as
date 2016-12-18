package
{
   import flash.display.Sprite;
   import ui2.ui2lobbybtn;
   import ui2.ui2godmodebtn;
   import ui2.ui2toggleminimapbtn;
   import ui2.ui2sharebtn;
   import ui2.ui2entereditkeybox;
   import ui.campaigns.CampaignInfo;
   import flash.display.BitmapData;
   import ui2.ui2chatbtn;
   import ui2.ui2chatinput;
   import ui.BrickContainer;
   import ui.brickselector.BrickSelector;
   import ui.brickselector.BrickPackage;
   import ui.ingame.settings.SettingsMenu;
   import playerio.Connection;
   import ui.shop.ShopBar;
   import ui.ingame.sam.SmileyAuraMenu;
   import ui.ingame.sam.SmileyAuraButton;
   import ui.ingame.FavLikeSelector;
   import ui.ingame.FavLikeButton;
   import ui.ingame.EffectDisplay;
   import ui.brickoverlays.PropertiesBackground;
   import ui.crews.CrewPrompt;
   import ui.ingame.settings.SettingsButton;
   import ui.ingame.pam.PlayerActionsMenu;
   import flash.events.Event;
   import items.ItemSmiley;
   import items.ItemAuraShape;
   import items.ItemAuraColor;
   import items.ItemManager;
   import ui.ingame.sam.SmileyInstance;
   import items.ItemBrickPackage;
   import items.ItemBrick;
   import blitter.Bl;
   import com.greensock.*;
   import items.ItemTab;
   import items.ItemId;
   import flash.geom.Point;
   import ui.brickoverlays.CoinProperties;
   import ui.brickoverlays.LabelProperties;
   import ui.brickoverlays.PortalProperties;
   import ui.brickoverlays.WorldPortalProperties;
   import ui.brickoverlays.DrumProperties;
   import ui.brickoverlays.PianoProperties;
   import ui.brickoverlays.TextSignProperties;
   import ui.brickoverlays.SwitchProperties;
   import ui.brickoverlays.DeathProperties;
   import ui.brickoverlays.TeamProperties;
   import ui.brickoverlays.TimeProperties;
   import ui.brickoverlays.OnOffProperties;
   import ui.brickoverlays.MultijumpProperties;
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   import states.PlayState;
   import ui.ReportPrompt;
   import mx.utils.StringUtil;
   import flash.events.MouseEvent;
   import ui.Prompts.ConfirmRulesPrompt;
   import flash.ui.Keyboard;
   import flash.text.TextField;
   import playerio.Message;
   import ui.chat.SideChat;
   import ui.chat.TabTextField;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import ui.Share;
   import events.Facebook.FB;
   import ui.campaigns.CampaignReward;
   import ui.campaigns.CampaignComplete;
   import ui.LevelComplete;
   import ui.ConfirmPrompt;
   import data.SimplePlayerObjectEvent;
   
   public class UI2 extends Sprite
   {
       
      
      private var lobby:ui2lobbybtn;
      
      private var godmode:ui2godmodebtn;
      
      private var toggleminimap:ui2toggleminimapbtn;
      
      private var share:ui2sharebtn;
      
      private var enterkey:ui2entereditkeybox;
      
      private var campaignInfo:CampaignInfo;
      
      private var bmd:BitmapData;
      
      private var bmd2:BitmapData;
      
      private var smiliesbmd:BitmapData;
      
      private var chatbtn:ui2chatbtn;
      
      private var chatinput:ui2chatinput;
      
      public var favoriteBricks:BrickContainer;
      
      private var bselector:BrickSelector;
      
      private var base:EverybodyEdits;
      
      private var brickPackagePopup:BrickPackage;
      
      private var roomid:String;
      
      public var settingsMenu:SettingsMenu;
      
      public var above:Sprite;
      
      public var connection:Connection;
      
      public var roomVisible:Boolean = false;
      
      public var roomHiddenFromLobby:Boolean = false;
      
      public var minimapEnabled:Boolean = true;
      
      public var lobbyPreviewEnabled:Boolean = true;
      
      public var allowSpectating:Boolean = false;
      
      public var curseLimit:int = 0;
      
      public var zombieLimit:int = 0;
      
      private var showProperties:Boolean = false;
      
      public var description:String = "";
      
      public var shopbar:ShopBar;
      
      public var smileyAuraMenu:SmileyAuraMenu;
      
      public var smileyAuraButton:SmileyAuraButton;
      
      private var favLikeSelector:FavLikeSelector;
      
      private var favLikeButton:FavLikeButton;
      
      private var effectDisplay:EffectDisplay;
      
      private var specialproperties:PropertiesBackground;
      
      public var hasPropertyOpen:Boolean = false;
      
      private var reqS:Boolean = false;
      
      private var latestPM:String = "";
      
      public var commandHelp:Object;
      
      private var crewPrompt:CrewPrompt;
      
      private var addToCrewButton:SettingsButton;
      
      private var playerActions:PlayerActionsMenu;
      
      private var usedXLeft:int = 0;
      
      private var usedXRight:int = 0;
      
      private var timerArray:Array;
      
      private var textArray:Array;
      
      private var lastMessageTime:Number;
      
      public function UI2(param1:EverybodyEdits, param2:Connection, param3:Message, param4:int, param5:Boolean, param6:String, param7:SideChat, param8:Boolean, param9:Boolean, param10:Boolean, param11:String, param12:int, param13:int, param14:Boolean, param15:Boolean)
      {
         var moveInputCursorToEnd:Function = null;
         var that:UI2 = null;
         var base:EverybodyEdits = param1;
         var connection:Connection = param2;
         var m:Message = param3;
         var myid:int = param4;
         var canEdit:Boolean = param5;
         var roomid:String = param6;
         var sidechat:SideChat = param7;
         var roomOpen:Boolean = param8;
         var roomHideLobby:Boolean = param9;
         var allowSpect:Boolean = param10;
         var description:String = param11;
         var curseLim:int = param12;
         var zombieLim:int = param13;
         var mapEnabled:Boolean = param14;
         var lobbyPreviewEnabled:Boolean = param15;
         this.lobby = new ui2lobbybtn();
         this.godmode = new ui2godmodebtn();
         this.toggleminimap = new ui2toggleminimapbtn();
         this.share = new ui2sharebtn();
         this.enterkey = new ui2entereditkeybox();
         this.campaignInfo = new CampaignInfo();
         this.chatbtn = new ui2chatbtn();
         this.chatinput = new ui2chatinput();
         this.above = new Sprite();
         this.shopbar = new ShopBar();
         this.favLikeButton = new FavLikeButton();
         this.commandHelp = {
            "/bgcolor":true,
            "/clear":true,
            "/clearchat":true,
            "/cleareffects":true,
            "/forcefly":true,
            "/gedit":true,
            "/geffect":true,
            "/getpos":true,
            "/givecrown":true,
            "/giveedit":true,
            "/giveeffect":true,
            "/givegod":true,
            "/help":true,
            "/hidelobby":true,
            "/inspect":true,
            "/kick":true,
            "/kill":true,
            "/killall":true,
            "/listportals":true,
            "/loadlevel":true,
            "/mute":true,
            "/name":true,
            "/pm":true,
            "/redit":true,
            "/reffect":true,
            "/removecrown":true,
            "/removeedit":true,
            "/removeeffect":true,
            "/removegod":true,
            "/report":true,
            "/reset":true,
            "/resetall":true,
            "/resetswitches":true,
            "/respawnall":true,
            "/roomid":true,
            "/save":true,
            "/setteam":true,
            "/spectate":true,
            "/teleport":true,
            "/unmute":true,
            "/visible":true
         };
         this.timerArray = [5000,5000,5000,5000,5000];
         this.textArray = ["","","","","","","","","",""];
         this.lastMessageTime = new Date().time;
         super();
         moveInputCursorToEnd = function(param1:Event):void
         {
            var _loc2_:int = chatinput.text.field.length;
            chatinput.text.field.setSelection(_loc2_,_loc2_);
            stage.removeEventListener(Event.RENDER,moveInputCursorToEnd);
         };
         Global.chatIsVisible = false;
         Bl.data.moreisvisible = false;
         this.roomVisible = roomOpen;
         this.roomHiddenFromLobby = roomHideLobby;
         this.allowSpectating = allowSpect;
         this.minimapEnabled = mapEnabled;
         this.lobbyPreviewEnabled = lobbyPreviewEnabled;
         this.description = description;
         this.curseLimit = curseLim;
         this.zombieLimit = zombieLim;
         var blocks:Vector.<ItemBrick> = new Vector.<ItemBrick>();
         blocks.push(ItemManager.bricks[0]);
         this.brickPackagePopup = new BrickPackage("empty",blocks,this,ItemTab.BLOCK,[],false,0,true);
         this.brickPackagePopup.x = 20;
         this.brickPackagePopup.y = -200;
         this.bselector = new BrickSelector(this);
         Bl.data.canEdit = canEdit;
         Bl.data.canToggleGodMode = canEdit;
         Bl.data.bselector = this.bselector;
         Bl.data.showingproperties = false;
         Bl.data.world_portal_id = roomid;
         Bl.data.world_portal_name = Bl.data.roomname;
         this.roomid = roomid;
         this.smiliesbmd = ItemManager.smiliesBMD;
         this.base = base;
         this.connection = connection;
         Global.base.favorited = false;
         Global.base.liked = false;
         addChild(this.bselector);
         var ui2BG:SettingsButton = new SettingsButton("",null,null);
         ui2BG.setSize(641,29);
         ui2BG.y = -ui2BG.HEIGHT;
         addChild(ui2BG);
         addChild(this.brickPackagePopup);
         this.settingsMenu = new SettingsMenu("Options",this);
         if(!Bl.data.owner && !Global.player_is_guest)
         {
            this.favLikeButton.buttonMode = true;
            this.favLikeButton.useHandCursor = true;
         }
         this.smileyAuraMenu = new SmileyAuraMenu(this);
         this.smileyAuraMenu.visible = false;
         this.above.addChild(this.smileyAuraMenu);
         this.smileyAuraButton = new SmileyAuraButton();
         this.smileyAuraButton.buttonMode = true;
         this.smileyAuraButton.useHandCursor = true;
         this.favLikeSelector = new FavLikeSelector(0,0);
         this.favLikeSelector.visible = false;
         this.above.addChild(this.favLikeSelector);
         this.effectDisplay = new EffectDisplay(this.curseLimit,this.zombieLimit);
         this.effectDisplay.x = 2;
         this.effectDisplay.y = -498;
         addChild(this.effectDisplay);
         this.shopbar.shopbtn.visible = false;
         var def:Vector.<ItemBrick> = new Vector.<ItemBrick>();
         if(Bl.data.isOpenWorld)
         {
            def.push(ItemManager.getBrickById(0),ItemManager.getBrickById(9),ItemManager.getBrickById(10),ItemManager.getBrickById(11),ItemManager.getBrickById(12),ItemManager.getBrickById(13),ItemManager.getBrickById(14),ItemManager.getBrickById(15),ItemManager.getBrickById(31),ItemManager.getBrickById(2),ItemManager.getBrickById(5));
         }
         else
         {
            def.push(ItemManager.getBrickById(0),ItemManager.getBrickById(9),ItemManager.getBrickById(10),ItemManager.getBrickById(11),ItemManager.getBrickById(16),ItemManager.getBrickById(17),ItemManager.getBrickById(18),ItemManager.getBrickById(29),ItemManager.getBrickById(32),ItemManager.getBrickById(2),ItemManager.getBrickById(100));
         }
         this.favoriteBricks = new BrickContainer(def,this);
         this.configureInterface();
         this.toggleMinimap(this.minimapEnabled && Bl.data.showMap);
         this.bselector.x = 640 - this.bselector.width >> 1;
         this.bselector.visible = false;
         addChild(this.chatinput);
         this.chatinput.y = -59;
         this.chatinput.x = 65;
         this.chatinput.visible = false;
         this.chatinput.text = new TabTextField();
         this.chatinput.addChild(this.chatinput.text);
         this.chatinput.text.x = 37;
         this.chatinput.text.y = 6;
         this.chatinput.text.width = 445;
         this.chatinput.quicksay0.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",0);
            hideAll();
         });
         this.chatinput.quicksay1.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",1);
            hideAll();
         });
         this.chatinput.quicksay2.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",2);
            hideAll();
         });
         this.chatinput.quicksay3.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",3);
            hideAll();
         });
         this.chatinput.quicksay4.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",4);
            hideAll();
         });
         this.chatinput.quicksay5.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",5);
            hideAll();
         });
         this.chatinput.quicksay6.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",6);
            hideAll();
         });
         this.chatinput.quicksay7.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",7);
            hideAll();
         });
         this.chatinput.quicksay8.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",8);
            hideAll();
         });
         this.chatinput.quicksay9.addEventListener(MouseEvent.CLICK,function():void
         {
            connection.send("autosay",9);
            hideAll();
         });
         if(sidechat != null)
         {
            this.chatinput.text.SetWordFunction(sidechat.getUsers);
            this.chatinput.text.AddCheckWords(this.commandHelp);
         }
         this.chatinput.text.field.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            if(param1.keyCode == Keyboard.ESCAPE)
            {
               hideAll();
            }
            else if(param1.keyCode == Keyboard.ENTER)
            {
               sendChat();
            }
            else if(param1.keyCode == Keyboard.UP)
            {
               previousChatInput();
               stage.addEventListener(Event.RENDER,moveInputCursorToEnd,false,0,true);
               stage.invalidate();
            }
            else if(param1.keyCode == Keyboard.DOWN)
            {
               chatinput.text.field.text = "";
            }
         });
         this.chatinput.text.field.addEventListener(KeyboardEvent.KEY_UP,function(param1:KeyboardEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         this.chatinput.say.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            sendChat();
         });
         this.chatinput.text.field.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         this.setSmiliesData();
         this.smileyAuraMenu.redraw();
         this.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            if(stage && !(param1.target is TextField))
            {
               stage.focus = Global.base;
            }
         });
         this.lobby.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            base.ShowLobby();
         });
         this.godmode.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            connection.send("god",godmode.currentFrame == 1);
         });
         connection.addMessageHandler("toggleGod",function(param1:Message, param2:int, param3:Boolean):void
         {
            if(param2 == myid)
            {
               Bl.data.canToggleGodMode = param3;
               smileyAuraMenu.redraw();
               configureInterface();
            }
         });
         connection.addMessageHandler("god",function(param1:Message, param2:int, param3:Boolean):void
         {
            if(param2 == myid)
            {
               smileyAuraMenu.redraw();
               toggleGodMode(param3);
               if(!Bl.data.canToggleGodMode)
               {
                  configureInterface(param3);
               }
            }
         });
         connection.addMessageHandler("worldReleased",function(param1:Message):void
         {
            Bl.data.canChangeWorldOptions = false || Bl.data.owner;
            configureInterface();
         });
         connection.addMessageHandler("effect",function(param1:Message, param2:int, param3:int, param4:Boolean, param5:int = 0, param6:int = 0):void
         {
            var _loc7_:ItemBrick = null;
            var _loc8_:BitmapData = null;
            if(param2 == myid)
            {
               _loc7_ = ItemManager.getEffectBrickById(param3);
               _loc8_ = _loc7_.bmd;
               if(param3 == Config.effectMultijump)
               {
                  _loc8_ = new BitmapData(16,16);
                  _loc8_.copyPixels(ItemManager.sprEffect.bmd,new Rectangle((15 + param5) * 16,0,16,16),new Point(0,0));
               }
               effectDisplay.removeEffect(_loc7_.id);
               if(param4)
               {
                  effectDisplay.addEffect(_loc8_,_loc7_.id,param5,param6);
               }
            }
            effectDisplay.update();
         });
         connection.addMessageHandler("add",function(param1:Message, param2:int):void
         {
            effectDisplay.update();
         });
         connection.addMessageHandler("left",function(param1:Message, param2:int):void
         {
            if(param2 != myid)
            {
               effectDisplay.update();
            }
         });
         that = this;
         connection.addMessageHandler("givemagicsmiley",function(param1:Message, param2:String):void
         {
            var m:Message = param1;
            var payvaultid:String = param2;
            Global.client.payVault.refresh(function():void
            {
               var _loc1_:ItemSmiley = ItemManager.getSmileyByPayvaultId(payvaultid);
               smileyAuraMenu.addSmiley(new SmileyInstance(_loc1_,that,Global.playerInstance.wearsGoldSmiley));
               smileyAuraMenu.redraw();
               setSelectedSmiley(_loc1_.id);
            });
         });
         connection.addMessageHandler("givemagicbrickpackage",function(param1:Message, param2:String):void
         {
            var m:Message = param1;
            var packagename:String = param2;
            Global.client.payVault.refresh(function():void
            {
               updateSelectorBricks();
            });
         });
         connection.addMessageHandler("favorited",function(param1:Message):void
         {
            Bl.data.inFavorites = true;
            Global.base.favorited = true;
            setFavLikeStates();
            sidechat.addFavorite();
         });
         connection.addMessageHandler("liked",function(param1:Message):void
         {
            Bl.data.liked = true;
            Global.base.liked = true;
            setFavLikeStates();
            sidechat.addLike();
         });
         connection.addMessageHandler("unfavorited",function(param1:Message):void
         {
            Bl.data.inFavorites = false;
            setFavLikeStates();
            sidechat.addFavorite(-1);
         });
         connection.addMessageHandler("unliked",function(param1:Message):void
         {
            Bl.data.liked = false;
            setFavLikeStates();
            sidechat.addLike(-1);
         });
         this.chatbtn.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            toggleChat(chatbtn.currentFrame == 1);
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         });
         this.toggleminimap.buttonMode = true;
         this.toggleminimap.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            toggleMinimap(toggleminimap.currentFrame == 1);
            if(stage)
            {
               stage.focus = Global.base;
            }
         });
         connection.addMessageHandler("saved",function():void
         {
            setTimeout(function():void
            {
               settingsMenu.toggleVisible(false);
               Global.base.hideLoadingScreen();
            },500);
         });
         this.smileyAuraButton.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            toggleSmileyAuraMenu(!smileyAuraMenu.visible);
         });
         if(!Bl.data.owner && !Global.player_is_guest)
         {
            this.favLikeButton.addEventListener(MouseEvent.MOUSE_DOWN,function():void
            {
               favLikeSelector.x = favLikeButton.x - favLikeSelector.basiswidth / 2 + favLikeButton.width / 2 >> 0;
               if(favLikeSelector.parent.localToGlobal(new Point(favLikeSelector.x,0)).x + favLikeSelector.width >= 640)
               {
                  favLikeSelector.x = 640 - favLikeSelector.width;
               }
               toggleFavLike(!favLikeSelector.visible);
            });
         }
         this.share.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            var shr:Share = null;
            if(Global.playing_on_faceboook)
            {
               FB.ui({
                  "method":"stream.publish",
                  "message":"I found a great Everybody Edits level!",
                  "attachment":{
                     "name":"Play " + (!!Bl.data.roomname?Bl.data.roomname + " in ":"") + "Everybody Edits",
                     "href":"http://apps.facebook.com/everedits/games/" + roomid,
                     "caption":"{*actor*} is having a blast playing " + (!!Bl.data.roomname?Bl.data.roomname + " in ":"") + "Everybody Edits",
                     "description":"Why not try the level now?",
                     "media":[{
                        "type":"image",
                        "src":"http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/Everybody Edits/img/ee100x100.png",
                        "href":"http://apps.facebook.com/everedits/games/" + roomid
                     }]
                  }
               },function(param1:*):void
               {
               });
            }
            else
            {
               shr = new Share("Direct URL to this level!","http://everybodyedits.com/games/" + roomid.split(" ").join("-"));
               Bl.overlayContainer.addChild(shr);
               TweenMax.to(shr,0,{"alpha":0});
               TweenMax.to(shr,0.2,{"alpha":1});
               shr.closebtn.addEventListener(MouseEvent.CLICK,function():void
               {
                  TweenMax.to(shr,0.2,{
                     "alpha":0,
                     "onComplete":function():void
                     {
                        if(stage)
                        {
                           stage.focus = Global.base;
                        }
                        Bl.overlayContainer.removeChild(shr);
                     }
                  });
               });
            }
         });
         this.favoriteBricks.more.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            toggleMore(favoriteBricks.more.currentFrame == 1);
         });
         this.enterkey.key.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
         {
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            param1.preventDefault();
         });
         this.enterkey.key.addEventListener(KeyboardEvent.KEY_DOWN,function(param1:KeyboardEvent):void
         {
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            param1.preventDefault();
         });
         this.enterkey.send.addEventListener(MouseEvent.MOUSE_DOWN,function():void
         {
            connection.send("access",enterkey.key.text);
         });
         connection.addMessageHandler("access",function(param1:Message):void
         {
            Bl.data.canEdit = true;
            Bl.data.canToggleGodMode = !!Bl.data.isOpenWorld?false:true;
            smileyAuraMenu.redraw();
            configureInterface();
         });
         connection.addMessageHandler("lostaccess",function(param1:Message):void
         {
            if(!Bl.data.owner)
            {
               toggleMore(false);
               toggleGodMode(false);
               Bl.data.canEdit = false;
               Bl.data.canToggleGodMode = false;
               smileyAuraMenu.redraw();
               configureInterface();
            }
         });
         connection.addMessageHandler("roomVisible",function(param1:Message):void
         {
            roomVisible = param1.getBoolean(0);
         });
         connection.addMessageHandler("hideLobby",function(param1:Message):void
         {
            roomHiddenFromLobby = param1.getBoolean(0);
         });
         connection.addMessageHandler("allowSpectating",function(param1:Message):void
         {
            var _loc2_:PlayState = null;
            allowSpectating = param1.getBoolean(0);
            if(!allowSpectating)
            {
               _loc2_ = base.state as PlayState;
               _loc2_.stopSpectating();
            }
         });
         connection.addMessageHandler("minimapEnabled",function(param1:Message, param2:Boolean):void
         {
            minimapEnabled = param2;
            configureInterface();
            if(!minimapEnabled)
            {
               toggleMinimap(false);
            }
         });
         connection.addMessageHandler("lobbyPreviewEnabled",function(param1:Message, param2:Boolean):void
         {
            lobbyPreviewEnabled = param2;
         });
         connection.addMessageHandler("roomDescription",function(param1:Message):void
         {
            description = param1.getString(0);
         });
         connection.addMessageHandler("effectLimits",function(param1:Message, param2:int, param3:int):void
         {
            curseLimit = param2;
            zombieLimit = param3;
            effectDisplay.setLimits(curseLimit,zombieLimit);
         });
         connection.addMessageHandler("write",function(param1:Message, param2:String, param3:String):void
         {
            var _loc4_:String = "* ";
            var _loc5_:String = " > you";
            var _loc6_:String = "* you > ";
            if(param2.indexOf(_loc4_) == 0 && param2.substring(param2.length - _loc5_.length) == _loc5_)
            {
               latestPM = param2.substring(_loc4_.length,param2.length - _loc5_.length);
            }
            else if(param2.indexOf(_loc6_) == 0)
            {
               latestPM = param2.substring(_loc6_.length);
            }
         });
         connection.addMessageHandler("joinCampaign",function(param1:Message, param2:String, param3:int):void
         {
            if(Global.player_is_guest)
            {
               campaignInfo.displayGuestInfo(param2);
            }
            else if(param3 == -1)
            {
               campaignInfo.displayLockedInfo(param2);
            }
            else if(param3 == 2)
            {
               campaignInfo.displayBetaOnlyInfo(param2);
            }
            else
            {
               campaignInfo.displayInfo(param2,param1.getInt(2),param1.getInt(3),param1.getInt(4),param3 == 1);
            }
         });
         connection.addMessageHandler("lockCampaign",function(param1:Message, param2:String):void
         {
            campaignInfo.displayLockedInfo(param2);
         });
         connection.addMessageHandler("campaignRewards",function(param1:Message):void
         {
            var badgeTitle:String = null;
            var badgeDescription:String = null;
            var badgeImageUrl:String = null;
            var worldImageUrl:String = null;
            var rewardType:String = null;
            var reward:CampaignReward = null;
            var m:Message = param1;
            campaignInfo.updateStatus(true);
            var i:int = 0;
            var showBadge:Boolean = m.getBoolean(i++);
            if(showBadge)
            {
               badgeTitle = m.getString(i++);
               badgeDescription = m.getString(i++);
               badgeImageUrl = m.getString(i++);
            }
            else
            {
               worldImageUrl = m.getString(i++);
            }
            var rewards:Array = [];
            while(i < m.length)
            {
               rewardType = m.getString(i++);
               reward = new CampaignReward(rewardType,m.getUInt(i++));
               rewards.push(reward);
               if(rewardType.substring(0,6) == "smiley")
               {
                  Global.client.payVault.refresh(function():void
                  {
                     var _loc1_:ItemSmiley = ItemManager.getSmileyByPayvaultId(rewardType);
                     smileyAuraMenu.addSmiley(new SmileyInstance(_loc1_,that,Global.playerInstance.wearsGoldSmiley));
                     smileyAuraMenu.redraw();
                     setSelectedSmiley(_loc1_.id);
                  });
               }
            }
            Global.base.showCampaignComplete(new CampaignComplete(campaignInfo.campaignName,campaignInfo.tier,campaignInfo.maxTier,rewards,!!showBadge?badgeImageUrl:worldImageUrl));
         });
         connection.addMessageHandler("completedLevel",function(param1:Message):void
         {
            Global.base.showLevelComplete(new LevelComplete());
         });
         connection.addMessageHandler("canAddToCrews",function(param1:Message):void
         {
            var m:Message = param1;
            var crews:Array = [];
            var crewNames:Array = [];
            var i:int = 0;
            while(i < m.length)
            {
               crews.push(m.getString(i));
               crewNames.push(m.getString(i + 1));
               i = i + 2;
            }
            crewPrompt = new CrewPrompt(connection,crews,crewNames);
            addToCrewButton = new SettingsButton("Add\nTo Crew",null,function(param1:MouseEvent):void
            {
               settingsMenu.toggleVisible(false);
               if(crewPrompt != null)
               {
                  Global.base.overlayContainer.addChild(crewPrompt);
                  TweenMax.to(crewPrompt,0,{"alpha":0});
                  TweenMax.to(crewPrompt,0.2,{"alpha":1});
               }
            });
            settingsMenu.addButton(addToCrewButton);
            configureInterface();
         });
         connection.addMessageHandler("addedToCrew",function(param1:Message):void
         {
            if(crewPrompt != null)
            {
               crewPrompt.close();
               crewPrompt = null;
            }
            settingsMenu.removeButton(addToCrewButton);
            configureInterface();
            Global.currentLevelCrew = param1.getString(0);
            Global.currentLevelCrewName = param1.getString(1);
            sidechat.updateBy();
         });
         connection.addMessageHandler("crewAddRequest",function(param1:Message):void
         {
            var confirm:ConfirmPrompt = null;
            var reject:Function = null;
            var m:Message = param1;
            reject = function(param1:MouseEvent):void
            {
               connection.send("rejectAddToCrew");
               confirm.close();
            };
            confirm = new ConfirmPrompt(m.getString(0) + " wants to add this world to " + m.getString(1) + ". Do you agree? WARNING: This cannot be undone!");
            Global.base.showConfirmPrompt(confirm);
            confirm.ben_yes.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
            {
               var confirm2:ConfirmPrompt = null;
               var ev:MouseEvent = param1;
               confirm2 = new ConfirmPrompt("Are you sure?");
               Global.base.showConfirmPrompt(confirm2);
               confirm2.ben_yes.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
               {
                  connection.send("addToCrew");
                  confirm2.close();
                  confirm.close();
               });
               confirm2.btn_no.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):void
               {
                  reject(param1);
                  confirm2.close();
               });
            });
            confirm.btn_no.addEventListener(MouseEvent.MOUSE_DOWN,reject);
            confirm.closebtn.addEventListener(MouseEvent.MOUSE_DOWN,reject);
         });
         this.setSelectedSmiley(!!Global.playerObject?int(Global.playerObject.smiley) || 0:0);
         this.setSelectedAura(!!Global.playerObject?int(Global.playerObject.aura) || 0:0);
         this.setFavLikeStates();
         this.toggleSmileyAuraMenu(false);
         this.settingsMenu.toggleVisible(false);
         this.updateSelectorBricks();
         this.setSelected(0);
         addEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
         addEventListener(Event.REMOVED_FROM_STAGE,this.handleDetatch);
         Global.stage.addEventListener(SimplePlayerObjectEvent.UPDATE,this.handlePlayerObjectUpdate,false,0,true);
      }
      
      public function get playerActionsVisible() : Boolean
      {
         return this.playerActions != null && !this.playerActions.closed;
      }
      
      public function showPlayerActions(param1:String, param2:String) : void
      {
         if(this.playerActionsVisible)
         {
            this.playerActions.close();
            if(this.playerActions.targetPlayer.name == param1)
            {
               return;
            }
         }
         this.playerActions = new PlayerActionsMenu(param1,param2,this.connection);
         this.playerActions.x = 491;
         this.playerActions.y = -450;
         addChild(this.playerActions);
      }
      
      public function hidePlayerActions(param1:String = "") : void
      {
         if(this.playerActionsVisible)
         {
            if(param1 != "" && this.playerActions.targetPlayer.name != param1)
            {
               return;
            }
            this.playerActions.close();
            this.playerActions = null;
         }
      }
      
      private function handlePlayerObjectUpdate(param1:Event = null) : void
      {
         this.smileyAuraMenu.doEmpty();
         this.smileyAuraMenu.redraw();
      }
      
      private function setSmiliesData() : void
      {
         var _loc6_:ItemSmiley = null;
         var _loc7_:ItemAuraShape = null;
         var _loc8_:ItemAuraColor = null;
         var _loc1_:Vector.<ItemSmiley> = ItemManager.smilies;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc6_ = _loc1_[_loc2_];
            if(_loc6_.payvaultid == "" || this.base.client.payVault.has(_loc6_.payvaultid) || _loc6_.payvaultid == "pro" && Global.player_is_beta_member || Global.playerObject.goldmember && _loc6_.payvaultid == "goldmember")
            {
               this.smileyAuraMenu.addSmiley(new SmileyInstance(_loc6_,this,Global.playerInstance.wearsGoldSmiley));
            }
            _loc2_++;
         }
         var _loc3_:Vector.<ItemAuraShape> = ItemManager.auraShapes;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc7_ = _loc3_[_loc4_];
            if(_loc7_.payvaultid == "" || this.base.client.payVault.has(_loc7_.payvaultid) || _loc7_.payvaultid == "goldmember" && Global.playerObject.goldmember)
            {
               this.smileyAuraMenu.addAura(_loc7_);
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < ItemManager.auraColors.length)
         {
            _loc8_ = ItemManager.auraColors[_loc5_];
            if(_loc8_.payVaultId == "" || this.base.client.payVault.has(_loc8_.payVaultId) || _loc8_.payVaultId == "goldmember" && Global.playerObject.goldmember)
            {
               this.smileyAuraMenu.addColor(_loc8_);
            }
            _loc5_++;
         }
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
      }
      
      public function updateSelectorBricks() : void
      {
         var _loc1_:Vector.<ItemBrickPackage> = null;
         var _loc3_:ItemBrickPackage = null;
         var _loc4_:Vector.<ItemBrick> = null;
         var _loc5_:Vector.<ItemBrick> = null;
         var _loc6_:Vector.<ItemBrick> = null;
         var _loc7_:Vector.<ItemBrick> = null;
         var _loc8_:int = 0;
         var _loc9_:BrickPackage = null;
         var _loc10_:ItemBrick = null;
         this.bselector.removeAllPackages();
         if(Bl.data.isOpenWorld)
         {
            _loc1_ = ItemManager.getOpenWorldBrickPackages();
         }
         else
         {
            _loc1_ = ItemManager.brickPackages;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = new Vector.<ItemBrick>();
            _loc5_ = new Vector.<ItemBrick>();
            _loc6_ = new Vector.<ItemBrick>();
            _loc7_ = new Vector.<ItemBrick>();
            _loc8_ = 0;
            while(_loc8_ < _loc3_.bricks.length)
            {
               _loc10_ = _loc3_.bricks[_loc8_];
               if(_loc10_.payvaultid == "" || this.base.client.payVault.has(_loc10_.payvaultid) || _loc10_.payvaultid == "pro" && Global.player_is_beta_member || _loc10_.payvaultid == "goldmember" && Global.playerObject.goldmember)
               {
                  if(!((_loc10_.id == 77 || _loc10_.id == 83) && !Global.hasOwner))
                  {
                     if(!_loc10_.requiresAdmin || Bl.data.isAdmin || Bl.data.isModerator)
                     {
                        if(!_loc10_.requiresOwnership || (Bl.data.owner || Bl.data.isAdmin))
                        {
                           switch(_loc10_.tab)
                           {
                              case ItemTab.BLOCK:
                                 _loc4_.push(_loc10_);
                                 break;
                              case ItemTab.ACTION:
                                 _loc5_.push(_loc10_);
                                 break;
                              case ItemTab.DECORATIVE:
                                 _loc6_.push(_loc10_);
                                 break;
                              case ItemTab.BACKGROUND:
                                 _loc7_.push(_loc10_);
                           }
                        }
                     }
                  }
               }
               _loc8_++;
            }
            if(_loc4_.length > 0)
            {
               _loc9_ = new BrickPackage(_loc3_.name,_loc4_,this,ItemTab.BLOCK,_loc3_.tags,Global.blockPackageTitlesVisible,!!Global.blockSelectorCollapsedMode?1:0);
               this.bselector.addPackage(_loc9_);
            }
            if(_loc5_.length > 0)
            {
               _loc9_ = new BrickPackage(_loc3_.name,_loc5_,this,ItemTab.ACTION,_loc3_.tags,Global.blockPackageTitlesVisible,!!Global.blockSelectorCollapsedMode?1:0);
               this.bselector.addPackage(_loc9_);
            }
            if(_loc6_.length > 0)
            {
               _loc9_ = new BrickPackage(_loc3_.name,_loc6_,this,ItemTab.DECORATIVE,_loc3_.tags,Global.blockPackageTitlesVisible,!!Global.blockSelectorCollapsedMode?1:0);
               this.bselector.addPackage(_loc9_);
            }
            if(_loc7_.length > 0)
            {
               _loc9_ = new BrickPackage(_loc3_.name,_loc7_,this,ItemTab.BACKGROUND,_loc3_.tags,Global.blockPackageTitlesVisible,!!Global.blockSelectorCollapsedMode?1:0);
               this.bselector.addPackage(_loc9_);
            }
            _loc2_++;
         }
         this.bselector.search.textfield.text = "";
         this.bselector.redraw();
      }
      
      public function toggleSmileyAuraMenu(param1:Boolean) : void
      {
         if(param1)
         {
            this.hideAll();
         }
         this.smileyAuraMenu.visible = param1;
         this.smileyAuraButton.setActive(param1);
      }
      
      public function toggleFavLike(param1:Boolean) : void
      {
         if(param1)
         {
            this.hideAll();
         }
         this.favLikeSelector.visible = param1;
      }
      
      public function dragIt(param1:ItemBrick) : void
      {
         this.favoriteBricks.dragIt(param1);
      }
      
      public function setDefault(param1:int, param2:ItemBrick) : void
      {
         this.favoriteBricks.setDefault(param1,param2);
      }
      
      public function toggleGodMode(param1:Boolean) : void
      {
         this.godmode.gotoAndStop(!!param1?2:1);
      }
      
      public function toggleMinimap(param1:Boolean) : void
      {
         this.toggleminimap.gotoAndStop(!!param1?2:1);
         Bl.data.showMap = param1;
      }
      
      public function setSelected(param1:int) : void
      {
         this.hideAllProperties();
         if(!this.bselector.visible)
         {
            if(param1 != Bl.data.brick)
            {
               this.showProperties = false;
            }
            else
            {
               this.showProperties = !this.showProperties;
            }
         }
         else
         {
            this.showProperties = true;
         }
         if(this.showProperties)
         {
            switch(param1)
            {
               case ItemId.COINDOOR:
               case ItemId.COINGATE:
               case ItemId.BLUECOINDOOR:
               case ItemId.BLUECOINGATE:
               case 77:
               case 83:
               case 242:
               case ItemId.WORLD_PORTAL:
               case ItemId.PORTAL_INVISIBLE:
               case ItemId.TEXT_SIGN:
               case ItemId.SWITCH_PURPLE:
               case ItemId.DOOR_PURPLE:
               case ItemId.GATE_PURPLE:
               case ItemId.DEATH_DOOR:
               case ItemId.DEATH_GATE:
               case ItemId.EFFECT_TEAM:
               case ItemId.TEAM_DOOR:
               case ItemId.TEAM_GATE:
               case ItemId.EFFECT_CURSE:
               case ItemId.EFFECT_FLY:
               case ItemId.EFFECT_JUMP:
               case ItemId.EFFECT_PROTECTION:
               case ItemId.EFFECT_RUN:
               case ItemId.EFFECT_ZOMBIE:
               case ItemId.EFFECT_LOW_GRAVITY:
               case ItemId.EFFECT_MULTIJUMP:
               case ItemId.SWITCH_ORANGE:
               case ItemId.DOOR_ORANGE:
               case ItemId.GATE_ORANGE:
               case 1000:
                  this.showSpecialProperties(param1,!this.bselector.visible || !this.bselector.currentPageHasBlock(param1));
            }
         }
         if(param1 == -1)
         {
            param1 = 243;
         }
         Bl.data.brick = param1;
         this.favoriteBricks.setSelected(param1);
         this.bselector.setSelected(param1);
      }
      
      public function hideBrickPackagePopup() : void
      {
         this.brickPackagePopup.visible = false;
         this.hideAllProperties();
      }
      
      public function toggleBrickPackagePopup(param1:String, param2:Vector.<ItemBrick>, param3:Boolean) : void
      {
         this.hideAllProperties();
         var _loc4_:int = param2[0].id;
         if(this.brickPackagePopup.visible && this.brickPackagePopup.content[0].id == _loc4_ && param3)
         {
            this.brickPackagePopup.visible = false;
            return;
         }
         var _loc5_:Point = this.bselector.getPosition(_loc4_);
         this.brickPackagePopup.visible = _loc5_ != null;
         if(_loc5_ == null)
         {
            return;
         }
         this.brickPackagePopup.updateContent(param1,param2,true);
         this.brickPackagePopup.x = _loc5_.x + this.bselector.x - this.brickPackagePopup.content.length * 16 / 2 - 2;
         this.brickPackagePopup.y = _loc5_.y + this.bselector.y - 33;
         if(this.brickPackagePopup.x < 0)
         {
            this.brickPackagePopup.x = 5;
         }
         else if(this.brickPackagePopup.x + this.brickPackagePopup.content.length * 16 > 635)
         {
            this.brickPackagePopup.x = 635 - this.brickPackagePopup.width;
         }
      }
      
      public function showSpecialProperties(param1:int, param2:Boolean = false) : void
      {
         this.hideAllProperties();
         var _loc3_:Point = this.brickPackagePopup.getPosition(param1);
         if(_loc3_ == null)
         {
            if(!param2)
            {
               _loc3_ = this.bselector.getPosition(param1);
            }
            else
            {
               _loc3_ = this.favoriteBricks.getPosWithID(param1);
            }
         }
         else
         {
            _loc3_.x = _loc3_.x - this.bselector.x;
            _loc3_.y = _loc3_.y - this.bselector.y;
         }
         Bl.data.showingproperties = true;
         this.specialproperties = null;
         switch(param1)
         {
            case ItemId.COINDOOR:
            case ItemId.COINGATE:
            case ItemId.BLUECOINDOOR:
            case ItemId.BLUECOINGATE:
               this.specialproperties = new CoinProperties(param1);
               break;
            case 1000:
               this.specialproperties = new LabelProperties();
               break;
            case 242:
            case ItemId.PORTAL_INVISIBLE:
               this.specialproperties = new PortalProperties(param1);
               break;
            case ItemId.WORLD_PORTAL:
               this.specialproperties = new WorldPortalProperties();
               break;
            case 83:
               this.specialproperties = new DrumProperties();
               break;
            case 77:
               this.specialproperties = new PianoProperties();
               break;
            case ItemId.TEXT_SIGN:
               this.specialproperties = new TextSignProperties();
               break;
            case ItemId.SWITCH_PURPLE:
            case ItemId.DOOR_PURPLE:
            case ItemId.GATE_PURPLE:
            case ItemId.SWITCH_ORANGE:
            case ItemId.DOOR_ORANGE:
            case ItemId.GATE_ORANGE:
               this.specialproperties = new SwitchProperties(param1);
               break;
            case ItemId.DEATH_DOOR:
            case ItemId.DEATH_GATE:
               this.specialproperties = new DeathProperties(param1);
               break;
            case ItemId.EFFECT_TEAM:
            case ItemId.TEAM_DOOR:
            case ItemId.TEAM_GATE:
               this.specialproperties = new TeamProperties();
               break;
            case ItemId.EFFECT_CURSE:
            case ItemId.EFFECT_ZOMBIE:
               this.specialproperties = new TimeProperties();
               break;
            case ItemId.EFFECT_FLY:
            case ItemId.EFFECT_JUMP:
            case ItemId.EFFECT_PROTECTION:
            case ItemId.EFFECT_RUN:
            case ItemId.EFFECT_LOW_GRAVITY:
               this.specialproperties = new OnOffProperties();
               break;
            case ItemId.EFFECT_MULTIJUMP:
               this.specialproperties = new MultijumpProperties();
         }
         if(_loc3_ == null || this.specialproperties == null)
         {
            return;
         }
         this.above.addChild(this.specialproperties);
         var _loc4_:int = !!param2?int(this.favoriteBricks.x):int(this.bselector.x);
         var _loc5_:int = !!param2?int(this.favoriteBricks.y):int(this.bselector.y);
         this.specialproperties.x = _loc3_.x + _loc4_;
         this.specialproperties.y = _loc3_.y + _loc5_;
         if(this.specialproperties.x - this.specialproperties.width / 2 < 0)
         {
            this.specialproperties.setOffsetX(-(this.specialproperties.x - this.specialproperties.width / 2));
         }
         else if(this.specialproperties.x + this.specialproperties.width / 2 > 640)
         {
            this.specialproperties.setOffsetX(640 - (this.specialproperties.x + this.specialproperties.width / 2));
         }
      }
      
      public function hideAllProperties() : void
      {
         Bl.data.showingproperties = false;
         if(this.specialproperties != null && this.above.contains(this.specialproperties))
         {
            this.above.removeChild(this.specialproperties);
         }
      }
      
      public function setFavLikeStates() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         if(this.favLikeButton)
         {
            _loc1_ = 0;
            _loc2_ = Bl.data.inFavorites;
            _loc3_ = Bl.data.liked;
            if(!_loc2_ && !_loc3_)
            {
               _loc1_ = 0;
            }
            if(!_loc2_ && _loc3_)
            {
               _loc1_ = 1;
            }
            if(_loc2_ && !_loc3_)
            {
               _loc1_ = 2;
            }
            if(_loc2_ && _loc3_)
            {
               _loc1_ = 3;
            }
            this.favLikeButton.setState(_loc1_);
            if(this.favLikeSelector)
            {
               this.favLikeSelector.setFavoriteState(!!_loc2_?0:1);
               this.favLikeSelector.setLikeState(!!_loc3_?0:1);
               if(!_loc2_ && Global.base.favorited)
               {
                  this.favLikeSelector.disableFavoriteButton();
               }
               if(!_loc3_ && Global.base.liked)
               {
                  this.favLikeSelector.disableLikeButton();
               }
            }
         }
      }
      
      public function setSelectedAura(param1:int = 0) : void
      {
         this.connection.send("aura",param1,Global.playerObject.auraColor);
         Global.playerObject.aura = param1;
         this.smileyAuraMenu.auraSelector.setSelectedAura(param1);
      }
      
      public function setSelectedAuraColor(param1:int = 0) : void
      {
         this.connection.send("aura",Global.playerObject.aura,param1);
         Global.playerObject.auraColor = param1;
         this.smileyAuraMenu.auraSelector.setSelectedAura(Global.playerObject.aura);
      }
      
      public function setSelectedSmiley(param1:int = 0) : void
      {
         var _loc2_:int = param1;
         var _loc3_:SmileyInstance = this.smileyAuraMenu.getSmileyInstanceByItemId(_loc2_);
         this.connection.send("smiley",_loc2_);
         Global.playerObject.smiley = _loc2_;
         this.smileyAuraMenu.setSelectedSmiley(_loc2_);
         this.smileyAuraButton.setSelectedSmiley(_loc2_);
      }
      
      public function toggleMore(param1:Boolean) : void
      {
         if(this.favoriteBricks.parent == null)
         {
            return;
         }
         if(param1)
         {
            this.hideAll(false);
         }
         this.hideAllProperties();
         this.favoriteBricks.more.gotoAndStop(!!param1?2:1);
         this.bselector.visible = param1;
         Bl.data.moreisvisible = param1;
         this.hideBrickPackagePopup();
      }
      
      public function toggleChat(param1:Boolean, param2:String = "") : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            this.hideAll();
            Global.chatIsVisible = true;
            this.chatbtn.gotoAndStop(2);
            this.chatinput.visible = true;
            this.chatinput.text.field.text = param2;
            _loc3_ = param2.length;
            if(stage)
            {
               this.chatinput.text.field.setSelection(_loc3_,_loc3_);
               stage.focus = this.chatinput.text.field;
            }
         }
         else
         {
            this.chatbtn.gotoAndStop(1);
            this.chatinput.visible = false;
            Global.chatIsVisible = false;
         }
      }
      
      public function hideAll(param1:Boolean = true) : void
      {
         this.toggleSmileyAuraMenu(false);
         this.settingsMenu.toggleVisible(false);
         this.toggleChat(false);
         if(!param1 || this.bselector.isLocked)
         {
            this.toggleMore(false);
         }
         this.toggleFavLike(false);
         this.hideAllProperties();
         this.hideBrickPackagePopup();
      }
      
      public function configureInterface(param1:Boolean = false) : void
      {
         this.usedXLeft = 0;
         this.usedXRight = 0;
         if(this.godmode.parent)
         {
            removeChild(this.godmode);
         }
         if(this.smileyAuraButton.parent)
         {
            removeChild(this.smileyAuraButton);
         }
         if(this.favoriteBricks.parent)
         {
            removeChild(this.favoriteBricks);
         }
         if(this.favLikeButton.parent)
         {
            removeChild(this.favLikeButton);
         }
         if(this.settingsMenu.parent)
         {
            removeChild(this.settingsMenu);
         }
         if(this.enterkey.parent)
         {
            removeChild(this.enterkey);
         }
         if(this.campaignInfo.parent)
         {
            removeChild(this.campaignInfo);
         }
         if(this.toggleminimap.parent)
         {
            removeChild(this.toggleminimap);
         }
         this.add(this.lobby);
         this.add(this.share);
         if(Bl.data.canEdit)
         {
            if(Bl.data.isLockedRoom)
            {
               this.add(this.godmode);
            }
            this.add(this.smileyAuraButton);
            this.add(this.chatbtn);
            this.add(this.favoriteBricks);
         }
         else
         {
            if(Bl.data.canToggleGodMode && !Bl.data.isCampaignRoom)
            {
               this.add(this.godmode);
            }
            this.add(this.smileyAuraButton);
            this.add(this.chatbtn);
            if(Bl.data.isCampaignRoom)
            {
               this.add(this.campaignInfo);
            }
            else
            {
               this.add(this.enterkey);
            }
         }
         this.add(this.settingsMenu);
         this.settingsMenu.redraw();
         if(this.minimapEnabled)
         {
            this.add(this.toggleminimap,true);
         }
         if(!Bl.data.owner && !Bl.data.isOpenWorld && !Global.player_is_guest)
         {
            this.add(this.favLikeButton,true);
         }
         addChild(this.above);
      }
      
      private function add(param1:InteractiveObject, param2:Boolean = false) : void
      {
         param1.y = -29;
         if(param2)
         {
            param1.x = Config.width - param1.width - this.usedXRight;
            this.usedXRight = this.usedXRight + (param1.width - 1);
         }
         else
         {
            param1.x = this.usedXLeft;
            this.usedXLeft = this.usedXLeft + (param1.width - 1);
         }
         addChild(param1);
      }
      
      private function handleAttach(param1:Event) : void
      {
         stage.stageFocusRect = false;
         stage.focus = stage;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.handleKeyUp);
      }
      
      private function handleDetatch(param1:Event) : void
      {
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.handleKeyDown);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.handleKeyUp);
      }
      
      private function previousChatInput() : void
      {
         var _loc1_:String = this.textArray[9];
         this.chatinput.text.field.text = _loc1_;
      }
      
      private function sendChat() : void
      {
         var next:String = null;
         var cmd:Array = null;
         var cmdName:String = null;
         var ps:PlayState = null;
         var players:Object = null;
         var i:String = null;
         var p:Player = null;
         var user:String = null;
         var reason:String = null;
         var reportPrompt:ReportPrompt = null;
         var playState:PlayState = null;
         var targetName:String = null;
         var x:Number = NaN;
         var y:Number = NaN;
         var found:Boolean = false;
         var pls:Object = null;
         var j:String = null;
         var player:Player = null;
         var repeatCount:int = 0;
         var text:String = this.chatinput.text.field.text;
         var ltext:String = text.toLocaleLowerCase();
         var iscommand:Boolean = text.charAt(0) == "/";
         this.textArray.push(text);
         this.textArray.shift();
         this.timerArray.push(new Date().time - this.lastMessageTime);
         this.timerArray.shift();
         var totalTime:int = 0;
         var a:int = 0;
         while(a < this.timerArray.length)
         {
            totalTime = totalTime + this.timerArray[a];
            a++;
         }
         if(!iscommand)
         {
            text = text.replace(/([\?\!]{2})[\?\!]+/gi,"$1");
            text = text.replace(/\.{4,}/gi,"...");
            next = text.replace(/(:?.+)\1{5,}/gi,"$1$1$1$1$1");
            while(next != text)
            {
               text = next;
               next = text.replace(/(:?.+)\1{5,}/gi,"$1$1$1$1$1");
            }
            if(text.length > 4 && text.match(/[A-Z]/g).length > text.length / 2)
            {
               text = text.toLowerCase();
            }
         }
         this.hideAll();
         if(iscommand)
         {
            cmd = StringUtil.trim(text).split(" ");
            cmdName = cmd[0].toString().toLowerCase();
            if(cmdName == "/gbd" && (Bl.data.isAdmin == true || Bl.data.isModerator == true))
            {
               this.connection.send("smileyGoldBorder",cmd[1] == "true");
            }
            else if(text == "/killroom" && (Bl.data.isAdmin == true || Bl.data.isModerator == true))
            {
               this.connection.send("kill");
            }
            else if(cmdName == "/r")
            {
               this.base.SystemSay("Command removed. Use BACKSPACE instead to quickly respond to latest private message.");
            }
            else if(cmdName == "/inspect")
            {
               Global.getPlacer = !Global.getPlacer;
               this.base.SystemSay("Inspect tool active: " + Global.getPlacer.toString().toUpperCase(),"* System");
            }
            else if(cmdName == "/clearchat")
            {
               this.base.sidechat.clearChat();
               this.base.SystemSay("Chat cleared.","* System");
            }
            else if(cmdName == "/roomid")
            {
               this.base.SystemSay("Room ID: " + Global.roomid,"* System");
            }
            else if(cmdName == "/spec" || cmdName == "/spectate")
            {
               ps = this.base.state as PlayState;
               if(this.allowSpectating && cmd.length >= 2 && cmd[1].toString().toLowerCase() != ps.player.name.toLowerCase())
               {
                  players = ps.getPlayers();
                  for(i in players)
                  {
                     p = players[i] as Player;
                     if(p.name.toLowerCase() == cmd[1].toString().toLowerCase())
                     {
                        ps.spectate(p);
                        break;
                     }
                  }
               }
               else if(!this.allowSpectating && cmd.length >= 2)
               {
                  Global.base.SystemSay("Spectating is not allowed in this world.","* SYSTEM");
               }
               else
               {
                  ps.stopSpectating();
               }
            }
            else if((cmdName == "/rep" || cmdName == "/report" || cmdName == "/reportabuse") && cmd.length >= 2)
            {
               user = cmd[1].toString();
               cmd.splice(0,2);
               reason = cmd.join(" ");
               reportPrompt = new ReportPrompt(user,reason);
               reportPrompt.confirmButton.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
               {
                  var confirmRules:ConfirmRulesPrompt = null;
                  var e:MouseEvent = param1;
                  confirmRules = new ConfirmRulesPrompt();
                  confirmRules.continueButton.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
                  {
                     connection.send("say","/report " + user + " " + reportPrompt.reportText);
                     confirmRules.close();
                     reportPrompt.close();
                  });
                  Global.base.overlayContainer.addChild(confirmRules);
               });
               Global.base.overlayContainer.addChild(reportPrompt);
            }
            else if(cmdName == "/teleport" || cmdName == "/tp" && (Bl.data.owner || Bl.data.isAdmin || Bl.data.isModerator))
            {
               this.teleport(cmd);
            }
            else if(cmdName == "/getpos")
            {
               playState = this.base.state as PlayState;
               targetName = playState.player.name;
               x = Math.round(playState.player.x / 16);
               y = Math.round(playState.player.y / 16);
               if(cmd.length >= 2 && StringUtil.trim(cmd[1].toString()) != "")
               {
                  found = false;
                  pls = playState.getPlayers();
                  targetName = cmd[1].toString().toLowerCase();
                  for(j in pls)
                  {
                     player = pls[j] as Player;
                     if(player.name.toLowerCase() == targetName)
                     {
                        x = Math.round(player.x / 16);
                        y = Math.round(player.y / 16);
                        found = true;
                        break;
                     }
                  }
                  if(!found)
                  {
                     Global.base.SystemSay("Player not found.","* System");
                     return;
                  }
               }
               Global.base.SystemSay(targetName.toUpperCase() + " is located at " + x + "x" + y,"* System");
            }
            else if(cmdName == "/save")
            {
               if(Bl.data.canChangeWorldOptions || Bl.data.isAdmin)
               {
                  Global.base.showLoadingScreen("Saving World");
                  this.connection.send("save");
               }
               else
               {
                  Global.base.SystemSay("You are not allowed to save this world.","* System");
               }
            }
            else
            {
               this.connection.send("say",text);
            }
         }
         else if(text.replace(/\s/gi,"").length > 0)
         {
            this.lastMessageTime = new Date().time;
            if(totalTime < 5000)
            {
               Global.base.SystemSay("Easy now, you don\'t want the other players mistaking you for a spammer!");
               return;
            }
            repeatCount = 0;
            a = 0;
            while(a < this.textArray.length)
            {
               if(this.textArray[a] == text)
               {
                  repeatCount++;
               }
               a++;
            }
            if(repeatCount > 3)
            {
               Global.base.SystemSay("You have said the same thing " + repeatCount + " times. Time to try something new, or you might get kicked.");
               return;
            }
            this.connection.send("say",text);
         }
      }
      
      private function teleport(param1:Array) : void
      {
         var _loc6_:* = null;
         var _loc7_:Player = null;
         var _loc8_:String = null;
         var _loc9_:Player = null;
         var _loc10_:* = null;
         var _loc11_:Player = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         if(param1.length < 2)
         {
            Global.base.SystemSay("Please specify a player to teleport.","* System");
            return;
         }
         var _loc2_:PlayState = this.base.state as PlayState;
         var _loc3_:Object = _loc2_.getPlayers();
         var _loc4_:String = param1[1].toString().toLowerCase();
         var _loc5_:Player = null;
         for(_loc6_ in _loc3_)
         {
            _loc7_ = _loc3_[_loc6_] as Player;
            if(_loc7_.name.toLowerCase() == _loc4_)
            {
               _loc5_ = _loc7_;
               break;
            }
         }
         if(_loc5_ == null)
         {
            Global.base.SystemSay("Player not found.","* System");
            return;
         }
         if(param1.length == 2 || StringUtil.trim(param1[2].toString()) == "")
         {
            this.connection.send("say","/teleport " + _loc5_.name + " " + Math.round(_loc2_.player.x / 16) + " " + Math.round(_loc2_.player.y / 16));
         }
         else if(param1.length == 3 || StringUtil.trim(param1[3].toString()) == "")
         {
            _loc8_ = param1[2].toString().toLowerCase();
            _loc9_ = null;
            for(_loc10_ in _loc3_)
            {
               _loc11_ = _loc3_[_loc10_] as Player;
               if(_loc11_.name.toLowerCase() == _loc8_)
               {
                  _loc9_ = _loc11_;
                  break;
               }
            }
            if(_loc9_ == null)
            {
               Global.base.SystemSay("Target not found.","* System");
               return;
            }
            this.connection.send("say","/teleport " + _loc5_.name + " " + Math.round(_loc9_.x / 16) + " " + Math.round(_loc9_.y / 16));
         }
         else
         {
            _loc12_ = parseInt(param1[2]);
            _loc13_ = parseInt(param1[3]);
            if(isNaN(_loc12_) || isNaN(_loc13_))
            {
               Global.base.SystemSay("Invalid target.","* System");
               return;
            }
            this.connection.send("say","/teleport " + _loc5_.name + " " + _loc12_ + " " + _loc13_);
         }
      }
      
      public function toggleVisible(param1:Boolean) : void
      {
         this.visible = param1;
      }
      
      private function handleKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 16)
         {
            Global.chatIsVisible = true;
         }
         if(param1.keyCode == 9)
         {
            if(this.bselector.visible)
            {
               this.bselector.cyclePagesAndTabs(!!Bl.isKeyDown(Keyboard.SHIFT)?-1:1);
            }
            this.toggleMore(true);
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         }
         if(param1.keyCode == Keyboard.B)
         {
            if(!this.bselector.visible)
            {
               this.toggleMore(true);
            }
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         }
         else if(param1.keyCode == Keyboard.F && param1.ctrlKey)
         {
            if(Bl.data.canEdit)
            {
               this.toggleMore(true);
               stage.focus = this.bselector.search.textfield;
            }
         }
         if(param1.keyCode == 13 && !Config.isMobile || param1.keyCode == 191 || param1.keyCode == 8)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            if(param1.keyCode == 8)
            {
               if(this.latestPM != "")
               {
                  this.toggleChat(true,"/pm " + this.latestPM + "  ");
               }
               else
               {
                  this.toggleChat(true,"/pm  ");
               }
            }
            else
            {
               this.toggleChat(true);
            }
         }
         if(param1.keyCode == 77 && this.minimapEnabled)
         {
            this.toggleMinimap(this.toggleminimap.currentFrame == 1);
         }
         if(param1.keyCode == 27)
         {
            this.hideAll();
         }
         if(param1.altKey)
         {
            if(param1.keyCode >= 48 && param1.keyCode <= 57)
            {
               param1.preventDefault();
               param1.stopImmediatePropagation();
               param1.stopPropagation();
               this.connection.send("autosay",param1.keyCode - 48);
               this.toggleChat(false);
            }
         }
      }
      
      private function handleKeyUp(param1:KeyboardEvent) : void
      {
         if(stage.focus is TextField)
         {
            return;
         }
         if(param1.keyCode == 16)
         {
            Global.chatIsVisible = this.chatbtn.currentFrame != 1;
         }
         if(param1.keyCode == Keyboard.B)
         {
            this.toggleMore(false);
            param1.preventDefault();
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         }
         else if(param1.keyCode == Keyboard.T)
         {
            this.toggleChat(true);
         }
      }
   }
}
