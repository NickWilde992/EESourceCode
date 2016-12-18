package
{
   import blitter.BlTilemap;
   import ui.ingame.ResetPopup;
   import flash.geom.Point;
   import blitter.BlSprite;
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import blitter.BlContainer;
   import items.ItemManager;
   import com.reygazu.anticheat.variables.SecureBoolean;
   import items.ItemId;
   import playerio.DatabaseObject;
   import flash.utils.ByteArray;
   import playerio.Message;
   import blitter.BlText;
   import blitter.BlObject;
   import blitter.Bl;
   import states.PlayState;
   import flash.display.Bitmap;
   
   public class World extends BlTilemap
   {
      
      private static var worldportaltext:WorldPortalHelpBubble = new WorldPortalHelpBubble();
      
      private static var resetPopup:ResetPopup = new ResetPopup();
      
      private static var point:Point = new Point();
      
      private static var sprite:BlSprite;
      
      private static var rect16x16:Rectangle = new Rectangle(0,0,16,16);
      
      private static var rect18x18:Rectangle = new Rectangle(0,0,18,18);
      
      private static var bmd:BitmapData;
      
      private static var ashift:uint = 0;
      
      private static var type:int;
       
      
      private var player:Player;
      
      private var labelcontainer:BlContainer;
      
      public var particlecontainer:BlContainer;
      
      private var bgColor:uint = 11059452;
      
      private var customBgColor:Boolean = false;
      
      public var lookup:Lookup;
      
      private var textSignBubble:TextBubble;
      
      public var showAllSecrets:Boolean = false;
      
      private var inspectTool:InspectTool;
      
      private var offset:Number = 0;
      
      private var _hideRed:SecureBoolean;
      
      private var _hideGreen:SecureBoolean;
      
      private var _hideBlue:SecureBoolean;
      
      private var _hideCyan:SecureBoolean;
      
      private var _hideMagenta:SecureBoolean;
      
      private var _hideYellow:SecureBoolean;
      
      public var orangeSwitches:Object;
      
      private var _hideTimedoor:Boolean = false;
      
      public var canShowOrHidePurple:Boolean = false;
      
      public var showCoinGate:int = 0;
      
      public var showBlueCoinGate:int = 0;
      
      public var showDeathGate:int = 0;
      
      public var hideTimedoorOffset:Number = 0;
      
      public var hideTimedoorTimer:Number;
      
      private var ice:Number = 0;
      
      private var iceTime:int = 60;
      
      public var fullImage:BitmapData;
      
      public function World(param1:Boolean = true)
      {
         this.labelcontainer = new BlContainer();
         this.particlecontainer = new BlContainer();
         this.lookup = new Lookup();
         this.textSignBubble = new TextBubble();
         this._hideRed = new SecureBoolean("RedKey");
         this._hideGreen = new SecureBoolean("GreenKey");
         this._hideBlue = new SecureBoolean("BlueKey");
         this._hideCyan = new SecureBoolean("CyanKey");
         this._hideMagenta = new SecureBoolean("MagentaKey");
         this._hideYellow = new SecureBoolean("YellowKey");
         this.orangeSwitches = {};
         this.hideTimedoorTimer = new Date().time;
         super(new Bitmap(new BitmapData(16,16,false,0)),9);
         if(param1)
         {
            this.lookup.reset();
            this.customBgColor = false;
         }
         this.inspectTool = new InspectTool(this);
      }
      
      public function set hideTimedoor(param1:Boolean) : void
      {
         this.hideTimedoorOffset = this.offset;
         this.hideTimedoorTimer = new Date().time;
         this._hideTimedoor = param1;
      }
      
      public function setShowAllSecrets(param1:Boolean) : void
      {
         this.showAllSecrets = param1;
      }
      
      public function setPlayer(param1:Player) : void
      {
         this.player = param1;
      }
      
      public function setBackgroundColor(param1:uint) : void
      {
         this.customBgColor = (param1 >> 24 & 255) == 255;
         this.bgColor = param1;
         ItemManager.bricks[0].minimapColor = !!this.customBgColor?Number(param1):Number(4278190080);
      }
      
      public function get hideRed() : Boolean
      {
         return this._hideRed.value;
      }
      
      public function set hideRed(param1:Boolean) : void
      {
         this._hideRed.value = param1;
      }
      
      public function get hideGreen() : Boolean
      {
         return this._hideGreen.value;
      }
      
      public function set hideGreen(param1:Boolean) : void
      {
         this._hideGreen.value = param1;
      }
      
      public function get hideBlue() : Boolean
      {
         return this._hideBlue.value;
      }
      
      public function set hideBlue(param1:Boolean) : void
      {
         this._hideBlue.value = param1;
      }
      
      public function get hideCyan() : Boolean
      {
         return this._hideCyan.value;
      }
      
      public function set hideCyan(param1:Boolean) : void
      {
         this._hideCyan.value = param1;
      }
      
      public function get hideMagenta() : Boolean
      {
         return this._hideMagenta.value;
      }
      
      public function set hideMagenta(param1:Boolean) : void
      {
         this._hideMagenta.value = param1;
      }
      
      public function get hideYellow() : Boolean
      {
         return this._hideYellow.value;
      }
      
      public function set hideYellow(param1:Boolean) : void
      {
         this._hideYellow.value = param1;
      }
      
      override public function update() : void
      {
         var _loc2_:Particle = null;
         this.offset = this.offset + 0.3;
         var _loc1_:int = 0;
         while(_loc1_ < this.particlecontainer.children.length)
         {
            _loc2_ = this.particlecontainer.children[_loc1_] as Particle;
            _loc2_.tick();
            _loc1_++;
         }
         super.update();
      }
      
      public function updateRotateablesMap(param1:int, param2:int, param3:int, param4:int = 0) : void
      {
         var _loc5_:int = getTile(param4,param2,param3);
         if(_loc5_ != param1 && ((_loc5_ == ItemId.SPIKE || ItemId.isBlockRotateable(_loc5_)) && (param1 == ItemId.SPIKE || ItemId.isBlockRotateable(param1))))
         {
            this.lookup.deleteLookup(param2,param3);
         }
      }
      
      public function deserializeFromDatabaseObject(param1:DatabaseObject) : void
      {
         var _loc10_:int = 0;
         var _loc11_:Object = null;
         var _loc12_:ByteArray = null;
         var _loc13_:ByteArray = null;
         var _loc14_:ByteArray = null;
         var _loc15_:ByteArray = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         this.setBackgroundColor(uint(param1.backgroundColor) || uint(0));
         var _loc2_:int = int(param1.width) || 0;
         var _loc3_:int = int(param1.height) || 0;
         if(_loc2_ == 0 || _loc3_ == 0)
         {
            switch(param1.type)
            {
               case 1:
                  _loc2_ = 50;
                  _loc3_ = 50;
                  break;
               case 2:
                  _loc2_ = 100;
                  _loc3_ = 100;
                  break;
               default:
               case 3:
                  _loc2_ = 200;
                  _loc3_ = 200;
                  break;
               case 4:
                  _loc2_ = 400;
                  _loc3_ = 50;
                  break;
               case 5:
                  _loc2_ = 400;
                  _loc3_ = 200;
                  break;
               case 6:
                  _loc2_ = 100;
                  _loc3_ = 400;
                  break;
               case 7:
                  _loc2_ = 636;
                  _loc3_ = 50;
                  break;
               case 8:
                  _loc2_ = 110;
                  _loc3_ = 110;
                  break;
               case 11:
                  _loc2_ = 300;
                  _loc3_ = 300;
                  break;
               case 12:
                  _loc2_ = 250;
                  _loc3_ = 150;
            }
         }
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < 2)
         {
            _loc5_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc6_ = [];
               _loc10_ = 0;
               while(_loc10_ < _loc2_)
               {
                  _loc6_.push(0);
                  _loc10_++;
               }
               _loc5_.push(_loc6_);
               _loc7_++;
            }
            _loc4_.push(_loc5_);
            _loc8_++;
         }
         setMapArray(_loc4_);
         var _loc9_:Array = param1.worlddata || [];
         _loc7_ = 0;
         while(_loc7_ < _loc9_.length)
         {
            if(_loc9_[_loc7_] != null)
            {
               _loc11_ = _loc9_[_loc7_];
               _loc12_ = _loc11_.x || new ByteArray();
               _loc13_ = _loc11_.y || new ByteArray();
               _loc14_ = _loc11_.x1 || new ByteArray();
               _loc15_ = _loc11_.y1 || new ByteArray();
               _loc16_ = int(_loc11_.layer) || 0;
               _loc17_ = int(_loc11_.type) || 0;
               _loc12_.position = 0;
               _loc13_.position = 0;
               _loc14_.position = 0;
               _loc15_.position = 0;
               while(_loc14_.position < _loc14_.length)
               {
                  _loc18_ = _loc14_.readUnsignedByte();
                  _loc19_ = _loc15_.readUnsignedByte();
                  _loc4_[_loc16_][_loc19_][_loc18_] = _loc17_;
               }
               while(_loc12_.position < _loc12_.length)
               {
                  _loc20_ = (_loc12_.readUnsignedByte() << 8) + _loc12_.readUnsignedByte();
                  _loc21_ = (_loc13_.readUnsignedByte() << 8) + _loc13_.readUnsignedByte();
                  _loc4_[_loc16_][_loc21_][_loc20_] = _loc17_;
               }
            }
            _loc7_++;
         }
         setMapArray(_loc4_);
      }
      
      public function deserializeFromMessage(param1:int, param2:int, param3:Message) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:ByteArray = null;
         var _loc16_:ByteArray = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:String = null;
         var _loc25_:int = 0;
         var _loc26_:Boolean = false;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:BlText = null;
         var _loc6_:int = 0;
         while(_loc6_ < param3.length)
         {
            try
            {
               if(param3.getString(_loc6_) == "ws")
               {
                  _loc4_ = _loc6_ + 1;
               }
               if(param3.getString(_loc6_) == "we")
               {
                  _loc5_ = _loc6_;
               }
            }
            catch(e:Error)
            {
            }
            _loc6_++;
         }
         var _loc7_:Array = [];
         var _loc8_:Array = [];
         var _loc9_:Array = [];
         this.lookup.reset();
         var _loc10_:int = 0;
         while(_loc10_ < 2)
         {
            _loc8_ = [];
            _loc11_ = 0;
            while(_loc11_ < param2)
            {
               _loc9_ = [];
               _loc12_ = 0;
               while(_loc12_ < param1)
               {
                  _loc9_.push(0);
                  _loc12_++;
               }
               _loc8_.push(_loc9_);
               _loc11_++;
            }
            _loc7_.push(_loc8_);
            _loc10_++;
         }
         while(_loc4_ < _loc5_)
         {
            _loc13_ = param3.getInt(_loc4_++);
            _loc14_ = param3.getInt(_loc4_++);
            _loc15_ = param3.getByteArray(_loc4_++);
            _loc16_ = param3.getByteArray(_loc4_++);
            _loc17_ = 0;
            _loc18_ = 0;
            _loc19_ = 0;
            _loc20_ = 0;
            if(ItemId.isBlockRotateable(_loc13_))
            {
               _loc18_ = param3.getInt(_loc4_++);
            }
            switch(_loc13_)
            {
               case ItemId.COINGATE:
               case ItemId.COINDOOR:
               case ItemId.BLUECOINDOOR:
               case ItemId.BLUECOINGATE:
               case ItemId.DEATH_DOOR:
               case ItemId.DEATH_GATE:
               case ItemId.SWITCH_PURPLE:
               case ItemId.DOOR_PURPLE:
               case ItemId.GATE_PURPLE:
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
                  _loc17_ = param3.getInt(_loc4_++);
                  break;
               case ItemId.SPIKE:
                  _loc18_ = param3.getInt(_loc4_++);
                  break;
               case ItemId.PORTAL_INVISIBLE:
               case ItemId.PORTAL:
                  _loc18_ = param3.getInt(_loc4_++);
                  _loc19_ = param3.getInt(_loc4_++);
                  _loc20_ = param3.getInt(_loc4_++);
                  break;
               case ItemId.WORLD_PORTAL:
                  _loc23_ = param3.getString(_loc4_++);
                  break;
               case ItemId.TEXT_SIGN:
                  _loc24_ = param3.getString(_loc4_++);
                  _loc25_ = param3.getInt(_loc4_++);
                  break;
               case 1000:
                  _loc21_ = param3.getString(_loc4_++);
                  _loc22_ = param3.getString(_loc4_++);
                  break;
               case 83:
               case 77:
                  _loc19_ = param3.getInt(_loc4_++);
            }
            _loc15_.position = 0;
            _loc16_.position = 0;
            _loc27_ = 0;
            while(_loc27_ < _loc15_.length / 2)
            {
               _loc28_ = _loc15_.readUnsignedShort();
               _loc29_ = _loc16_.readUnsignedShort();
               _loc7_[_loc14_][_loc29_][_loc28_] = _loc13_;
               if(ItemId.isBlockRotateable(_loc13_))
               {
                  this.lookup.setInt(_loc28_,_loc29_,_loc18_);
               }
               switch(_loc13_)
               {
                  case ItemId.COINDOOR:
                  case ItemId.BLUECOINDOOR:
                  case ItemId.BLUECOINGATE:
                  case ItemId.COINGATE:
                  case ItemId.DEATH_DOOR:
                  case ItemId.DEATH_GATE:
                  case ItemId.SWITCH_PURPLE:
                  case ItemId.DOOR_PURPLE:
                  case ItemId.GATE_PURPLE:
                  case ItemId.EFFECT_TEAM:
                  case ItemId.TEAM_DOOR:
                  case ItemId.TEAM_GATE:
                  case ItemId.EFFECT_CURSE:
                  case ItemId.EFFECT_ZOMBIE:
                  case ItemId.EFFECT_FLY:
                  case ItemId.EFFECT_JUMP:
                  case ItemId.EFFECT_PROTECTION:
                  case ItemId.EFFECT_RUN:
                  case ItemId.EFFECT_LOW_GRAVITY:
                  case ItemId.EFFECT_MULTIJUMP:
                  case ItemId.SWITCH_ORANGE:
                  case ItemId.DOOR_ORANGE:
                  case ItemId.GATE_ORANGE:
                     this.lookup.setInt(_loc28_,_loc29_,_loc17_);
                     break;
                  case 83:
                  case 77:
                     this.lookup.setInt(_loc28_,_loc29_,_loc19_);
                     break;
                  case ItemId.SPIKE:
                     this.lookup.setInt(_loc28_,_loc29_,_loc18_);
                     break;
                  case ItemId.PORTAL_INVISIBLE:
                  case ItemId.PORTAL:
                     this.lookup.setPortal(_loc28_,_loc29_,new Portal(_loc19_,_loc20_,_loc18_,_loc13_));
                     break;
                  case ItemId.WORLD_PORTAL:
                     this.lookup.setText(_loc28_,_loc29_,_loc23_);
                     break;
                  case 1000:
                     _loc30_ = new BlText(Global.default_label_size,200,uint("0x" + _loc22_.substr(1,_loc22_.length)),"left","system",true);
                     _loc30_.text = _loc21_;
                     _loc30_.x = _loc28_ * size;
                     _loc30_.y = _loc29_ * size;
                     this.labelcontainer.add(_loc30_);
                  case ItemId.TEXT_SIGN:
                     this.lookup.setTextSign(_loc28_,_loc29_,new TextSign(_loc24_,_loc25_));
                     break;
                  case ItemId.BRICK_COMPLETE:
               }
               _loc27_++;
            }
         }
         setMapArray(_loc7_);
         return _loc7_;
      }
      
      public function resetCoins() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < width)
         {
            _loc2_ = 0;
            while(_loc2_ < height)
            {
               if(realmap[0][_loc2_][_loc1_] == 110)
               {
                  this.setTile(0,_loc1_,_loc2_,100);
               }
               if(realmap[0][_loc2_][_loc1_] == 111)
               {
                  this.setTile(0,_loc1_,_loc2_,101);
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function setTileComplex(param1:int, param2:int, param3:int, param4:int, param5:Object) : void
      {
         var _loc6_:BlText = null;
         var _loc7_:int = 0;
         var _loc8_:BlText = null;
         if(param1 == 0)
         {
            this.lookup.deleteLookup(param2,param3);
         }
         if(ItemId.isBlockRotateable(param4))
         {
            if(param5.rotation != null)
            {
               this.lookup.setInt(param2,param3,param5.rotation);
            }
         }
         switch(param4)
         {
            case ItemId.COINDOOR:
            case ItemId.BLUECOINDOOR:
            case ItemId.BLUECOINGATE:
            case ItemId.COINGATE:
            case ItemId.SWITCH_PURPLE:
            case ItemId.DOOR_PURPLE:
            case ItemId.GATE_PURPLE:
            case ItemId.DEATH_DOOR:
            case ItemId.DEATH_GATE:
            case ItemId.EFFECT_TEAM:
            case ItemId.TEAM_DOOR:
            case ItemId.TEAM_GATE:
            case ItemId.EFFECT_CURSE:
            case ItemId.EFFECT_ZOMBIE:
            case ItemId.EFFECT_FLY:
            case ItemId.EFFECT_JUMP:
            case ItemId.EFFECT_PROTECTION:
            case ItemId.EFFECT_RUN:
            case ItemId.EFFECT_LOW_GRAVITY:
            case ItemId.EFFECT_MULTIJUMP:
            case ItemId.SWITCH_ORANGE:
            case ItemId.DOOR_ORANGE:
            case ItemId.GATE_ORANGE:
               this.lookup.setInt(param2,param3,param5.goal);
               break;
            case ItemId.SPIKE:
               if(param5.rotation != null)
               {
                  this.lookup.setInt(param2,param3,param5.rotation);
               }
               break;
            case ItemId.PORTAL_INVISIBLE:
            case ItemId.PORTAL:
               if(param5.rotation != null && param5.id != null && param5.target != null)
               {
                  this.lookup.setPortal(param2,param3,new Portal(param5.id,param5.target,param5.rotation,param4));
               }
               break;
            case ItemId.WORLD_PORTAL:
               if(param5.target != null)
               {
                  this.lookup.setText(param2,param3,param5.target);
               }
               break;
            case ItemId.TEXT_SIGN:
               if(param5.text != null && param5.signtype != null)
               {
                  this.lookup.setTextSign(param2,param3,new TextSign(param5.text,param5.signtype));
               }
               break;
            case 83:
            case 77:
               this.lookup.setInt(param2,param3,param5.sound);
               this.lookup.setBlink(param2,param3,30);
               break;
            case 411:
            case 412:
            case 413:
            case 414:
            case ItemId.SLOW_DOT_INVISIBLE:
               this.lookup.setBlink(param2,param3,0);
               break;
            case 1000:
               _loc6_ = new BlText(Global.default_label_size,200,uint("0x" + param5.text_color.substr(1,param5.text_color.length)),"left","system",true);
               _loc6_.text = param5.text;
               _loc6_.x = param2 * size;
               _loc6_.y = param3 * size;
               this.labelcontainer.add(_loc6_);
         }
         if(param4 != 1000 && param1 == 0)
         {
            _loc7_ = 0;
            while(_loc7_ < this.labelcontainer.children.length)
            {
               _loc8_ = this.labelcontainer.children[_loc7_] as BlText;
               if(_loc8_.x == param2 * size && _loc8_.y == param3 * size)
               {
                  this.labelcontainer.remove(_loc8_);
                  break;
               }
               _loc7_++;
            }
         }
         this.setTile(param1,param2,param3,param4);
      }
      
      override protected function setTile(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:Vector.<BlObject> = null;
         var _loc6_:int = 0;
         var _loc7_:BlObject = null;
         if(realmap[param1][param3][param2] == 1000)
         {
            _loc5_ = this.labelcontainer.children;
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc7_ = _loc5_[_loc6_];
               if(_loc7_.x == param2 * size && _loc7_.y == param3 * size)
               {
                  this.labelcontainer.remove(_loc7_);
                  break;
               }
               _loc6_++;
            }
         }
         super.setTile(param1,param2,param3,param4);
      }
      
      public function Overlaps(param1:BlObject, param2:int, param3:int, param4:Boolean = false) : Boolean
      {
         var _loc6_:Rectangle = null;
         if((param1 as Player).isFlying)
         {
            return false;
         }
         var _loc5_:int = realmap[0][param3][param2];
         if(ItemId.isSolid(_loc5_) || param4)
         {
            _loc6_ = ItemManager.GetBlockBounds(_loc5_);
            if(param4)
            {
               _loc6_ = ItemManager.GetBlockBounds(_loc5_,this.lookup.getInt(param2,param3));
            }
            _loc6_.x = _loc6_.x + param2 * 16;
            _loc6_.y = _loc6_.y + param3 * 16;
            if(_loc6_.intersects(new Rectangle(param1.x,param1.y,16,16)))
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      override public function overlaps(param1:BlObject) : int
      {
         var _loc11_:Vector.<int> = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         if(param1.x < 0 || param1.y < 0 || param1.x > this.width * 16 - 16 || param1.y > this.height * 16 - 16)
         {
            return 1;
         }
         var _loc2_:Player = param1 as Player;
         if(_loc2_.isFlying)
         {
            return 0;
         }
         var _loc3_:* = _loc2_.x >> 4;
         var _loc4_:* = _loc2_.y >> 4;
         var _loc5_:Number = (param1.x + param1.height) / size;
         var _loc6_:Number = (param1.y + param1.width) / size;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc12_:Rectangle = new Rectangle(_loc2_.x,_loc2_.y,16,16);
         var _loc13_:int = _loc4_;
         while(_loc13_ < _loc6_)
         {
            _loc11_ = realmap[0][_loc13_];
            _loc14_ = _loc3_;
            for(; _loc14_ < _loc5_; _loc14_++)
            {
               if(_loc11_ != null)
               {
                  _loc15_ = _loc11_[_loc14_];
                  if(ItemId.isSolid(_loc15_))
                  {
                     if(_loc12_.intersects(new Rectangle(_loc14_ * 16,_loc13_ * 16,16,16)))
                     {
                        _loc16_ = this.lookup.getInt(_loc14_,_loc13_);
                        if(_loc15_ == ItemId.ONEWAY_CYAN || _loc15_ == ItemId.ONEWAY_PINK || _loc15_ == ItemId.ONEWAY_ORANGE || _loc15_ == ItemId.ONEWAY_YELLOW || _loc15_ == ItemId.ONEWAY_GRAY || _loc15_ == ItemId.ONEWAY_BLUE || _loc15_ == ItemId.ONEWAY_RED || _loc15_ == ItemId.ONEWAY_GREEN || _loc15_ == ItemId.ONEWAY_BLACK || _loc15_ == ItemId.ONEWAY_WHITE)
                        {
                           if(ItemId.canJumpThroughFromBelow(_loc15_))
                           {
                              if((_loc2_.speedY < 0 || _loc13_ <= _loc2_.overlapa || _loc2_.speedY == 0 && _loc2_.speedX == 0 && _loc2_.oy + 15 > _loc13_ * 16) && _loc16_ == 1)
                              {
                                 if(_loc13_ != _loc4_ || _loc2_.overlapa == -1)
                                 {
                                    _loc2_.overlapa = _loc13_;
                                 }
                                 _loc7_ = true;
                                 continue;
                              }
                              if((_loc2_.speedX > 0 || _loc14_ <= _loc2_.overlapb || _loc2_.speedY == 0 && _loc2_.speedX == 0 && _loc2_.ox + 15 > _loc14_ * 16) && _loc16_ == 2)
                              {
                                 if(_loc14_ == _loc3_ || _loc2_.overlapb == -1)
                                 {
                                    _loc2_.overlapb = _loc14_;
                                 }
                                 _loc8_ = true;
                                 continue;
                              }
                              if((_loc2_.speedY > 0 || _loc13_ <= _loc2_.overlapc || _loc2_.speedY == 0 && _loc2_.speedX == 0 && _loc2_.oy - 15 < _loc13_ * 16) && _loc16_ == 3)
                              {
                                 if(_loc13_ == _loc4_ || _loc2_.overlapc == -1)
                                 {
                                    _loc2_.overlapc = _loc13_;
                                 }
                                 _loc9_ = true;
                                 continue;
                              }
                              if((_loc2_.speedX < 0 || _loc14_ <= _loc2_.overlapd || _loc2_.speedY == 0 && _loc2_.speedX == 0 && _loc2_.ox - 15 < _loc14_ * 16) && _loc16_ == 0)
                              {
                                 if(_loc14_ != _loc3_ || _loc2_.overlapd == -1)
                                 {
                                    _loc2_.overlapd = _loc14_;
                                 }
                                 _loc10_ = true;
                                 continue;
                              }
                           }
                        }
                        else if(ItemId.isHalfBlock(_loc15_))
                        {
                           if(_loc16_ == 1)
                           {
                              if(!_loc12_.intersects(new Rectangle(_loc14_ * 16,_loc13_ * 16 + 8,16,8)))
                              {
                                 continue;
                              }
                           }
                           else if(_loc16_ == 2)
                           {
                              if(!_loc12_.intersects(new Rectangle(_loc14_ * 16,_loc13_ * 16,8,16)))
                              {
                                 continue;
                              }
                           }
                           else if(_loc16_ == 3)
                           {
                              if(!_loc12_.intersects(new Rectangle(_loc14_ * 16,_loc13_ * 16,16,8)))
                              {
                                 continue;
                              }
                           }
                           else if(_loc16_ == 0)
                           {
                              if(!_loc12_.intersects(new Rectangle(_loc14_ * 16 + 8,_loc13_ * 16,8,16)))
                              {
                                 continue;
                              }
                           }
                        }
                        else if(ItemId.canJumpThroughFromBelow(_loc15_))
                        {
                           if(_loc2_.speedY < 0 || _loc13_ <= _loc2_.overlapa || _loc2_.speedY == 0 && _loc2_.speedX == 0 && _loc2_.oy + 15 > _loc13_ * 16)
                           {
                              if(_loc13_ != _loc4_ || _loc2_.overlapa == -1)
                              {
                                 _loc2_.overlapa = _loc13_;
                              }
                              _loc7_ = true;
                              continue;
                           }
                        }
                        switch(_loc15_)
                        {
                           case 23:
                              if(this.hideRed)
                              {
                                 continue;
                              }
                              break;
                           case 24:
                              if(this.hideGreen)
                              {
                                 continue;
                              }
                              break;
                           case 25:
                              if(this.hideBlue)
                              {
                                 continue;
                              }
                              break;
                           case 26:
                              if(!this.hideRed)
                              {
                                 continue;
                              }
                              break;
                           case 27:
                              if(!this.hideGreen)
                              {
                                 continue;
                              }
                              break;
                           case 28:
                              if(!this.hideBlue)
                              {
                                 continue;
                              }
                              break;
                           case 1005:
                              if(this.hideCyan)
                              {
                                 continue;
                              }
                              break;
                           case 1006:
                              if(this.hideMagenta)
                              {
                                 continue;
                              }
                              break;
                           case 1007:
                              if(this.hideYellow)
                              {
                                 continue;
                              }
                              break;
                           case 1008:
                              if(!this.hideCyan)
                              {
                                 continue;
                              }
                              break;
                           case 1009:
                              if(!this.hideMagenta)
                              {
                                 continue;
                              }
                              break;
                           case 1010:
                              if(!this.hideYellow)
                              {
                                 continue;
                              }
                              break;
                           case 156:
                              if(this._hideTimedoor)
                              {
                                 continue;
                              }
                              break;
                           case 157:
                              if(!this._hideTimedoor)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.DOOR_PURPLE:
                              if(_loc2_.switches[this.lookup.getInt(_loc14_,_loc13_)])
                              {
                                 continue;
                              }
                              break;
                           case ItemId.GATE_PURPLE:
                              if(!_loc2_.switches[this.lookup.getInt(_loc14_,_loc13_)])
                              {
                                 continue;
                              }
                              break;
                           case ItemId.DOOR_ORANGE:
                              if(this.orangeSwitches[this.lookup.getInt(_loc14_,_loc13_)])
                              {
                                 continue;
                              }
                              break;
                           case ItemId.GATE_ORANGE:
                              if(!this.orangeSwitches[this.lookup.getInt(_loc14_,_loc13_)])
                              {
                                 continue;
                              }
                              break;
                           case ItemId.DOOR_GOLD:
                              if(_loc2_.isgoldmember)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.GATE_GOLD:
                              if(!_loc2_.isgoldmember)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.CROWNDOOR:
                              if(_loc2_.collideWithCrownDoorGate)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.CROWNGATE:
                              if(!_loc2_.collideWithCrownDoorGate)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.COINDOOR:
                              if(this.lookup.getInt(_loc14_,_loc13_) <= _loc2_.coins)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.BLUECOINDOOR:
                              if(this.lookup.getInt(_loc14_,_loc13_) <= _loc2_.bcoins)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.COINGATE:
                              if(this.lookup.getInt(_loc14_,_loc13_) > (!!_loc2_.isme?this.showCoinGate:_loc2_.coins))
                              {
                                 continue;
                              }
                              break;
                           case ItemId.BLUECOINGATE:
                              if(this.lookup.getInt(_loc14_,_loc13_) > (!!_loc2_.isme?this.showBlueCoinGate:_loc2_.bcoins))
                              {
                                 continue;
                              }
                              break;
                           case ItemId.DEATH_DOOR:
                              if(this.lookup.getInt(_loc14_,_loc13_) <= _loc2_.deaths)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.DEATH_GATE:
                              if(this.lookup.getInt(_loc14_,_loc13_) > (!!_loc2_.isme?this.showDeathGate:_loc2_.deaths))
                              {
                                 continue;
                              }
                              break;
                           case ItemId.TEAM_DOOR:
                              if(_loc2_.team == this.lookup.getInt(_loc14_,_loc13_))
                              {
                                 continue;
                              }
                              break;
                           case ItemId.TEAM_GATE:
                              if(_loc2_.team != this.lookup.getInt(_loc14_,_loc13_))
                              {
                                 continue;
                              }
                              break;
                           case ItemId.ZOMBIE_GATE:
                              if(!_loc2_.zombie)
                              {
                                 continue;
                              }
                              break;
                           case ItemId.ZOMBIE_DOOR:
                              if(_loc2_.zombie)
                              {
                                 continue;
                              }
                              break;
                           case 50:
                              if(_loc2_.isme)
                              {
                                 this.lookup.setSecret(_loc14_,_loc13_,true);
                              }
                        }
                        return _loc15_;
                     }
                  }
                  else if(_loc15_ == 243 && _loc2_.isme)
                  {
                     this.lookup.setSecret(_loc14_,_loc13_,true);
                     continue;
                  }
                  continue;
               }
            }
            _loc13_++;
         }
         if(!_loc7_)
         {
            _loc2_.overlapa = -1;
         }
         if(!_loc8_)
         {
            _loc2_.overlapb = -1;
         }
         if(!_loc9_)
         {
            _loc2_.overlapc = -1;
         }
         if(!_loc10_)
         {
            _loc2_.overlapd = -1;
         }
         return 0;
      }
      
      public function getMinimapColor(param1:int, param2:int) : Number
      {
         return Number(ItemManager.getMinimapColor(int(decoration[param2][param1]) || int(forground[param2][param1]) || int(background[param2][param1]))) || Number(ItemManager.getMinimapColor(background[param2][param1]));
      }
      
      public function drawFull() : void
      {
         this.fullImage = new BitmapData(width * size,height * size,false);
         this.onDraw(this.fullImage,0,0,true);
         this.postDraw(this.fullImage,0,0,true);
         this.labelcontainer.draw(this.fullImage,0,0);
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         this.onDraw(param1,param2,param3,false);
      }
      
      private function onDraw(param1:BitmapData, param2:int, param3:int, param4:Boolean) : void
      {
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<int> = null;
         var _loc15_:Vector.<int> = null;
         var _loc16_:Vector.<int> = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:BlSprite = null;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:Portal = null;
         var _loc24_:Portal = null;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:Player = null;
         var _loc31_:int = 0;
         var _loc5_:int = !!param4?int(height * size):int(Bl.height / size);
         var _loc6_:int = !!param4?int(width * size):int(Bl.width / size);
         var _loc7_:int = -param3 / size - 1;
         var _loc8_:int = -param2 / size - 1;
         var _loc9_:Boolean = false;
         if(_loc7_ < 0)
         {
            _loc9_ = true;
            _loc7_ = 0;
         }
         if(_loc8_ < 0)
         {
            _loc9_ = true;
            _loc8_ = 0;
         }
         var _loc10_:int = _loc7_ + _loc5_ + 2;
         var _loc11_:int = _loc8_ + _loc6_ + 2;
         if(_loc10_ > height)
         {
            _loc9_ = true;
            _loc10_ = height;
         }
         if(_loc11_ > width)
         {
            _loc9_ = true;
            _loc11_ = width;
         }
         if(_loc9_)
         {
            param1.fillRect(param1.rect,0);
         }
         _loc12_ = _loc7_;
         while(_loc12_ < _loc10_)
         {
            _loc14_ = background[_loc12_];
            _loc15_ = forground[_loc12_];
            ashift = _loc12_ << 4;
            _loc13_ = _loc8_;
            while(_loc13_ < _loc11_)
            {
               point.x = (_loc13_ << 4) + param2;
               point.y = ashift + param3;
               if(_loc15_[_loc13_] == 0)
               {
                  _loc17_ = _loc14_[_loc13_];
                  if(_loc14_[_loc13_] == 0 && this.customBgColor)
                  {
                     param1.fillRect(new Rectangle(point.x,point.y,16,16),this.bgColor);
                  }
                  else
                  {
                     param1.copyPixels(ItemManager.bmdBricks[_loc14_[_loc13_]],rect16x16,point);
                  }
               }
               _loc13_++;
            }
            _loc12_++;
         }
         this.ice = this.ice + 0.25;
         if(this.ice > this.iceTime)
         {
            this.ice = 0;
            this.iceTime = Math.floor(Math.random() * (80 + 1)) + 40;
         }
         _loc12_ = _loc7_;
         while(_loc12_ < _loc10_)
         {
            _loc14_ = background[_loc12_];
            _loc16_ = decoration[_loc12_];
            _loc15_ = forground[_loc12_];
            ashift = _loc12_ << 4;
            _loc13_ = _loc8_;
            for(; _loc13_ < _loc11_; _loc13_++)
            {
               point.x = (_loc13_ << 4) + param2;
               point.y = ashift + param3;
               type = _loc15_[_loc13_];
               if(type != 0)
               {
                  param1.copyPixels(ItemManager.bmdBricks[type],rect18x18,point);
               }
               else
               {
                  type = _loc16_[_loc13_];
                  if(type != 0)
                  {
                     if(ItemId.isBlockRotateable(type) && type != ItemId.HALLOWEEN_2016_EYES)
                     {
                        _loc18_ = this.lookup.getInt(_loc13_,_loc12_);
                        _loc19_ = ItemManager.getRotateableSprite(type);
                        _loc19_.drawPoint(param1,point,_loc18_);
                     }
                     else
                     {
                        switch(type)
                        {
                           case ItemId.CHECKPOINT:
                              ItemManager.sprCheckpoint.drawPoint(param1,point,this.player.checkpoint_x == _loc13_ && this.player.checkpoint_y == _loc12_?1:0);
                              continue;
                           case 23:
                              if(this.hideRed)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,0);
                                 continue;
                              }
                              break;
                           case 26:
                              if(this.hideRed)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,3);
                                 continue;
                              }
                              break;
                           case 24:
                              if(this.hideGreen)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,1);
                                 continue;
                              }
                              break;
                           case 27:
                              if(this.hideGreen)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,4);
                                 continue;
                              }
                              break;
                           case 25:
                              if(this.hideBlue)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,2);
                                 continue;
                              }
                              break;
                           case 28:
                              if(this.hideBlue)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,5);
                                 continue;
                              }
                              break;
                           case 1005:
                              if(this.hideCyan)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,14);
                                 continue;
                              }
                              break;
                           case 1008:
                              if(this.hideCyan)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,17);
                                 continue;
                              }
                              break;
                           case 1006:
                              if(this.hideMagenta)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,15);
                                 continue;
                              }
                              break;
                           case 1009:
                              if(this.hideMagenta)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,18);
                                 continue;
                              }
                              break;
                           case 1007:
                              if(this.hideYellow)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,16);
                                 continue;
                              }
                              break;
                           case 1010:
                              if(this.hideYellow)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,19);
                                 continue;
                              }
                              break;
                           case ItemId.DEATH_DOOR:
                              if(this.lookup.getInt(_loc13_,_loc12_) <= this.player.deaths)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,20);
                              }
                              else
                              {
                                 ItemManager.sprDeathDoor.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_) - this.player.deaths);
                              }
                              continue;
                           case ItemId.DEATH_GATE:
                              if(this.lookup.getInt(_loc13_,_loc12_) <= this.player.deaths)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,21);
                              }
                              else
                              {
                                 ItemManager.sprDeathGate.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_) - this.player.deaths);
                              }
                              continue;
                           case ItemId.DOOR_PURPLE:
                              if(this.player.switches[this.lookup.getInt(_loc13_,_loc12_)])
                              {
                                 ItemManager.sprPurpleGates.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              else
                              {
                                 ItemManager.sprPurpleDoors.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              continue;
                           case ItemId.GATE_PURPLE:
                              if(this.player.switches[this.lookup.getInt(_loc13_,_loc12_)])
                              {
                                 ItemManager.sprPurpleDoors.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              else
                              {
                                 ItemManager.sprPurpleGates.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              continue;
                           case ItemId.DOOR_ORANGE:
                              if(this.orangeSwitches[this.lookup.getInt(_loc13_,_loc12_)])
                              {
                                 ItemManager.sprOrangeGates.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              else
                              {
                                 ItemManager.sprOrangeDoors.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              continue;
                           case ItemId.GATE_ORANGE:
                              if(this.orangeSwitches[this.lookup.getInt(_loc13_,_loc12_)])
                              {
                                 ItemManager.sprOrangeDoors.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              else
                              {
                                 ItemManager.sprOrangeGates.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              continue;
                           case ItemId.DOOR_GOLD:
                              if(this.player.isgoldmember)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,10);
                                 continue;
                              }
                              break;
                           case ItemId.GATE_GOLD:
                              if(this.player.isgoldmember)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,11);
                                 continue;
                              }
                              break;
                           case ItemId.SWITCH_PURPLE:
                              if(this.player.switches[this.lookup.getInt(_loc13_,_loc12_)])
                              {
                                 ItemManager.sprSwitchDOWN.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              else
                              {
                                 ItemManager.sprSwitchUP.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              continue;
                           case ItemId.SWITCH_ORANGE:
                              if(this.orangeSwitches[this.lookup.getInt(_loc13_,_loc12_)])
                              {
                                 ItemManager.sprOrangeSwitchDOWN.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              else
                              {
                                 ItemManager.sprOrangeSwitchUP.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_));
                              }
                              continue;
                           case ItemId.TIMEDOOR:
                              ItemManager.sprDoorsTime.drawPoint(param1,point,Math.min((this.offset - this.hideTimedoorOffset) / 30 >> 0,4) + (!!this._hideTimedoor?5:0));
                              continue;
                           case ItemId.TIMEGATE:
                              ItemManager.sprDoorsTime.drawPoint(param1,point,Math.min((this.offset - this.hideTimedoorOffset) / 30 >> 0,4) + (!!this._hideTimedoor?0:5));
                              continue;
                           case 411:
                           case 412:
                           case 413:
                           case 414:
                              if(!this.player.isFlying && !param4)
                              {
                                 if(this.lookup.isBlink(_loc13_,_loc12_))
                                 {
                                    if(this.lookup.getBlink(_loc13_,_loc12_) >= 0)
                                    {
                                       _loc20_ = type - 411;
                                       if(this.lookup.getBlink(_loc13_,_loc12_) == 0)
                                       {
                                          this.lookup.setBlink(_loc13_,_loc12_,_loc20_ * 5);
                                       }
                                       _loc21_ = this.lookup.getBlink(_loc13_,_loc12_);
                                       ItemManager.sprInvGravityBlink.drawPoint(param1,point,_loc21_);
                                       if(this.lookup.updateBlink(_loc13_,_loc12_,1 / 10) >= 5 + _loc20_ * 5)
                                       {
                                          this.lookup.deleteBlink(_loc13_,_loc12_);
                                       }
                                       continue;
                                    }
                                    this.lookup.updateBlink(_loc13_,_loc12_,1);
                                    break;
                                 }
                                 continue;
                              }
                              break;
                           case ItemId.SLOW_DOT_INVISIBLE:
                              if(!this.player.isFlying && !param4)
                              {
                                 if(this.lookup.isBlink(_loc13_,_loc12_))
                                 {
                                    if(this.lookup.getBlink(_loc13_,_loc12_) >= 0)
                                    {
                                       ItemManager.sprInvDotBlink.drawPoint(param1,point,this.lookup.getBlink(_loc13_,_loc12_));
                                       if(this.lookup.updateBlink(_loc13_,_loc12_,1 / 10) >= 5)
                                       {
                                          this.lookup.deleteBlink(_loc13_,_loc12_);
                                       }
                                       continue;
                                    }
                                    this.lookup.updateBlink(_loc13_,_loc12_,1);
                                    break;
                                 }
                                 continue;
                              }
                              break;
                           case ItemId.CROWNDOOR:
                              if(this.player.collideWithCrownDoorGate)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,40);
                                 continue;
                              }
                              break;
                           case ItemId.CROWNGATE:
                              if(this.player.collideWithCrownDoorGate)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,41);
                                 continue;
                              }
                              break;
                           case ItemId.COINDOOR:
                              if(this.lookup.getInt(_loc13_,_loc12_) <= this.player.coins)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,6);
                              }
                              else
                              {
                                 ItemManager.sprCoinDoors.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_) - this.player.coins);
                              }
                              continue;
                           case ItemId.BLUECOINDOOR:
                              if(this.lookup.getInt(_loc13_,_loc12_) <= this.player.bcoins)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,36);
                              }
                              else
                              {
                                 ItemManager.sprBlueCoinDoors.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_) - this.player.bcoins);
                              }
                              continue;
                           case ItemId.COINGATE:
                              if(this.lookup.getInt(_loc13_,_loc12_) <= this.player.coins)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,7);
                              }
                              else
                              {
                                 ItemManager.sprCoinGates.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_) - this.player.coins);
                              }
                              continue;
                           case ItemId.BLUECOINGATE:
                              if(this.lookup.getInt(_loc13_,_loc12_) <= this.player.bcoins)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,37);
                              }
                              else
                              {
                                 ItemManager.sprBlueCoinGates.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_) - this.player.bcoins);
                              }
                              continue;
                           case ItemId.ZOMBIE_DOOR:
                              if(this.player.zombie)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,12);
                              }
                              else
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,13);
                              }
                              continue;
                           case ItemId.ZOMBIE_GATE:
                              if(this.player.zombie)
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,13);
                              }
                              else
                              {
                                 ItemManager.sprDoors.drawPoint(param1,point,12);
                              }
                              continue;
                           case 83:
                              if(this.lookup.isBlink(_loc13_,_loc12_))
                              {
                                 ItemManager.sprDrumsBlink.drawPoint(param1,point,this.lookup.getBlink(_loc13_,_loc12_) / 6 << 0);
                                 if(this.lookup.updateBlink(_loc13_,_loc12_,-1) <= 0)
                                 {
                                    this.lookup.deleteBlink(_loc13_,_loc12_);
                                 }
                                 continue;
                              }
                              break;
                           case 77:
                              if(this.lookup.isBlink(_loc13_,_loc12_))
                              {
                                 ItemManager.sprPianoBlink.drawPoint(param1,point,this.lookup.getBlink(_loc13_,_loc12_) / 6 << 0);
                                 if(this.lookup.updateBlink(_loc13_,_loc12_,-1) <= 0)
                                 {
                                    this.lookup.deleteBlink(_loc13_,_loc12_);
                                 }
                                 continue;
                              }
                              break;
                           case 110:
                              if(Bl.data.canEdit)
                              {
                                 ItemManager.sprCoinShadow.drawPoint(param1,point,((this.offset >> 0) + _loc13_ + _loc12_) % 12);
                              }
                              continue;
                           case 111:
                              if(Bl.data.canEdit)
                              {
                                 ItemManager.sprBonusCoinShadow.drawPoint(param1,point,((this.offset >> 0) + _loc13_ + _loc12_) % 12);
                              }
                              continue;
                           case ItemId.SPIKE:
                              _loc22_ = this.lookup.getInt(_loc13_,_loc12_);
                              ItemManager.sprHazards.drawPoint(param1,point,_loc22_);
                              continue;
                           case ItemId.PORTAL:
                              _loc23_ = this.lookup.getPortal(_loc13_,_loc12_);
                              ItemManager.sprPortal.drawPoint(param1,point,_loc23_.rotation * 15 + ((this.offset / 1.5 >> 0) + _loc13_ + _loc12_) % 15 + 1);
                              continue;
                           case ItemId.PORTAL_INVISIBLE:
                              if(Bl.data.canEdit && this.player.isFlying || param4)
                              {
                                 _loc24_ = this.lookup.getPortal(_loc13_,_loc12_);
                                 ItemManager.sprPortalInvisible.drawPoint(param1,point,_loc24_.rotation);
                              }
                              continue;
                           case ItemId.WORLD_PORTAL:
                              ItemManager.sprPortalWorld.drawPoint(param1,point,((this.offset / 2 >> 0) + _loc13_ + _loc12_) % 21);
                              if(Math.random() * 100 < 18)
                              {
                                 this.addParticle(new Particle(this,Math.random() * 100 < 50?6:7,_loc13_ * 16 + 6,_loc12_ * 16 + 6,0.7,0.7,0.013,0.013,Math.random() * 360,Math.random() * 115,true));
                              }
                              continue;
                           case ItemId.DIAMOND:
                              ItemManager.sprDiamond.drawPoint(param1,point,((this.offset / 5 >> 0) + _loc13_ + _loc12_) % 13);
                              continue;
                           case ItemId.CAKE:
                              ItemManager.sprCake.drawPoint(param1,point,((this.offset / 5 >> 0) + _loc13_ + _loc12_) % 5);
                              continue;
                           case ItemId.HOLOGRAM:
                              ItemManager.sprHologram.drawPoint(param1,point,((this.offset / 5 >> 0) + _loc13_ + _loc12_) % 5);
                              continue;
                           case ItemId.EFFECT_TEAM:
                              _loc25_ = this.lookup.getInt(_loc13_,_loc12_);
                              if(_loc25_ == 0)
                              {
                                 ItemManager.getBrickById(ItemId.EFFECT_TEAM).drawTo(param1,(_loc13_ << 4) + param2,(_loc12_ << 4) + param3);
                              }
                              else
                              {
                                 ItemManager.sprTeamEffect.drawPoint(param1,point,_loc25_ - 1);
                              }
                              continue;
                           case ItemId.TEAM_DOOR:
                              _loc26_ = this.lookup.getInt(_loc13_,_loc12_);
                              _loc27_ = 22 + _loc26_;
                              if(this.player.team == _loc26_)
                              {
                                 _loc27_ = _loc27_ + 7;
                              }
                              ItemManager.sprDoors.drawPoint(param1,point,_loc27_);
                              continue;
                           case ItemId.TEAM_GATE:
                              _loc28_ = this.lookup.getInt(_loc13_,_loc12_);
                              _loc29_ = 29 + _loc28_;
                              if(this.player.team == _loc28_)
                              {
                                 _loc29_ = _loc29_ - 7;
                              }
                              ItemManager.sprDoors.drawPoint(param1,point,_loc29_);
                              continue;
                           case ItemId.EFFECT_CURSE:
                              ItemManager.sprEffect.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_) != 0?4:11);
                              continue;
                           case ItemId.EFFECT_FLY:
                              ItemManager.sprEffect.drawPoint(param1,point,!!this.lookup.getBoolean(_loc13_,_loc12_)?1:8);
                              continue;
                           case ItemId.EFFECT_JUMP:
                              ItemManager.sprEffect.drawPoint(param1,point,!!this.lookup.getBoolean(_loc13_,_loc12_)?0:7);
                              continue;
                           case ItemId.EFFECT_PROTECTION:
                              ItemManager.sprEffect.drawPoint(param1,point,!!this.lookup.getBoolean(_loc13_,_loc12_)?3:10);
                              continue;
                           case ItemId.EFFECT_RUN:
                              ItemManager.sprEffect.drawPoint(param1,point,!!this.lookup.getBoolean(_loc13_,_loc12_)?2:9);
                              continue;
                           case ItemId.EFFECT_ZOMBIE:
                              ItemManager.sprEffect.drawPoint(param1,point,this.lookup.getInt(_loc13_,_loc12_) != 0?5:12);
                              continue;
                           case ItemId.EFFECT_LOW_GRAVITY:
                              ItemManager.sprEffect.drawPoint(param1,point,!!this.lookup.getBoolean(_loc13_,_loc12_)?13:14);
                              continue;
                           case ItemId.EFFECT_MULTIJUMP:
                              ItemManager.sprEffect.drawPoint(param1,point,15 + this.lookup.getInt(_loc13_,_loc12_));
                              continue;
                           case 50:
                              if(this.showAllSecrets || param4 || this.lookup.getSecret(_loc13_,_loc12_))
                              {
                                 ItemManager.sprSecret.drawPoint(param1,point,0);
                              }
                              continue;
                           case 243:
                              if(this.showAllSecrets || param4 || this.lookup.getSecret(_loc13_,_loc12_))
                              {
                                 ItemManager.sprSecret.drawPoint(param1,point,1);
                              }
                              else
                              {
                                 ItemManager.bricks[44].drawTo(param1,(_loc13_ << 4) + param2,(_loc12_ << 4) + param3);
                              }
                              continue;
                           case 136:
                              _loc30_ = (Global.base.state as PlayState).player;
                              if(Bl.data.canEdit && _loc30_.isFlying || param4)
                              {
                                 ItemManager.sprSecret.drawPoint(param1,point,2);
                              }
                              continue;
                           case 1000:
                              continue;
                           case ItemId.ICE:
                              if(this.lookup.getNumber(_loc13_,_loc12_) != 0)
                              {
                                 this.lookup.setNumber(_loc13_,_loc12_,this.lookup.getNumber(_loc13_,_loc12_) - 0.25);
                                 if(this.lookup.getNumber(_loc13_,_loc12_) % 12 == 0)
                                 {
                                    this.lookup.setNumber(_loc13_,_loc12_,0);
                                 }
                              }
                              else if(this.ice == (_loc13_ + _loc12_) % this.iceTime || Math.random() < 0.0001)
                              {
                                 this.lookup.setNumber(_loc13_,_loc12_,11.75);
                              }
                              ItemManager.sprIce.drawPoint(param1,point,11 - (this.lookup.getNumber(_loc13_,_loc12_) >> 0) % 12);
                              continue;
                           case ItemId.CAVE_TORCH:
                              ItemManager.sprCaveTorch.drawPoint(param1,point,((this.offset / 2.3 >> 0) + (width - _loc13_) + _loc12_) % 12);
                              continue;
                           case ItemId.HALLOWEEN_2016_EYES:
                              if(this.player.isFlying)
                              {
                                 ItemManager.sprHalloweenEyes.drawPoint(param1,point,this.lookup.getNumber(_loc13_,_loc12_) * 6);
                              }
                              else if(this.lookup.isBlink(_loc13_,_loc12_))
                              {
                                 if(_loc13_ == _loc8_ || _loc13_ == _loc11_ - 1 || _loc12_ == _loc7_ || _loc12_ == _loc10_ - 1)
                                 {
                                    this.lookup.deleteBlink(_loc13_,_loc12_);
                                    continue;
                                 }
                                 _loc31_ = this.lookup.getBlink(_loc13_,_loc12_);
                                 if(_loc31_ >= 6)
                                 {
                                    _loc31_ = _loc31_ - 6;
                                 }
                                 else
                                 {
                                    _loc31_ = 5 - _loc31_;
                                 }
                                 ItemManager.sprHalloweenEyes.drawPoint(param1,point,_loc31_ + this.lookup.getNumber(_loc13_,_loc12_) * 6);
                                 if(this.lookup.getBlink(_loc13_,_loc12_) != 5 && Math.random() < 0.25 || this.lookup.getBlink(_loc13_,_loc12_) == 5 && Math.random() <= 0.01)
                                 {
                                    if(this.lookup.updateBlink(_loc13_,_loc12_,-1) <= 0)
                                    {
                                       this.lookup.deleteBlink(_loc13_,_loc12_);
                                    }
                                 }
                              }
                              else if(Math.random() < 0.05 && Math.sqrt(Math.pow(_loc13_ * 16 + 8 - this.player.x,2) + Math.pow(_loc12_ * 16 + 8 - this.player.y,2)) < 120)
                              {
                                 this.lookup.setBlink(_loc13_,_loc12_,11);
                              }
                              continue;
                           default:
                              param1.copyPixels(ItemManager.bmdBricks[type],rect18x18,point);
                        }
                        param1.copyPixels(ItemManager.bmdBricks[type],rect18x18,point);
                     }
                  }
               }
            }
            _loc12_++;
         }
         param4 = false;
      }
      
      public final function postDraw(param1:BitmapData, param2:int, param3:int, param4:Boolean = false) : void
      {
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Vector.<int> = null;
         var _loc14_:* = false;
         var _loc5_:int = !!param4?int(height * size):int(Bl.height / size);
         var _loc6_:int = !!param4?int(width * size):int(Bl.width / size);
         var _loc7_:int = -param3 / size - 1;
         var _loc8_:int = -param2 / size - 1;
         if(_loc7_ < 0)
         {
            _loc7_ = 0;
         }
         if(_loc8_ < 0)
         {
            _loc8_ = 0;
         }
         var _loc9_:int = _loc7_ + _loc5_ + 2;
         var _loc10_:int = _loc8_ + _loc6_ + 2;
         if(_loc9_ > height)
         {
            _loc9_ = height;
         }
         if(_loc10_ > width)
         {
            _loc10_ = width;
         }
         _loc11_ = _loc7_;
         while(_loc11_ < _loc9_)
         {
            _loc13_ = above[_loc11_];
            ashift = _loc11_ << 4;
            _loc12_ = _loc8_;
            while(_loc12_ < _loc10_)
            {
               type = _loc13_[_loc12_];
               point.x = (_loc12_ << 4) + param2;
               point.y = ashift + param3;
               switch(type)
               {
                  case 0:
                     break;
                  case 100:
                     ItemManager.sprCoin.drawPoint(param1,point,((this.offset >> 0) + _loc12_ + _loc11_) % 12);
                     break;
                  case 101:
                     ItemManager.sprBonusCoin.drawPoint(param1,point,((this.offset >> 0) + _loc12_ + _loc11_) % 12);
                     break;
                  case ItemId.WAVE:
                     ItemManager.sprWave.drawPoint(param1,point,(this.offset / 5 >> 0) % 8);
                     break;
                  case ItemId.MUD_BUBBLE:
                     if(this.lookup.getNumber(_loc12_,_loc11_) != 0)
                     {
                        this.lookup.setNumber(_loc12_,_loc11_,this.lookup.getNumber(_loc12_,_loc11_) + 0.25);
                        if(this.lookup.getNumber(_loc12_,_loc11_) % 10 == 0)
                        {
                           this.lookup.setNumber(_loc12_,_loc11_,0);
                        }
                     }
                     else if(Math.random() < 0.005)
                     {
                        this.lookup.setNumber(_loc12_,_loc11_,1 + Math.round(Math.random()) * 10);
                     }
                     ItemManager.sprMudBubble.drawPoint(param1,point,(this.lookup.getNumber(_loc12_,_loc11_) >> 0) % 19);
                     break;
                  case ItemId.FIRE:
                     ItemManager.sprFireHazard.drawPoint(param1,point,((this.offset / 1.2 >> 0) + (width - _loc12_) + _loc11_) % 12);
                     break;
                  case ItemId.WATER:
                     if(this.lookup.getInt(_loc12_,_loc11_) != 0)
                     {
                        this.lookup.setInt(_loc12_,_loc11_,this.lookup.getInt(_loc12_,_loc11_) + 1);
                        if(this.lookup.getInt(_loc12_,_loc11_) % 25 == 0)
                        {
                           this.lookup.setInt(_loc12_,_loc11_,0);
                        }
                     }
                     else if(Math.random() < 0.001)
                     {
                        this.lookup.setInt(_loc12_,_loc11_,int(Math.random() * 4) * 25 + 5);
                     }
                     ItemManager.sprWater.drawPoint(param1,point,(this.lookup.getNumber(_loc12_,_loc11_) / 5 >> 0) % 99);
                     break;
                  case ItemId.TEXT_SIGN:
                     _loc14_ = !ItemId.isSolid(getTile(0,_loc12_,_loc11_ + 1));
                     ItemManager.sprSign.drawPoint(param1,point,this.lookup.getTextSign(_loc12_,_loc11_).type + (!!_loc14_?4:0));
                     break;
                  case ItemId.LAVA:
                     ItemManager.sprLava.drawPoint(param1,point,(this.offset / 5 >> 0) % 8);
                     break;
                  default:
                     param1.copyPixels(ItemManager.bmdBricks[type],rect18x18,point);
               }
               _loc12_++;
            }
            _loc11_++;
         }
         this.labelcontainer.draw(param1,param2,param3);
         this.particlecontainer.draw(param1,param2,param3);
         lastframe = param1;
      }
      
      public function drawDialogs(param1:BitmapData, param2:int, param3:int) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Vector.<int> = null;
         var _loc11_:Vector.<int> = null;
         var _loc14_:int = 0;
         var _loc4_:int = -param3 / size - 1;
         var _loc5_:int = -param2 / size - 1;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         var _loc6_:int = _loc4_ + Bl.height / size + 2;
         var _loc7_:int = _loc5_ + Bl.width / size + 2;
         if(_loc6_ > height)
         {
            _loc6_ = height;
         }
         if(_loc7_ > width)
         {
            _loc7_ = width;
         }
         var _loc12_:Point = new Point();
         var _loc13_:Point = new Point();
         _loc8_ = _loc4_;
         while(_loc8_ < _loc6_)
         {
            _loc10_ = decoration[_loc8_];
            _loc11_ = above[_loc8_];
            ashift = _loc8_ << 4;
            _loc9_ = _loc5_;
            for(; _loc9_ < _loc7_; _loc9_++)
            {
               point.x = (_loc9_ << 4) + param2;
               point.y = ashift + param3;
               type = _loc10_[_loc9_];
               switch(type)
               {
                  case ItemId.WORLD_PORTAL:
                     _loc12_.setTo(this.player.x,this.player.y);
                     _loc13_.setTo(_loc9_ * 16,_loc8_ * 16);
                     if(Math.sqrt((_loc13_.x - _loc12_.x) * (_loc13_.x - _loc12_.x) + (_loc13_.y - _loc12_.y) * (_loc13_.y - _loc12_.y)) < 8)
                     {
                        worldportaltext.drawPoint(param1,point);
                     }
                     break;
                  case ItemId.PORTAL:
                  case ItemId.PORTAL_INVISIBLE:
                     _loc12_.setTo(this.player.x,this.player.y);
                     _loc13_.setTo(_loc9_ * 16,_loc8_ * 16);
                     if(Math.sqrt((_loc13_.x - _loc12_.x) * (_loc13_.x - _loc12_.x) + (_loc13_.y - _loc12_.y) * (_loc13_.y - _loc12_.y)) < 8 && (this.player.isFlying && Bl.data.canEdit))
                     {
                        this.textSignBubble.update("ID: " + this.lookup.getPortal(_loc9_,_loc8_).id + "\nTARGET: " + this.lookup.getPortal(_loc9_,_loc8_).target);
                        this.textSignBubble.drawPoint(param1,point);
                     }
                     break;
                  case ItemId.EFFECT_CURSE:
                  case ItemId.EFFECT_ZOMBIE:
                     _loc12_.setTo(this.player.x,this.player.y);
                     _loc13_.setTo(_loc9_ * 16,_loc8_ * 16);
                     if(Math.sqrt((_loc13_.x - _loc12_.x) * (_loc13_.x - _loc12_.x) + (_loc13_.y - _loc12_.y) * (_loc13_.y - _loc12_.y)) < 8 && (this.player.isFlying && Bl.data.canEdit))
                     {
                        _loc14_ = this.lookup.getInt(_loc9_,_loc8_);
                        if(_loc14_ == 0)
                        {
                           break;
                        }
                        this.textSignBubble.update("Duration: " + _loc14_);
                        this.textSignBubble.drawPoint(param1,point);
                     }
               }
               type = _loc11_[_loc9_];
               switch(type)
               {
                  case ItemId.TEXT_SIGN:
                     _loc12_.setTo(this.player.x,this.player.y);
                     _loc13_.setTo(_loc9_ * 16,_loc8_ * 16);
                     if(Math.sqrt((_loc13_.x - _loc12_.x) * (_loc13_.x - _loc12_.x) + (_loc13_.y - _loc12_.y) * (_loc13_.y - _loc12_.y)) < 8)
                     {
                        this.textSignBubble.update(this.lookup.getTextSign(_loc9_,_loc8_).text,this.lookup.getTextSign(_loc9_,_loc8_).type);
                        this.textSignBubble.drawPoint(param1,point);
                     }
                     break;
                  case ItemId.RESET_POINT:
                     _loc12_.setTo(this.player.x,this.player.y);
                     _loc13_.setTo(_loc9_ * 16,_loc8_ * 16);
                     if(Math.sqrt((_loc13_.x - _loc12_.x) * (_loc13_.x - _loc12_.x) + (_loc13_.y - _loc12_.y) * (_loc13_.y - _loc12_.y)) < 8)
                     {
                        resetPopup.drawPoint(param1,point);
                     }
               }
               if(Global.getPlacer)
               {
                  _loc12_.setTo(Bl.mouseX - param2 - 16,Bl.mouseY - param3 - 16);
                  _loc13_.setTo(_loc9_ * 16,_loc8_ * 16);
                  if(_loc13_.x - _loc12_.x > 0 && _loc13_.x - _loc12_.x < 16 && _loc13_.y - _loc12_.y > 0 && _loc13_.y - _loc12_.y < 16)
                  {
                     this.inspectTool.updateForBlockAt(_loc9_,_loc8_);
                     this.inspectTool.drawPoint(param1,point);
                     continue;
                  }
                  continue;
               }
            }
            _loc8_++;
         }
      }
      
      public function addParticle(param1:Particle) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<BlObject> = null;
         var _loc5_:int = 0;
         if(Global.cookie.data.particlesEnabled)
         {
            this.particlecontainer.add(param1);
            _loc2_ = this.particlecontainer.children.length;
            if(_loc2_ > Config.max_Particles)
            {
               _loc3_ = _loc2_ - Config.max_Particles;
               _loc4_ = this.particlecontainer.children.splice(this.particlecontainer.children.length - _loc3_,_loc3_);
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length)
               {
                  this.particlecontainer.remove(_loc4_[_loc5_]);
                  _loc5_++;
               }
            }
         }
      }
      
      public function reset() : void
      {
         bmd.dispose();
         realmap = null;
         background = null;
         decoration = null;
         forground = null;
         above = null;
      }
      
      public function removeAllLabels() : void
      {
         this.labelcontainer.removeAll();
      }
   }
}
