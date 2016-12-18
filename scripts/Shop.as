package
{
   import playerio.Client;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.Event;
   import playerio.Message;
   import data.ShopItemData;
   import com.greensock.*;
   import blitter.Bl;
   import flash.display.BitmapData;
   import items.ItemManager;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import ui.Prompt;
   import flash.events.MouseEvent;
   import ui.ConfirmPrompt;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import playerio.PlayerIOError;
   import ui.profile.FriendSmiley;
   import flash.display.Bitmap;
   import ui.shop.RedeemCode;
   
   public class Shop
   {
      
      private static var refreshed:Boolean = false;
      
      private static var base:EverybodyEdits;
      
      private static var refreshDate:Number = 0;
      
      private static var _energy:int = 0;
      
      private static var _timeToEnergy:int = 0;
      
      private static var _totalEnergy:int = 0;
      
      private static var _secondsBetweenEnergy:int = 0;
      
      private static var newest_item:String = "";
      
      private static var client:Client;
      
      private static var selected:String = "featured";
      
      private static var container:Sprite;
      
      private static var dataidhash:Object = {};
      
      private static var eventdispatcher:EventDispatcher = new EventDispatcher();
      
      private static var inited:Boolean = false;
      
      public static var refreshLobby:Boolean = false;
      
      private static var shopRef:GetGemsNow = null;
      
      private static var gs:GetGemsNow;
      
      private static var gsbg:BlackBG;
      
      private static var last_gemamount:int = -1;
       
      
      public function Shop()
      {
         super();
      }
      
      public static function setBase(param1:EverybodyEdits, param2:Client) : void
      {
         base = param1;
         client = param2;
      }
      
      public static function setContainer(param1:Sprite) : void
      {
         container = param1;
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         eventdispatcher.addEventListener(param1,param2,false,0,true);
      }
      
      public static function dispatchEvent(param1:Event) : void
      {
         eventdispatcher.dispatchEvent(param1);
      }
      
      public static function isInitiallyRefreshed() : Boolean
      {
         return refreshed;
      }
      
      public static function reset(param1:Function) : void
      {
         refreshed = false;
         dataidhash = {};
         refresh(param1);
         refreshCrewShop(null);
      }
      
      public static function refresh(param1:Function) : void
      {
         var callback:Function = param1;
         client.payVault.refresh(function():void
         {
            base.requestRemoteMethod("getShop",function(param1:Message):void
            {
               update(param1,false);
               if(callback != null)
               {
                  callback();
               }
            });
         });
      }
      
      public static function refreshCrewShop(param1:Function) : void
      {
         var callback:Function = param1;
         client.payVault.refresh(function():void
         {
            if(Global.currentCrew != "")
            {
               base.requestCrewLobbyMethod(Global.currentCrew,"getShop",function(param1:Message):void
               {
                  update(param1,true);
                  if(callback != null)
                  {
                     callback();
                  }
               },function():void
               {
                  if(callback != null)
                  {
                     callback();
                  }
               });
            }
            else if(callback != null)
            {
               callback();
            }
         });
      }
      
      public static function getRefreshTime() : Number
      {
         return refreshDate;
      }
      
      public static function getItemData(param1:String) : ShopItemData
      {
         return dataidhash[param1] as ShopItemData;
      }
      
      public static function getShopItemsNotOwnedByPlayer() : Vector.<ShopItemData>
      {
         var _loc2_:ShopItemData = null;
         if(!refreshed)
         {
            throw new Error("You cannot call the shop without refreshing it first");
         }
         var _loc1_:Vector.<ShopItemData> = new Vector.<ShopItemData>();
         for each(_loc2_ in dataidhash)
         {
            if(_loc2_ != null)
            {
               if(!_loc2_.ownedInPayvault || _loc2_.reusable && (_loc2_.maxPurchases > _loc2_.owned_count || _loc2_.maxPurchases == 0))
               {
                  if(!(_loc2_.isCrewOnly && _loc2_.reusable && _loc2_.ownedInPayvault))
                  {
                     _loc1_.push(_loc2_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      public static function getAllShopItems() : Vector.<ShopItemData>
      {
         var _loc2_:ShopItemData = null;
         if(!refreshed)
         {
            throw new Error("You cannot call the shop without refreshing it first");
         }
         var _loc1_:Vector.<ShopItemData> = new Vector.<ShopItemData>();
         for each(_loc2_ in dataidhash)
         {
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public static function getImportantShopItems() : Vector.<ShopItemData>
      {
         var _loc2_:ShopItemData = null;
         if(!refreshed)
         {
            throw new Error("You cannot call the shop without refreshing it first");
         }
         var _loc1_:Vector.<ShopItemData> = new Vector.<ShopItemData>();
         for each(_loc2_ in dataidhash)
         {
            if(_loc2_ != null)
            {
               if(_loc2_.isNew || _loc2_.isOnSale)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_;
      }
      
      private static function cleanCrewShopItems() : void
      {
         var _loc1_:ShopItemData = null;
         for each(_loc1_ in dataidhash)
         {
            if(_loc1_ != null)
            {
               if(_loc1_.isCrewOnly)
               {
                  dataidhash[_loc1_.id] = null;
               }
            }
         }
      }
      
      private static function update(param1:Message = null, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ShopItemData = null;
         var _loc5_:int = 0;
         var _loc6_:ShopItemData = null;
         refreshed = true;
         refreshDate = new Date().time;
         _energy = param1.getInt(1);
         _timeToEnergy = param1.getInt(2);
         _totalEnergy = param1.getInt(3);
         _secondsBetweenEnergy = param1.getInt(4);
         if(Global.player_is_guest)
         {
            _energy = 100;
            _timeToEnergy = 60;
            _totalEnergy = 200;
            _secondsBetweenEnergy = 150;
         }
         if(param2)
         {
            cleanCrewShopItems();
            _loc3_ = 5;
            while(_loc3_ < param1.length)
            {
               _loc4_ = new ShopItemData(param1.getString(_loc3_),"crew",param1.getInt(_loc3_ + 1),param1.getInt(_loc3_ + 2),param1.getInt(_loc3_ + 3),param1.getInt(_loc3_ + 4),param1.getInt(_loc3_ + 5),0,param1.getString(_loc3_ + 6),param1.getString(_loc3_ + 7),"",param1.getInt(_loc3_ + 8),param1.getBoolean(_loc3_ + 9),param1.getBoolean(_loc3_ + 10),false,false,param1.getBoolean(_loc3_ + 11),false,false,-1,param1.getBoolean(_loc3_ + 12),param1.getInt(_loc3_ + 13),param1.getBoolean(_loc3_ + 14),param1.getString(_loc3_ + 15),param1.getString(_loc3_ + 16));
               _loc4_.isCrewOnly = true;
               if(_loc4_.type != null && (!_loc4_.isDevOnly || Config.show_disabled_shopitems))
               {
                  if(_loc4_.bitmapsheet_id != null)
                  {
                     setBitmapData(_loc4_);
                  }
                  if(_loc4_.id != "smileypostman" || Bl.data.fromemail)
                  {
                     dataidhash[_loc4_.id] = _loc4_;
                  }
                  if(_loc4_.isNew && newest_item == "")
                  {
                     newest_item = _loc4_.id;
                  }
               }
               _loc3_ = _loc3_ + 17;
            }
         }
         else
         {
            _loc5_ = 5;
            while(_loc5_ < param1.length)
            {
               _loc6_ = new ShopItemData(param1.getString(_loc5_),param1.getString(_loc5_ + 1),param1.getInt(_loc5_ + 2),param1.getInt(_loc5_ + 3),param1.getInt(_loc5_ + 4),param1.getInt(_loc5_ + 5),param1.getInt(_loc5_ + 6),param1.getInt(_loc5_ + 7),param1.getString(_loc5_ + 8),param1.getString(_loc5_ + 9),param1.getString(_loc5_ + 10),param1.getInt(_loc5_ + 11),param1.getBoolean(_loc5_ + 12),param1.getBoolean(_loc5_ + 13),param1.getBoolean(_loc5_ + 14),param1.getBoolean(_loc5_ + 15),param1.getBoolean(_loc5_ + 16),param1.getBoolean(_loc5_ + 17),param1.getBoolean(_loc5_ + 18),param1.getInt(_loc5_ + 19),param1.getBoolean(_loc5_ + 20),param1.getInt(_loc5_ + 21),param1.getBoolean(_loc5_ + 22),param1.getString(_loc5_ + 23),param1.getString(_loc5_ + 24));
               if(_loc6_.type != null && (!_loc6_.isDevOnly || Config.show_disabled_shopitems))
               {
                  if(_loc6_.bitmapsheet_id != null)
                  {
                     setBitmapData(_loc6_);
                  }
                  if(_loc6_.id != "smileypostman" || Bl.data.fromemail)
                  {
                     dataidhash[_loc6_.id] = _loc6_;
                  }
                  if(_loc6_.isNew && newest_item == "")
                  {
                     newest_item = _loc6_.id;
                  }
               }
               _loc5_ = _loc5_ + 25;
            }
         }
         if(!Global.canchat && !Bl.data.chatbanned && !Global.player_is_guest)
         {
            dataidhash["canchat"] = getChatShopItemData();
         }
         last_gemamount = gems;
         dispatchEvent(new ShopEvent(ShopEvent.UPDATE));
      }
      
      public static function setBitmapData(param1:ShopItemData) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:int = 0;
         var _loc5_:BitmapData = null;
         var _loc4_:int = 0;
         switch(param1.bitmapsheet_id)
         {
            case "smilies":
               _loc2_ = ItemManager.smiliesBMD;
               _loc3_ = 26;
               _loc4_ = 26;
               break;
            case "auraColors":
               _loc2_ = ItemManager.shopAurasBMD;
               _loc3_ = 194;
               break;
            case "auraShapes":
               _loc2_ = ImageUtils.createAuraShapeImageFromPayVaultId(param1.id);
               _loc3_ = 64;
               break;
            case "worlds":
               _loc2_ = ItemManager.worldsBMD;
               _loc3_ = 194;
               break;
            case "services":
               _loc2_ = ItemManager.shopBMD;
               _loc3_ = 194;
               break;
            case "bricks":
               switch(param1.id)
               {
                  case "bricknode":
                     _loc2_ = ImageUtils.createImageForSmileyAndBlocks(param1.id,49);
                     _loc3_ = _loc2_.width;
                     break;
                  case "brickdrums":
                     _loc2_ = ImageUtils.createImageForSmileyAndBlocks(param1.id,50);
                     _loc3_ = _loc2_.width;
                     break;
                  case "mixednewyear2010":
                     _loc2_ = ImageUtils.createImageForSmileyAndBlocks(param1.id,20);
                     _loc3_ = _loc2_.width;
                     break;
                  case "brickvalentines2015":
                     _loc2_ = ImageUtils.createImageForSmileyAndBlocks(param1.id,105);
                     _loc3_ = _loc2_.width;
                     break;
                  default:
                     _loc2_ = ImageUtils.createBricksImageFromPayVaultId(param1.id);
                     if(_loc2_)
                     {
                        _loc3_ = _loc2_.width;
                     }
               }
               break;
            default:
               return new BitmapData(1,1,true,0);
         }
         if(_loc2_)
         {
            _loc5_ = new BitmapData(_loc3_,_loc2_.height - _loc4_,true,0);
            _loc5_.copyPixels(_loc2_,new Rectangle(_loc3_ * param1.bitmapsheet_offset,0,_loc3_,_loc2_.height),new Point(0,0));
            param1.image_bitmap = _loc5_;
         }
         return _loc5_;
      }
      
      private static function getChatShopItemData() : ShopItemData
      {
         var _loc1_:ShopItemData = new ShopItemData("canchat",ShopItemData.TYPE_OTHER,-1,0,0,1,0,3,"Chat access verification","When enabling chat, you will also receive 20 Gems. The gems are awarded next time you login.","shopitem_323",8,false,true,false,false,false,false,false,-1,false,0,false,"","");
         _loc1_.isDollars = true;
         setBitmapData(_loc1_);
         return _loc1_;
      }
      
      public static function useEnergy(param1:String, param2:Boolean, param3:Boolean, param4:Function) : void
      {
         var spendEnergy:Function = null;
         var target:String = param1;
         var useAll:Boolean = param2;
         var crewItem:Boolean = param3;
         var callback:Function = param4;
         spendEnergy = function(param1:Message):void
         {
            var m:Message = param1;
            if(m.getString(0) == "error")
            {
               base.showInfo(m.getString(1),m.getString(2));
               callback(false);
               return;
            }
            if(m.getBoolean(0))
            {
               setTimeout(function():void
               {
                  Global.base.showLoadingScreen("Acquiring Item");
                  client.payVault.refresh(function():void
                  {
                     Global.base.hideLoadingScreen();
                     update(m,crewItem);
                     var _loc1_:ShopEvent = new ShopEvent(ShopEvent.ITEM_AQUIRED);
                     _loc1_.payvaultId = target;
                     dispatchEvent(_loc1_);
                     itemAcquired(target);
                  });
               },50);
            }
            else
            {
               update(m,crewItem);
            }
            callback(true);
         };
         var message:String = !!useAll?"useAllEnergy":"useEnergy";
         if(Global.player_is_guest)
         {
            Global.base.showRegister();
            callback(false);
            return;
         }
         if(crewItem)
         {
            base.requestCrewLobbyMethod(Global.currentCrew,message,spendEnergy,null,target);
         }
         else
         {
            base.requestRemoteMethod(message,spendEnergy,target);
         }
      }
      
      public static function useGems(param1:String, param2:int, param3:Boolean, param4:Function) : void
      {
         var spendGems:Function = null;
         var target:String = param1;
         var value:int = param2;
         var crewItem:Boolean = param3;
         var callback:Function = param4;
         spendGems = function(param1:Message):void
         {
            var m:Message = param1;
            if(m.getString(0) == "error")
            {
               getMoreGems(value - last_gemamount);
               callback(false);
            }
            else
            {
               setTimeout(function():void
               {
                  Global.base.showLoadingScreen("Acquiring Item");
                  client.payVault.refresh(function():void
                  {
                     Global.base.hideLoadingScreen();
                     update(m,crewItem);
                     var _loc1_:ShopEvent = new ShopEvent(ShopEvent.ITEM_AQUIRED);
                     _loc1_.payvaultId = target;
                     dispatchEvent(_loc1_);
                     itemAcquired(target);
                  });
               },50);
               callback(true);
            }
         };
         if(Global.player_is_guest)
         {
            Global.base.showRegister();
            callback(false);
            return;
         }
         if(target == "canchat")
         {
            buyChat(callback);
            return;
         }
         if(crewItem)
         {
            base.requestCrewLobbyMethod(Global.currentCrew,"useGems",spendGems,null,target);
         }
         else
         {
            base.requestRemoteMethod("useGems",spendGems,target);
         }
      }
      
      public static function itemAcquired(param1:String) : void
      {
         var id:String = param1;
         if(id == "changeusername")
         {
            Global.playerObject.changename = true;
            Global.base.checkChangeUsername(Global.playerObject,Global.client,function():void
            {
               Global.base.logout();
            });
         }
         if(id == "crew")
         {
            handleSetCrewName();
         }
      }
      
      private static function handleSetCrewName() : void
      {
         var prompt:Prompt = null;
         prompt = new Prompt("Set your crew name!","",null,25,true,false);
         prompt.savebtn.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            var crewName:String = null;
            var cPrompt:ConfirmPrompt = null;
            var e:MouseEvent = param1;
            if(prompt.inputvar.text.length > 0)
            {
               crewName = prompt.inputvar.text;
               cPrompt = new ConfirmPrompt("Are you sure you want to name your crew \"" + crewName + "\"? This cannot be changed afterwards!",false);
               Global.base.showConfirmPrompt(cPrompt);
               cPrompt.ben_yes.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
               {
                  var e:MouseEvent = param1;
                  Global.base.showLoadingScreen("Creating New Crew");
                  Global.base.requestRemoteMethod("createCrew",function(param1:Message):void
                  {
                     if(!param1.getBoolean(0))
                     {
                        prompt.setError(param1.getString(1));
                        Global.base.hideLoadingScreen();
                     }
                     else
                     {
                        Global.base.updateMemberItems(false);
                        Global.base.hideLoadingScreen();
                        prompt.close();
                     }
                     cPrompt.close();
                  },crewName);
               });
            }
         });
         prompt.savebtn.gotoAndStop(2);
         Global.base.showPrompt(prompt);
      }
      
      public static function buyItem(param1:String, param2:Function) : void
      {
         var target:String = param1;
         var callback:Function = param2;
         var shopitem:ShopItemData = getItemData(target);
         var paypalargs:Object = {
            "currency":"USD",
            "item_name":shopitem.text_header,
            "cpp_header_image":"http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/Everybody Edits Website/images/ee_paypal_logo.png",
            "on0":"UserID",
            "os0":client.connectUserId,
            "cancel_return":"http://everybodyedits.com/",
            "lc":"US"
         };
         paypalargs["return"] = "http://everybodyedits.com/thankyou.html";
         client.payVault.getBuyDirectInfo("paypal",paypalargs,[{"itemKey":target}],function(param1:Object):void
         {
            var info:Object = param1;
            callback(true);
            reset(function():void
            {
               var req:URLRequest = null;
               req = new URLRequest(info.paypalurl);
               try
               {
                  navigateToURL(req,"_top");
                  return;
               }
               catch(e:Error)
               {
                  navigateToURL(req,"_blank");
                  return;
               }
            });
         },function(param1:PlayerIOError):void
         {
            callback(false);
         });
      }
      
      private static function buyChat(param1:Function) : void
      {
         var conf:VerifyAge = null;
         var callback:Function = param1;
         conf = new VerifyAge();
         container.addChild(conf);
         conf.x = (Global.width - 472) / 2;
         conf.closebtn.addEventListener(MouseEvent.CLICK,function():void
         {
            callback(false);
            container.removeChild(conf);
         });
         conf.verifybtn.addEventListener(MouseEvent.CLICK,function():void
         {
            var paypalargs:Object = {
               "currency":"USD",
               "item_name":"Enable chat in Everybody Edits",
               "cpp_header_image":"http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/Everybody Edits Website/images/ee_paypal_logo.png",
               "on0":"UserID",
               "os0":client.connectUserId,
               "cancel_return":"http://everybodyedits.com/",
               "lc":"US"
            };
            paypalargs["return"] = "http://everybodyedits.com/thankyou.html";
            client.payVault.getBuyDirectInfo("paypal",paypalargs,[{"itemKey":"canchat2"}],function(param1:Object):void
            {
               var info:Object = param1;
               callback(true);
               reset(function():void
               {
                  var req:URLRequest = null;
                  req = new URLRequest(info.paypalurl);
                  try
                  {
                     navigateToURL(req,"_top");
                     return;
                  }
                  catch(e:Error)
                  {
                     navigateToURL(req,"_blank");
                     return;
                  }
               });
            },function(param1:PlayerIOError):void
            {
               callback(false);
            });
         });
      }
      
      public static function get energy() : int
      {
         if(!refreshed)
         {
            throw new Error("You cannot call the shop without refreshing it first");
         }
         var _loc1_:int = _energy;
         var _loc2_:Number = new Date().time - refreshDate;
         var _loc3_:Number = _timeToEnergy - _loc2_ / 1000;
         while(_loc3_ < 0)
         {
            _loc3_ = _loc3_ + _secondsBetweenEnergy;
            _loc1_++;
         }
         return Math.min(_totalEnergy,_loc1_);
      }
      
      public static function get gems() : int
      {
         if(!refreshed)
         {
            throw new Error("You cannot call the shop without refreshing it first");
         }
         return client.payVault.coins;
      }
      
      public static function get totalEnergy() : int
      {
         if(!refreshed)
         {
            throw new Error("You cannot call the shop without refreshing it first");
         }
         return _totalEnergy;
      }
      
      public static function get prettyTimeToNext() : String
      {
         if(!refreshed)
         {
            throw new Error("You cannot call the shop without refreshing it first");
         }
         var _loc1_:Number = new Date().time - refreshDate;
         var _loc2_:Number = _timeToEnergy - _loc1_ / 1000;
         while(_loc2_ < 0)
         {
            _loc2_ = _loc2_ + _secondsBetweenEnergy;
         }
         var _loc3_:Number = int(_loc2_ / 60);
         var _loc4_:Number = int(_loc2_ - _loc3_ * 60);
         return _loc3_ + ":" + (_loc4_ < 10?"0" + _loc4_:_loc4_);
      }
      
      public static function getMoreGems(param1:int = -1) : void
      {
         var close:Function = null;
         var closecallback:Function = null;
         var paypalargs:Object = null;
         var successcallback:Function = null;
         var hidesuperrewards:Sprite = null;
         var smileygx:FriendSmiley = null;
         var smileybitmap:Bitmap = null;
         var short:int = param1;
         close = function(param1:MouseEvent = null):void
         {
            var e:MouseEvent = param1;
            TweenMax.to(gs,0.2,{
               "alpha":0,
               "onComplete":function():void
               {
                  TweenMax.to(gsbg,0.25,{
                     "alpha":0,
                     "onComplete":function():void
                     {
                        if(gs && gs.parent)
                        {
                           gs.parent.removeChild(gs);
                        }
                        if(gsbg && gsbg.parent)
                        {
                           gsbg.parent.removeChild(gsbg);
                        }
                        shopRef = null;
                        gs = null;
                        gsbg = null;
                     }
                  });
               }
            });
         };
         if(Global.player_is_guest)
         {
            Global.base.showRegister();
            return;
         }
         gsbg = new BlackBG();
         gs = new GetGemsNow();
         gs.name = "GetGemsNow";
         gs.x = (Global.width - 606) / 2;
         gs.closebtn.addEventListener(MouseEvent.CLICK,close);
         gs.redeemBtn.addEventListener(MouseEvent.CLICK,function():void
         {
            var c:RedeemCode = null;
            c = new RedeemCode();
            Global.base.overlayContainer.addChild(c);
            c.btnActivate.addEventListener(MouseEvent.CLICK,function():void
            {
               if(c.inputvar.text != "")
               {
                  base.requestRemoteMethod("redeemCode",function(param1:Message):void
                  {
                     var _loc2_:Boolean = param1.getBoolean(0);
                     if(_loc2_)
                     {
                        Global.base.refresShop();
                        Global.base.refreshCrewShop();
                     }
                  },c.inputvar.text);
               }
            });
         });
         gs.myCodesBtn.addEventListener(MouseEvent.CLICK,function():void
         {
            base.requestRemoteMethod("getMyCodes",function(param1:Message):void
            {
            });
         });
         if(short > 0)
         {
            gs.shortText.text = "You\'re " + short + " Gem" + (short > 1?"s":"") + " short on that item!";
         }
         gs.stop();
         closecallback = function(param1:int = 0):void
         {
            close();
         };
         if(Global.playing_on_faceboook)
         {
            gs.gotoAndStop(3);
            gs.credits3.addEventListener(MouseEvent.CLICK,function():void
            {
               base.buyGemsWithFacebook(50,closecallback);
               gs.credits3.visible = gs.credits4.visible = gs.credits5.visible = gs.credits6.visible = false;
            });
            gs.credits4.addEventListener(MouseEvent.CLICK,function():void
            {
               base.buyGemsWithFacebook(100,closecallback);
               gs.credits3.visible = gs.credits4.visible = gs.credits5.visible = gs.credits6.visible = false;
            });
            gs.credits5.addEventListener(MouseEvent.CLICK,function():void
            {
               base.buyGemsWithFacebook(200,closecallback);
               gs.credits3.visible = gs.credits4.visible = gs.credits5.visible = gs.credits6.visible = false;
            });
            gs.credits6.addEventListener(MouseEvent.CLICK,function():void
            {
               base.buyGemsWithFacebook(500,closecallback);
               gs.credits3.visible = gs.credits4.visible = gs.credits5.visible = gs.credits6.visible = false;
            });
         }
         else if(Bl.data.iskongregate)
         {
            gs.gotoAndStop(2);
            gs.kreds3.addEventListener(MouseEvent.CLICK,function():void
            {
               base.buyGemsWithKongregate(20,closecallback);
               gs.kreds1.visible = gs.kreds2.visible = gs.kreds3.visible = gs.kreds4.visible = gs.kreds5.visible = gs.kreds6.visible = false;
            });
            gs.kreds4.addEventListener(MouseEvent.CLICK,function():void
            {
               base.buyGemsWithKongregate(50,closecallback);
               gs.kreds1.visible = gs.kreds2.visible = gs.kreds3.visible = gs.kreds4.visible = gs.kreds5.visible = gs.kreds6.visible = false;
            });
            gs.kreds5.addEventListener(MouseEvent.CLICK,function():void
            {
               base.buyGemsWithKongregate(100,closecallback);
               gs.kreds1.visible = gs.kreds2.visible = gs.kreds3.visible = gs.kreds4.visible = gs.kreds5.visible = gs.kreds6.visible = false;
            });
            gs.kreds6.addEventListener(MouseEvent.CLICK,function():void
            {
               base.buyGemsWithKongregate(200,closecallback);
               gs.kreds1.visible = gs.kreds2.visible = gs.kreds3.visible = gs.kreds4.visible = gs.kreds5.visible = gs.kreds6.visible = false;
            });
         }
         else
         {
            paypalargs = {
               "currency":"USD",
               "cpp_header_image":"http://playerio-a.akamaihd.net/everybody-edits-su9rn58o40itdbnw69plyw/Everybody%20Edits%20Website/images/ee_paypal_logo.png",
               "on0":"Info",
               "os0":client.connectUserId + " " + Global.playerObject.name,
               "cancel_return":"http://everybodyedits.com/",
               "lc":"US"
            };
            paypalargs["return"] = "http://everybodyedits.com/thankyou.html";
            successcallback = function(param1:String):void
            {
               handlePaymentUrlSuccess(param1);
            };
            gs.buybtn3.addEventListener(MouseEvent.CLICK,function():void
            {
               paypalargs["coinamount"] = "50";
               paypalargs["item_name"] = "50 Everybody Edits Gems";
               getProviderUrl("paypal",paypalargs,successcallback);
            });
            gs.buybtn4.addEventListener(MouseEvent.CLICK,function():void
            {
               paypalargs["coinamount"] = "105";
               paypalargs["item_name"] = "105 Everybody Edits Gems";
               getProviderUrl("paypal",paypalargs,successcallback);
            });
            gs.buybtn5.addEventListener(MouseEvent.CLICK,function():void
            {
               paypalargs["coinamount"] = "220";
               paypalargs["item_name"] = "220 Everybody Edits Gems";
               getProviderUrl("paypal",paypalargs,successcallback);
            });
            hidesuperrewards = new Sprite();
            hidesuperrewards.x = Global.playing_on_kongregate || Global.playing_on_armorgames?Number(gs.x + 60):Number(gs.x + 35);
            hidesuperrewards.y = 325;
            hidesuperrewards.graphics.beginFill(16777215);
            hidesuperrewards.graphics.drawRect(0,0,310,72);
            smileygx = new FriendSmiley(ItemManager.smiliesBMD);
            smileygx.frame = 0;
            smileybitmap = smileygx.getAsBitmap(5);
            smileybitmap.x = (hidesuperrewards.width - smileybitmap.width) / 2;
            smileybitmap.y = (hidesuperrewards.height - smileybitmap.height) / 2;
            hidesuperrewards.addChild(smileybitmap);
            gs.addChild(hidesuperrewards);
            gs.srbtn.visible = false;
         }
         shopRef = gs;
         container.addChild(gsbg);
         container.addChild(gs);
         TweenMax.to(gs,0,{"alpha":0});
         TweenMax.to(gsbg,0,{"alpha":0});
         TweenMax.to(gs,0.2,{"alpha":1});
         TweenMax.to(gsbg,0.3,{"alpha":1});
      }
      
      public static function getProviderUrl(param1:String, param2:Object, param3:Function) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = "http://api.playerio.com/payvault/" + param1 + "/coinsredirect?gameid=" + Config.playerio_game_id + "&connectuserid=" + Global.client.connectUserId + "&connection=secure";
         for(_loc5_ in param2)
         {
            _loc4_ = _loc4_ + ("&" + _loc5_ + "=" + escape(param2[_loc5_]));
         }
         param3(_loc4_);
      }
      
      public static function doFocus() : void
      {
         if(shopRef)
         {
            container.addChild(shopRef);
         }
      }
      
      private static function handlePaymentUrlSuccess(param1:String) : void
      {
         var thankyou:asset_paypalreturn = null;
         var url:String = param1;
         if(gs && gs.parent)
         {
            gs.parent.removeChild(gs);
         }
         if(gsbg && gsbg.parent)
         {
            gsbg.parent.removeChild(gsbg);
         }
         shopRef = null;
         gs = null;
         gsbg = null;
         thankyou = new asset_paypalreturn();
         thankyou.btn_returntogame.addEventListener(MouseEvent.CLICK,function():void
         {
            thankyou.btn_returntogame.visible = false;
            setTimeout(function():void
            {
               refresh(function():void
               {
                  thankyou.parent.removeChild(thankyou);
               });
            },3000);
         });
         thankyou.x = (Global.width - 472) / 2;
         thankyou.name = "Thankyou";
         container.addChild(thankyou);
         try
         {
            navigateToURL(new URLRequest(url),"_blank");
            return;
         }
         catch(e:Error)
         {
            navigateToURL(new URLRequest(url),"_top");
            return;
         }
      }
      
      private static function handlePayPalRequestError(param1:PlayerIOError) : void
      {
      }
      
      public static function hasSeenNewest() : Boolean
      {
         return Global.sharedCookie.data["newest_item"] == newest_item;
      }
      
      public static function setSeenNewest() : void
      {
         Global.sharedCookie.data["newest_item"] = newest_item;
      }
   }
}
