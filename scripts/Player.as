package
{
   import blitter.Bl;
   import flash.display.BitmapData;
   import playerio.Connection;
   import states.PlayState;
   import com.reygazu.anticheat.variables.SecureNumber;
   import com.reygazu.anticheat.variables.SecureInt;
   import com.reygazu.anticheat.variables.SecureBoolean;
   import flash.geom.Rectangle;
   import items.ItemAura;
   import items.ItemManager;
   import blitter.BlSprite;
   import flash.geom.Point;
   import items.ItemId;
   import sounds.SoundManager;
   import sounds.SoundId;
   import animations.AnimationManager;
   
   public class Player extends SynchronizedSprite
   {
       
      
      protected var Crown:Class;
      
      protected var CrownSilver:Class;
      
      protected var Aura:Class;
      
      protected var AdminAura:Class;
      
      protected var ModAura:Class;
      
      protected var FireAura:Class;
      
      protected var LevitationEffect:Class;
      
      protected var EffectIcons:Class;
      
      private var _id:int;
      
      private var world:World;
      
      public var isme:Boolean;
      
      private var crown:BitmapData;
      
      private var crown_silver:BitmapData;
      
      private var auraBitmapData:BitmapData;
      
      private var adminAuraBMD:BitmapData;
      
      private var modAuraBMD:BitmapData;
      
      private var fireAura:BitmapData;
      
      private var levitationAnimationBitmapData:BitmapData;
      
      private var effectIconsBitmapData:BitmapData;
      
      private var goldmemberaura:BitmapData;
      
      private var connection:Connection;
      
      private var state:PlayState;
      
      private var chat:Chat;
      
      private var deadAnim:BitmapData;
      
      public var isDead:Boolean = false;
      
      private var deathsend:Boolean = false;
      
      private var worldportalsend:Boolean = false;
      
      private var resetSend:Boolean;
      
      public var name:String;
      
      private var textcolor:uint;
      
      private var morx:int = 0;
      
      private var mory:int = 0;
      
      public var overlapa:int = -1;
      
      public var overlapb:int = -1;
      
      public var overlapc:int = -1;
      
      public var overlapd:int = -1;
      
      public var hascrown:Boolean = false;
      
      public var collideWithCrownDoorGate:Boolean = false;
      
      public var hascrownsilver:Boolean = false;
      
      private var _posX:SecureNumber;
      
      private var _posY:SecureNumber;
      
      private var _coins:SecureInt;
      
      private var _bcoins:SecureInt;
      
      private var _inGodMode:SecureBoolean;
      
      private var _inAdminMode:SecureBoolean;
      
      private var _inModMode:SecureBoolean;
      
      public var isgoldmember:Boolean = false;
      
      public var current:int = 0;
      
      public var current_bg:int = 0;
      
      public var current_below:int = 0;
      
      public var checkpoint_x:int = -1;
      
      public var checkpoint_y:int = -1;
      
      public var switches:Object;
      
      private var last_respawn:Number = 0;
      
      private var rect2:Rectangle;
      
      private var itemAura:ItemAura;
      
      private var _aura:int = 0;
      
      private var _auraColor:int = 0;
      
      private var fireAnimation:BlSprite;
      
      private var levitationAnimation:BlSprite;
      
      private var effectIcons:BlSprite;
      
      private var _isFlaunting:Boolean = false;
      
      private var tilequeue:Array;
      
      private var _deaths:SecureInt;
      
      public var team:int = 0;
      
      public var muted:Boolean;
      
      public var canEdit:Boolean;
      
      public var badge:String;
      
      public var isCrewMember:Boolean;
      
      private var _canToggleGod:Boolean;
      
      private var total:Number = 0;
      
      private var pastx:int = 0;
      
      private var pasty:int = 0;
      
      private var queue:Vector.<int>;
      
      private var lastJump:Number;
      
      private var changed:Boolean = false;
      
      private var tx:int = -1;
      
      private var ty:int = -1;
      
      private var leftdown:int = 0;
      
      private var rightdown:int = 0;
      
      private var updown:int = 0;
      
      private var downdown:int = 0;
      
      public var spacedown:Boolean = false;
      
      public var spacejustdown:Boolean = false;
      
      public var horizontal:int = 0;
      
      public var vertical:int = 0;
      
      public var oh:int = 0;
      
      public var ov:int = 0;
      
      public var ox:Number = 0;
      
      public var oy:Number = 0;
      
      public var ospacedown:Boolean = false;
      
      public var ospaceJP:Boolean = false;
      
      public var TickID:int = 0;
      
      public var worldGravityMultiplier:Number = 1;
      
      private var lastPortal:Point;
      
      private var lastOverlap:int = 0;
      
      private var that:SynchronizedObject;
      
      private var bbest:Number = 0;
      
      private var donex:Boolean = false;
      
      private var doney:Boolean = false;
      
      private var animoffset:Number = 0;
      
      private var modoffset:Number = 0;
      
      private var modrect:Rectangle;
      
      private var auraAnimOffset:Number = 0;
      
      private var clubrect:Rectangle;
      
      private var deadoffset:Number = 0;
      
      public var low_gravity:Boolean = false;
      
      private var _isInvulnerable:SecureBoolean;
      
      private var _hasLevitation:SecureBoolean;
      
      private var _jumpBoost:SecureBoolean;
      
      private var _speedBoost:SecureBoolean;
      
      private var _zombie:SecureBoolean;
      
      private var _cursed:SecureBoolean;
      
      private var _isThrusting:SecureBoolean;
      
      private var _maxThrust:Number = 0.2;
      
      private var _thrustBurnOff:Number = 0.01;
      
      private var _currentThrust:Number = 0;
      
      private var isOnFire:Boolean = false;
      
      private var slippery:Number = 0;
      
      private var jumpCount:int = 0;
      
      private var maxJumps:int = 1;
      
      private var starty:Number = 0;
      
      private var startx:Number = 0;
      
      private var endy:Number = 0;
      
      private var endx:Number = 0;
      
      public function Player(param1:World, param2:String, param3:Boolean = false, param4:Connection = null, param5:PlayState = null)
      {
         this.Crown = Player_Crown;
         this.CrownSilver = Player_CrownSilver;
         this.Aura = Player_Aura;
         this.AdminAura = Player_AdminAura;
         this.ModAura = Player_ModAura;
         this.FireAura = Player_FireAura;
         this.LevitationEffect = Player_LevitationEffect;
         this.EffectIcons = Player_EffectIcons;
         this.crown = new this.Crown().bitmapData;
         this.crown_silver = new this.CrownSilver().bitmapData;
         this.auraBitmapData = new this.Aura().bitmapData;
         this.adminAuraBMD = new this.AdminAura().bitmapData;
         this.modAuraBMD = new this.ModAura().bitmapData;
         this.fireAura = new this.FireAura().bitmapData;
         this.levitationAnimationBitmapData = new this.LevitationEffect().bitmapData;
         this.effectIconsBitmapData = new this.EffectIcons().bitmapData;
         this.goldmemberaura = AnimationManager.animGoldMemberAura;
         this._posX = new SecureNumber("PosX");
         this._posY = new SecureNumber("PosY");
         this._coins = new SecureInt("Coins");
         this._bcoins = new SecureInt("BlueCoins");
         this._inGodMode = new SecureBoolean("GodMode");
         this._inAdminMode = new SecureBoolean("AdminMode");
         this._inModMode = new SecureBoolean("ModeratorMode");
         this.switches = {};
         this.rect2 = new Rectangle(0,0,26,26);
         this.fireAnimation = new BlSprite(this.fireAura,0,0,26,26,6);
         this.levitationAnimation = new BlSprite(this.levitationAnimationBitmapData,0,0,26,26,32);
         this.effectIcons = new BlSprite(this.effectIconsBitmapData,0,0,16,16,this.effectIconsBitmapData.width / 16);
         this._deaths = new SecureInt("Deaths");
         this.queue = new Vector.<int>(Config.physics_queue_length);
         this.lastJump = -new Date().time;
         this.lastPortal = new Point();
         this.that = this as SynchronizedObject;
         this.modrect = new Rectangle(0,0,64,64);
         this.clubrect = new Rectangle(0,0,64,64);
         this._isInvulnerable = new SecureBoolean("Protection");
         this._hasLevitation = new SecureBoolean("Levitation");
         this._jumpBoost = new SecureBoolean("JumpBoost");
         this._speedBoost = new SecureBoolean("SpeedBoost");
         this._zombie = new SecureBoolean("Zombie");
         this._cursed = new SecureBoolean("Curse");
         this._isThrusting = new SecureBoolean("IsThrusting");
         super(ItemManager.smiliesBMD);
         this.state = param5;
         this.connection = param4;
         this.world = param1;
         this.hitmap = param1;
         this.tilequeue = [];
         this.x = 16;
         this.y = 16;
         this.isme = param3;
         this.name = param2;
         this.chat = new Chat(param2.indexOf(" ") != -1?"":param2);
         size = 16;
         width = 16;
         height = 16;
         this.itemAura = ItemManager.getAuraByIdAndColor(0,0);
      }
      
      public static function isAdmin(param1:String) : Boolean
      {
         return Bl.StaffObject != null && Bl.StaffObject.hasOwnProperty(param1) && Bl.StaffObject[param1] == "Admin";
      }
      
      public static function isModerator(param1:String) : Boolean
      {
         return Bl.StaffObject != null && Bl.StaffObject.hasOwnProperty(param1) && Bl.StaffObject[param1] == "Mod";
      }
      
      public static function isDev(param1:String) : Boolean
      {
         return Bl.StaffObject != null && Bl.StaffObject.hasOwnProperty(param1) && Bl.StaffObject[param1] == "Dev";
      }
      
      public static function getNameColor(param1:String) : uint
      {
         return !!isAdmin(param1)?uint(Config.admin_color):!!isModerator(param1)?uint(Config.moderator_color):uint(Config.default_color);
      }
      
      public static function getProfileColor(param1:String) : uint
      {
         return !!isAdmin(param1)?uint(Config.admin_color):!!isModerator(param1)?uint(Config.moderator_color):!!isDev(param1)?uint(Config.dev_color):uint(Config.default_color);
      }
      
      override public function get x() : Number
      {
         return this._posX.value;
      }
      
      override public function set x(param1:Number) : void
      {
         this._posX.value = param1;
      }
      
      override public function get y() : Number
      {
         return this._posY.value;
      }
      
      override public function set y(param1:Number) : void
      {
         this._posY.value = param1;
      }
      
      public function set coins(param1:int) : void
      {
         this._coins.value = param1;
      }
      
      public function get coins() : int
      {
         return this._coins.value;
      }
      
      public function set bcoins(param1:int) : void
      {
         this._bcoins.value = param1;
      }
      
      public function get bcoins() : int
      {
         return this._bcoins.value;
      }
      
      public function set isInGodMode(param1:Boolean) : void
      {
         this._inGodMode.value = param1;
      }
      
      public function get isInGodMode() : Boolean
      {
         return this._inGodMode.value;
      }
      
      public function set isInAdminMode(param1:Boolean) : void
      {
         this._inAdminMode.value = param1;
      }
      
      public function get isInAdminMode() : Boolean
      {
         return this._inAdminMode.value;
      }
      
      public function set isInModeratorMode(param1:Boolean) : void
      {
         this._inModMode.value = param1;
      }
      
      public function get isInModeratorMode() : Boolean
      {
         return this._inModMode.value;
      }
      
      public function set aura(param1:int) : void
      {
         this._aura = param1;
         this.itemAura = ItemManager.getAuraByIdAndColor(this.aura,this.auraColor);
      }
      
      public function get aura() : int
      {
         return this._aura;
      }
      
      public function set auraColor(param1:int) : void
      {
         this._auraColor = param1;
         this.itemAura = ItemManager.getAuraByIdAndColor(this.aura,this.auraColor);
      }
      
      public function get auraColor() : int
      {
         return this._auraColor;
      }
      
      public function set deaths(param1:int) : void
      {
         this._deaths.value = param1;
      }
      
      public function get deaths() : int
      {
         return this._deaths.value;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get gravityMultiplier() : Number
      {
         var _loc1_:Number = 1;
         if(this.low_gravity)
         {
            _loc1_ = _loc1_ * 0.15;
         }
         else
         {
            _loc1_ = _loc1_ * this.worldGravityMultiplier;
         }
         return _loc1_;
      }
      
      public function get jumpMultiplier() : Number
      {
         var _loc1_:Number = 1;
         if(this.jumpBoost)
         {
            _loc1_ = _loc1_ * 1.3;
         }
         if(this.zombie)
         {
            _loc1_ = _loc1_ * 0.75;
         }
         if(this.slippery > 0)
         {
            _loc1_ = _loc1_ * 0.88;
         }
         return _loc1_;
      }
      
      public function get speedMultiplier() : Number
      {
         var _loc1_:Number = 1;
         if(this.zombie)
         {
            _loc1_ = _loc1_ * 0.6;
         }
         if(this.speedBoost)
         {
            _loc1_ = _loc1_ * 1.5;
         }
         return _loc1_;
      }
      
      public function get dragMud() : Number
      {
         return _mud_drag;
      }
      
      override public function tick() : void
      {
         var cx:int = 0;
         var cy:int = 0;
         var isgodmod:Boolean = false;
         var reminderX:Number = NaN;
         var currentSX:Number = NaN;
         var reminderY:Number = NaN;
         var currentSY:Number = NaN;
         var osx:Number = NaN;
         var osy:Number = NaN;
         var rot:int = 0;
         var mod:int = 0;
         var injump:Boolean = false;
         var skipJumpX:Boolean = false;
         var skipJumpY:Boolean = false;
         var cchanged:Boolean = false;
         var k:int = 0;
         var l:int = 0;
         var sid:int = 0;
         var enablePurpleSwitch:Boolean = false;
         var newJumpBoost:Boolean = false;
         var newLevitation:Boolean = false;
         var newSpeed:Boolean = false;
         var newLowGravity:Boolean = false;
         var newInv:Boolean = false;
         var newCurse:Boolean = false;
         var newZombie:Boolean = false;
         var jps:int = 0;
         var osid:int = 0;
         var enableOrangeSwitch:Boolean = false;
         var tx:Number = NaN;
         var ty:Number = NaN;
         var stepx:Function = function():void
         {
            if(currentSX > 0)
            {
               if(currentSX + reminderX >= 1)
               {
                  x = x + (1 - reminderX);
                  x = x >> 0;
                  currentSX = currentSX - (1 - reminderX);
                  reminderX = 0;
               }
               else
               {
                  x = x + currentSX;
                  currentSX = 0;
               }
            }
            else if(currentSX < 0)
            {
               if(reminderX + currentSX < 0 && (reminderX != 0 || ItemId.isBoost(current)))
               {
                  currentSX = currentSX + reminderX;
                  x = x - reminderX;
                  x = x >> 0;
                  reminderX = 1;
               }
               else
               {
                  x = x + currentSX;
                  currentSX = 0;
               }
            }
            if(hitmap != null)
            {
               if(hitmap.overlaps(that))
               {
                  x = ox;
                  if(_speedX > 0 && morx > 0)
                  {
                     grounded = true;
                  }
                  if(_speedX < 0 && morx < 0)
                  {
                     grounded = true;
                  }
                  _speedX = 0;
                  currentSX = osx;
                  donex = true;
               }
            }
         };
         var stepy:Function = function():void
         {
            if(currentSY > 0)
            {
               if(currentSY + reminderY >= 1)
               {
                  y = y + (1 - reminderY);
                  y = y >> 0;
                  currentSY = currentSY - (1 - reminderY);
                  reminderY = 0;
               }
               else
               {
                  y = y + currentSY;
                  currentSY = 0;
               }
            }
            else if(currentSY < 0)
            {
               if(reminderY + currentSY < 0 && (reminderY != 0 || ItemId.isBoost(current)))
               {
                  y = y - reminderY;
                  y = y >> 0;
                  currentSY = currentSY + reminderY;
                  reminderY = 1;
               }
               else
               {
                  y = y + currentSY;
                  currentSY = 0;
               }
            }
            if(hitmap != null)
            {
               if(hitmap.overlaps(that))
               {
                  y = oy;
                  if(_speedY > 0 && mory > 0)
                  {
                     grounded = true;
                  }
                  if(_speedY < 0 && mory < 0)
                  {
                     grounded = true;
                  }
                  _speedY = 0;
                  currentSY = osy;
                  doney = true;
               }
            }
         };
         var randomRange:Function = function(param1:Number, param2:Number):Number
         {
            return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
         };
         var processPortals:Function = function():void
         {
            var _loc1_:String = null;
            var _loc2_:NavigationEvent = null;
            var _loc3_:Vector.<Point> = null;
            var _loc4_:Point = null;
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:Number = NaN;
            var _loc8_:Number = NaN;
            var _loc9_:Number = NaN;
            var _loc10_:Number = NaN;
            var _loc11_:int = 0;
            var _loc12_:Number = NaN;
            var _loc13_:int = 0;
            var _loc14_:Number = NaN;
            current = world.getTile(0,cx,cy);
            if(!isgodmod && current == ItemId.WORLD_PORTAL)
            {
               if(Bl.isKeyDown(89) && !worldportalsend)
               {
                  _loc1_ = world.lookup.getText(cx,cy);
                  if(_loc1_.length > 0)
                  {
                     worldportalsend = true;
                     if(connection.connected)
                     {
                        connection.disconnect();
                     }
                     _loc2_ = new NavigationEvent(NavigationEvent.JOIN_WORLD,true,false);
                     _loc2_.world_id = _loc1_;
                     Global.base.dispatchEvent(_loc2_);
                  }
               }
            }
            if(!isgodmod && (current == ItemId.PORTAL || current == ItemId.PORTAL_INVISIBLE) && world.lookup.getPortal(cx,cy).target != world.lookup.getPortal(cx,cy).id)
            {
               if(lastPortal == null)
               {
                  lastPortal = new Point(cx << 4,cy << 4);
                  _loc3_ = world.lookup.getPortals(world.lookup.getPortal(cx,cy).target);
                  if(_loc3_.length > 0)
                  {
                     _loc4_ = _loc3_[randomRange(0,_loc3_.length - 1)];
                     _loc5_ = world.lookup.getPortal(lastPortal.x >> 4,lastPortal.y >> 4).rotation;
                     _loc6_ = world.lookup.getPortal(_loc4_.x >> 4,_loc4_.y >> 4).rotation;
                     if(_loc5_ < _loc6_)
                     {
                        _loc5_ = _loc5_ + 4;
                     }
                     _loc7_ = speedX;
                     _loc8_ = speedY;
                     _loc9_ = modifierX;
                     _loc10_ = modifierY;
                     _loc11_ = _loc5_ - _loc6_;
                     _loc12_ = 1.42;
                     switch(_loc11_)
                     {
                        case 1:
                           speedX = _loc8_ * _loc12_;
                           speedY = -_loc7_ * _loc12_;
                           modifierX = _loc10_ * _loc12_;
                           modifierY = -_loc9_ * _loc12_;
                           reminderY = -reminderX;
                           currentSY = -currentSX;
                           break;
                        case 3:
                           speedX = -_loc8_ * _loc12_;
                           speedY = _loc7_ * _loc12_;
                           modifierX = -_loc10_ * _loc12_;
                           modifierY = _loc9_ * _loc12_;
                           reminderX = -reminderY;
                           currentSX = -currentSY;
                           break;
                        case 2:
                           speedX = -_loc7_ * _loc12_;
                           speedY = -_loc8_ * _loc12_;
                           modifierX = -_loc9_ * _loc12_;
                           modifierY = -_loc10_ * _loc12_;
                           reminderY = -reminderY;
                           currentSY = -currentSY;
                           reminderX = -reminderX;
                           currentSX = -currentSX;
                     }
                     if(isme && state && !state.isPlayerSpectating)
                     {
                        state.offset(x - _loc4_.x,y - _loc4_.y);
                     }
                     if(Global.cookie.data.particlesEnabled)
                     {
                        if(current == ItemId.PORTAL && isme)
                        {
                           _loc13_ = 0;
                           while(_loc13_ < 25)
                           {
                              _loc14_ = (Math.random() + 1) / 2;
                              world.addParticle(new Particle(world,Math.random() * 100 < 50?5:4,_loc4_.x + 6,_loc4_.y + 6,_loc14_,_loc14_,_loc14_ / 70,_loc14_ / 70,Math.random() * 360,Math.random() * 90,false));
                              _loc13_++;
                           }
                        }
                     }
                     x = _loc4_.x;
                     y = _loc4_.y;
                     lastPortal = _loc4_;
                  }
               }
            }
            else
            {
               lastPortal = null;
            }
         };
         this.animoffset = this.animoffset + 0.2;
         if((this.isInAdminMode || this.isInModeratorMode) && !this.isInGodMode)
         {
            this.modoffset = this.modoffset + 0.2;
            if(this.modoffset >= 16)
            {
               this.modoffset = 10;
            }
         }
         else
         {
            this.modoffset = 0;
         }
         this.auraAnimOffset = this.auraAnimOffset + this.itemAura.speed;
         if(this.auraAnimOffset >= this.itemAura.frames)
         {
            this.auraAnimOffset = 0;
         }
         if(this.isDead)
         {
            this.deadoffset = this.deadoffset + 0.3;
         }
         else
         {
            this.deadoffset = 0;
         }
         cx = this.x + 8 >> 4;
         cy = this.y + 8 >> 4;
         var delayed:int = this.queue.shift();
         this.current = this.world.getTile(0,cx,cy);
         if(ItemId.isHalfBlock(this.current))
         {
            rot = (hitmap as World).lookup.getInt(cx,cy);
            if(rot == 1)
            {
               cy--;
            }
            if(rot == 0)
            {
               cx--;
            }
            this.current = this.world.getTile(0,cx,cy);
         }
         if(this.tx != -1)
         {
            this.UpdateTeamDoors(this.tx,this.ty);
         }
         this.current_below = 0;
         if(this.current == 1 || this.current == 411)
         {
            this.current_below = this.world.getTile(0,cx - 1,cy);
         }
         else if(this.current == 2 || this.current == 412)
         {
            this.current_below = this.world.getTile(0,cx,cy - 1);
         }
         else if(this.current == 3 || this.current == 413)
         {
            this.current_below = this.world.getTile(0,cx + 1,cy);
         }
         else
         {
            this.current_below = this.world.getTile(0,cx,cy + 1);
         }
         this.queue.push(this.current);
         if(this.current == 4 || this.current == 414 || ItemId.isClimbable(this.current))
         {
            delayed = this.queue.shift();
            this.queue.push(this.current);
         }
         var queue_length:int = this.tilequeue.length;
         while(queue_length--)
         {
            this.tilequeue.shift()();
         }
         if(this.isme)
         {
            this.rightdown = Bl.isKeyDown(39) || Bl.isKeyDown(68)?1:0;
            this.downdown = Bl.isKeyDown(40) || Bl.isKeyDown(83)?1:0;
            if(Global.cookie.data.azertyEnabled)
            {
               this.leftdown = Bl.isKeyDown(37) || Bl.isKeyDown(81)?-1:0;
               this.updown = Bl.isKeyDown(38) || Bl.isKeyDown(90)?-1:0;
            }
            else
            {
               this.leftdown = Bl.isKeyDown(37) || Bl.isKeyDown(65)?-1:0;
               this.updown = Bl.isKeyDown(38) || Bl.isKeyDown(87)?-1:0;
            }
            this.spacejustdown = Bl.isKeyJustPressed(32);
            this.spacedown = Bl.isKeyDown(32);
            this.horizontal = this.leftdown + this.rightdown;
            this.vertical = this.updown + this.downdown;
            Bl.resetJustPressed();
         }
         if(this.isDead)
         {
            this.horizontal = 0;
            this.vertical = 0;
            this.spacejustdown = false;
            this.spacedown = false;
         }
         isgodmod = this.isFlying;
         if(isgodmod)
         {
            this.morx = 0;
            this.mory = 0;
            this.mox = 0;
            this.moy = 0;
         }
         else
         {
            if(ItemId.isClimbable(this.current))
            {
               this.morx = 0;
               this.mory = 0;
            }
            else
            {
               switch(this.current)
               {
                  case 1:
                  case 411:
                     this.morx = -_gravity;
                     this.mory = 0;
                     break;
                  case 2:
                  case 412:
                     this.morx = 0;
                     this.mory = -_gravity;
                     break;
                  case 3:
                  case 413:
                     this.morx = _gravity;
                     this.mory = 0;
                     break;
                  case ItemId.SPEED_LEFT:
                  case ItemId.SPEED_RIGHT:
                  case ItemId.SPEED_UP:
                  case ItemId.SPEED_DOWN:
                  case 4:
                  case 414:
                     this.morx = 0;
                     this.mory = 0;
                     break;
                  case ItemId.WATER:
                     this.morx = 0;
                     this.mory = _water_buoyancy;
                     break;
                  case ItemId.MUD:
                     this.morx = 0;
                     this.mory = _mud_buoyancy;
                     break;
                  case ItemId.LAVA:
                     this.morx = 0;
                     this.mory = _lava_buoyancy;
                     break;
                  case ItemId.FIRE:
                  case ItemId.SPIKE:
                     this.morx = 0;
                     this.mory = _gravity;
                     if(!this.isDead && !this.isInvulnerable)
                     {
                        this.killPlayer();
                     }
                     break;
                  case ItemId.EFFECT_PROTECTION:
                     this.morx = 0;
                     this.mory = _gravity;
                     break;
                  default:
                     this.morx = 0;
                     this.mory = _gravity;
               }
            }
            if(ItemId.isClimbable(delayed))
            {
               this.mox = 0;
               this.moy = 0;
            }
            else
            {
               switch(delayed)
               {
                  case 1:
                  case 411:
                     this.mox = -_gravity;
                     this.moy = 0;
                     break;
                  case 2:
                  case 412:
                     this.mox = 0;
                     this.moy = -_gravity;
                     break;
                  case 3:
                  case 413:
                     this.mox = _gravity;
                     this.moy = 0;
                     break;
                  case ItemId.SPEED_LEFT:
                  case ItemId.SPEED_RIGHT:
                  case ItemId.SPEED_UP:
                  case ItemId.SPEED_DOWN:
                  case 4:
                  case 414:
                     this.mox = 0;
                     this.moy = 0;
                     break;
                  case ItemId.WATER:
                     this.mox = 0;
                     this.moy = _water_buoyancy;
                     break;
                  case ItemId.MUD:
                     this.mox = 0;
                     this.moy = _mud_buoyancy;
                     break;
                  case ItemId.LAVA:
                     this.mox = 0;
                     this.moy = _lava_buoyancy;
                     break;
                  default:
                     this.mox = 0;
                     this.moy = _gravity;
               }
            }
         }
         if(this.moy == _water_buoyancy || this.moy == _mud_buoyancy || this.moy == _lava_buoyancy)
         {
            mx = this.horizontal;
            my = this.vertical;
         }
         else if(this.moy)
         {
            mx = this.horizontal;
            my = 0;
         }
         else if(this.mox)
         {
            mx = 0;
            my = this.vertical;
         }
         else
         {
            mx = this.horizontal;
            my = this.vertical;
         }
         mx = mx * this.speedMultiplier;
         my = my * this.speedMultiplier;
         mox = mox * this.gravityMultiplier;
         moy = moy * this.gravityMultiplier;
         this.modifierX = this.mox + mx;
         this.modifierY = this.moy + my;
         if(ItemId.isSlippery(this.current_below) && !ItemId.isClimbable(this.current) && this.current != 4 && this.current != 414)
         {
            this.slippery = 2;
         }
         else if(ItemId.isSolid(this.current_below))
         {
            this.slippery = 0;
         }
         else if(this.slippery > 0)
         {
            this.slippery = this.slippery - 0.2;
         }
         if(_speedX || _modifierX)
         {
            _speedX = _speedX + _modifierX;
            if((mx == 0 && moy != 0 || _speedX < 0 && mx > 0 || _speedX > 0 && mx < 0) && (this.slippery <= 0 || isgodmod) || ItemId.isClimbable(this.current) && !isgodmod)
            {
               _speedX = _speedX * Config.physics_base_drag;
               _speedX = _speedX * _no_modifier_dragX;
            }
            else if(this.current == ItemId.WATER && !isgodmod)
            {
               _speedX = _speedX * Config.physics_base_drag;
               _speedX = _speedX * _water_drag;
            }
            else if(this.current == ItemId.MUD && !isgodmod)
            {
               _speedX = _speedX * Config.physics_base_drag;
               _speedX = _speedX * this.dragMud;
            }
            else if(this.current == ItemId.LAVA && !isgodmod)
            {
               _speedX = _speedX * Config.physics_base_drag;
               _speedX = _speedX * _lava_drag;
            }
            else if(this.slippery > 0 && !isgodmod)
            {
               if(mx != 0 && !(_speedX < 0 && mx > 0 || _speedX > 0 && mx < 0))
               {
                  _speedX = _speedX * Config.physics_base_drag;
               }
               else
               {
                  _speedX = _speedX * Config.physics_ice_no_mod_drag;
               }
               if(_speedX < 0 && mx > 0 || _speedX > 0 && mx < 0)
               {
                  _speedX = _speedX * Config.physics_ice_drag;
               }
            }
            else
            {
               _speedX = _speedX * Config.physics_base_drag;
            }
            if(_speedX > 16)
            {
               _speedX = 16;
            }
            else if(_speedX < -16)
            {
               _speedX = -16;
            }
            else if(_speedX < 0.0001 && _speedX > -0.0001)
            {
               _speedX = 0;
            }
         }
         if(_speedY || _modifierY)
         {
            _speedY = _speedY + _modifierY;
            if((my == 0 && mox != 0 || _speedY < 0 && my > 0 || _speedY > 0 && my < 0) && (this.slippery <= 0 || isgodmod) || ItemId.isClimbable(this.current) && !isgodmod)
            {
               _speedY = _speedY * Config.physics_base_drag;
               _speedY = _speedY * _no_modifier_dragY;
            }
            else if(this.current == ItemId.WATER && !isgodmod)
            {
               _speedY = _speedY * Config.physics_base_drag;
               _speedY = _speedY * _water_drag;
            }
            else if(this.current == ItemId.MUD && !isgodmod)
            {
               _speedY = _speedY * Config.physics_base_drag;
               _speedY = _speedY * this.dragMud;
            }
            else if(this.current == ItemId.LAVA && !isgodmod)
            {
               _speedY = _speedY * Config.physics_base_drag;
               _speedY = _speedY * _lava_drag;
            }
            else if(this.slippery > 0 && !isgodmod)
            {
               if(my != 0 && !(_speedY < 0 && my > 0 || _speedY > 0 && my < 0))
               {
                  _speedY = _speedY * Config.physics_base_drag;
               }
               else
               {
                  _speedY = _speedY * Config.physics_ice_no_mod_drag;
               }
               if(_speedY < 0 && my > 0 || _speedY > 0 && my < 0)
               {
                  _speedY = _speedY * Config.physics_ice_drag;
               }
            }
            else
            {
               _speedY = _speedY * Config.physics_base_drag;
            }
            if(_speedY > 16)
            {
               _speedY = 16;
            }
            else if(_speedY < -16)
            {
               _speedY = -16;
            }
            else if(_speedY < 0.0001 && _speedY > -0.0001)
            {
               _speedY = 0;
            }
         }
         if(!isgodmod)
         {
            switch(this.current)
            {
               case ItemId.SPEED_LEFT:
                  _speedX = -_boost;
                  break;
               case ItemId.SPEED_RIGHT:
                  _speedX = _boost;
                  break;
               case ItemId.SPEED_UP:
                  _speedY = -_boost;
                  break;
               case ItemId.SPEED_DOWN:
                  _speedY = _boost;
            }
            if(this.isDead)
            {
               _speedX = 0;
               _speedY = 0;
            }
         }
         reminderX = this.x % 1;
         currentSX = _speedX;
         reminderY = this.y % 1;
         currentSY = _speedY;
         this.donex = false;
         this.doney = false;
         var grounded:Boolean = false;
         while(currentSX != 0 && !this.donex || currentSY != 0 && !this.doney)
         {
            processPortals();
            this.ox = this.x;
            this.oy = this.y;
            osx = currentSX;
            osy = currentSY;
            stepx();
            stepy();
         }
         if(!this.isDead)
         {
            mod = 1;
            injump = false;
            if(this.spacejustdown)
            {
               this.lastJump = -new Date().time;
               injump = true;
               mod = -1;
            }
            if(this.spacedown)
            {
               if(this.hasLevitation)
               {
                  this.isThrusting = true;
                  this.applyThrust();
               }
               else if(this.lastJump < 0)
               {
                  if(new Date().time + this.lastJump > 750)
                  {
                     injump = true;
                  }
               }
               else if(new Date().time - this.lastJump > 150)
               {
                  injump = true;
               }
            }
            else
            {
               this.isThrusting = false;
            }
            if(injump && !this.hasLevitation)
            {
               if((this.speedX == 0 && grounded && this.maxJumps > 0 || this.jumpCount < this.maxJumps) && this.morx && mox)
               {
                  skipJumpX = false;
                  if(this.jumpCount == 0 && speedX != 0 && !grounded)
                  {
                     if(this.maxJumps == 1)
                     {
                        skipJumpX = true;
                     }
                     else
                     {
                        this.jumpCount = this.jumpCount + 2;
                     }
                  }
                  else
                  {
                     this.jumpCount = this.jumpCount + 1;
                  }
                  if(!skipJumpX)
                  {
                     this.speedX = -this.morx * Config.physics_jump_height * this.jumpMultiplier;
                     this.changed = true;
                     this.lastJump = new Date().time * mod;
                  }
               }
               if((this.speedY == 0 && grounded && this.maxJumps > 0 || this.jumpCount < this.maxJumps) && this.mory && moy)
               {
                  skipJumpY = false;
                  if(this.jumpCount == 0 && speedY != 0 && !grounded)
                  {
                     if(this.maxJumps == 1)
                     {
                        skipJumpY = true;
                     }
                     else
                     {
                        this.jumpCount = this.jumpCount + 2;
                     }
                  }
                  else
                  {
                     this.jumpCount = this.jumpCount + 1;
                  }
                  if(!skipJumpY)
                  {
                     this.speedY = -this.mory * Config.physics_jump_height * this.jumpMultiplier;
                     this.changed = true;
                     this.lastJump = new Date().time * mod;
                  }
               }
            }
            if((this.speedX == 0 && this.morx && mox || this.speedY == 0 && this.mory && moy) && grounded || this.current == ItemId.EFFECT_MULTIJUMP)
            {
               this.jumpCount = 0;
            }
            if(this.isme)
            {
               cchanged = false;
               switch(this.current)
               {
                  case 100:
                     SoundManager.playSound(SoundId.COIN);
                     this.world.setTileComplex(0,cx,cy,110,null);
                     this.coins++;
                     cchanged = true;
                     if(Global.cookie.data.particlesEnabled)
                     {
                        k = 0;
                        while(k < 4)
                        {
                           this.world.addParticle(new Particle(this.world,Math.random() * 100 < 50?Math.random() * 100 < 50?1:2:3,cx * 16 + 6,cy * 16 + 6,Math.random() - Math.random() / 10,Math.random() - Math.random() / 10,0.023,0.023,Math.random() * 360,Math.random() * 90));
                           k++;
                        }
                     }
                     break;
                  case 101:
                     SoundManager.playSound(SoundId.COIN);
                     this.world.setTileComplex(0,cx,cy,111,null);
                     this.bcoins++;
                     cchanged = true;
                     if(Global.cookie.data.particlesEnabled)
                     {
                        l = 0;
                        while(l < 4)
                        {
                           this.world.addParticle(new Particle(this.world,5,cx * 16 + 6,cy * 16 + 6,Math.random() - Math.random() / 10,Math.random() - Math.random() / 10,0.023,0.023,Math.random() * 360,Math.random() * 90));
                           l++;
                        }
                     }
                     break;
                  case ItemId.RESET_POINT:
                     if(!isgodmod && Bl.isKeyDown(89) && !this.resetSend)
                     {
                        this.connection.send("reset",cx,cy);
                        this.resetSend = true;
                     }
               }
               if(this.pastx != cx || this.pasty != cy)
               {
                  switch(this.current)
                  {
                     case ItemId.CROWN:
                        if(!this.hascrown && !isgodmod)
                        {
                           this.connection.send("crown",cx,cy);
                        }
                        break;
                     case 6:
                        if(!isgodmod)
                        {
                           this.connection.send("pressKey",cx,cy,"red");
                           this.state.showRed();
                        }
                        break;
                     case 7:
                        if(!isgodmod)
                        {
                           this.connection.send("pressKey",cx,cy,"green");
                           this.state.showGreen();
                        }
                        break;
                     case 8:
                        if(!isgodmod)
                        {
                           this.connection.send("pressKey",cx,cy,"blue");
                           this.state.showBlue();
                        }
                        break;
                     case 408:
                        if(!isgodmod)
                        {
                           this.connection.send("pressKey",cx,cy,"cyan");
                           this.state.showCyan();
                        }
                        break;
                     case 409:
                        if(!isgodmod)
                        {
                           this.connection.send("pressKey",cx,cy,"magenta");
                           this.state.showMagenta();
                        }
                        break;
                     case 410:
                        if(!isgodmod)
                        {
                           this.connection.send("pressKey",cx,cy,"yellow");
                           this.state.showYellow();
                        }
                        break;
                     case ItemId.SWITCH_PURPLE:
                        if(!isgodmod)
                        {
                           sid = this.world.lookup.getInt(cx,cy);
                           enablePurpleSwitch = !this.switches[sid];
                           this.connection.send("ps",cx,cy,0,sid,enablePurpleSwitch);
                           this.pressPurpleSwitch(sid,enablePurpleSwitch);
                        }
                        break;
                     case 411:
                     case 412:
                     case 413:
                     case 414:
                     case ItemId.SLOW_DOT_INVISIBLE:
                        if(!isgodmod)
                        {
                           this.world.lookup.setBlink(cx,cy,-100);
                        }
                        break;
                     case 77:
                        if(this.pastx != cx || this.pasty != cy)
                        {
                           if(SoundManager.playPianoSound(this.world.lookup.getInt(cx,cy)))
                           {
                              this.world.lookup.setBlink(cx,cy,30);
                           }
                        }
                        break;
                     case 83:
                        if(this.pastx != cx || this.pasty != cy)
                        {
                           if(SoundManager.playDrumSound(this.world.lookup.getInt(cx,cy)))
                           {
                              this.world.lookup.setBlink(cx,cy,30);
                           }
                        }
                        break;
                     case ItemId.DIAMOND:
                        if(!isgodmod)
                        {
                           this.connection.send("diamondtouch",cx,cy);
                           (Global.base.state as PlayState).player.frame = 31;
                        }
                        break;
                     case ItemId.CAKE:
                        if(!isgodmod)
                        {
                           this.connection.send("caketouch",cx,cy);
                        }
                        break;
                     case ItemId.HOLOGRAM:
                        if(!isgodmod)
                        {
                           this.connection.send("hologramtouch",cx,cy);
                           (Global.base.state as PlayState).player.frame = 100;
                        }
                        break;
                     case ItemId.CHECKPOINT:
                        if(!isgodmod)
                        {
                           this.checkpoint_x = cx;
                           this.checkpoint_y = cy;
                           this.connection.send("checkpoint",cx,cy);
                        }
                        break;
                     case ItemId.BRICK_COMPLETE:
                        if(!isgodmod)
                        {
                           this.connection.send("levelcomplete",cx,cy);
                        }
                        break;
                     case ItemId.EFFECT_JUMP:
                        if(!isgodmod)
                        {
                           newJumpBoost = this.world.lookup.getBoolean(cx,cy);
                           if(this.jumpBoost != newJumpBoost)
                           {
                              this.jumpBoost = newJumpBoost;
                              this.connection.send("effect",cx,cy,Config.effectJump);
                           }
                        }
                        break;
                     case ItemId.EFFECT_FLY:
                        if(!isgodmod)
                        {
                           newLevitation = this.world.lookup.getBoolean(cx,cy);
                           if(this.hasLevitation != newLevitation)
                           {
                              this.hasLevitation = newLevitation;
                              this.connection.send("effect",cx,cy,Config.effectFly);
                           }
                        }
                        break;
                     case ItemId.EFFECT_RUN:
                        if(!isgodmod)
                        {
                           newSpeed = this.world.lookup.getBoolean(cx,cy);
                           if(this.speedBoost != newSpeed)
                           {
                              this.speedBoost = newSpeed;
                              this.connection.send("effect",cx,cy,Config.effectRun);
                           }
                        }
                        break;
                     case ItemId.EFFECT_LOW_GRAVITY:
                        if(!isgodmod)
                        {
                           newLowGravity = this.world.lookup.getBoolean(cx,cy);
                           if(this.low_gravity != newLowGravity)
                           {
                              this.low_gravity = newLowGravity;
                              this.connection.send("effect",cx,cy,Config.effectLowGravity);
                           }
                        }
                        break;
                     case ItemId.EFFECT_PROTECTION:
                        if(!isgodmod)
                        {
                           newInv = this.world.lookup.getBoolean(cx,cy);
                           if(this.isInvulnerable != newInv)
                           {
                              this.isInvulnerable = newInv;
                              if(this.isInvulnerable)
                              {
                                 this.cursed = false;
                                 this.zombie = false;
                                 this.isOnFire = false;
                              }
                              this.connection.send("effect",cx,cy,Config.effectProtection);
                           }
                        }
                        break;
                     case ItemId.EFFECT_CURSE:
                        if(!isgodmod && !this.isInvulnerable)
                        {
                           newCurse = this.world.lookup.getInt(cx,cy) > 0;
                           if(this.cursed != newCurse)
                           {
                              this.cursed = newCurse;
                              this.connection.send("effect",cx,cy,Config.effectCurse);
                           }
                        }
                        break;
                     case ItemId.EFFECT_ZOMBIE:
                        if(!isgodmod && !this.isInvulnerable)
                        {
                           newZombie = this.world.lookup.getInt(cx,cy) > 0;
                           if(this.zombie != newZombie)
                           {
                              this.zombie = newZombie;
                              this.connection.send("effect",cx,cy,Config.effectZombie);
                           }
                        }
                        break;
                     case ItemId.EFFECT_TEAM:
                        if(!isgodmod)
                        {
                           this.UpdateTeamDoors(cx,cy);
                        }
                        break;
                     case ItemId.LAVA:
                        if(!isgodmod && !this.isInvulnerable && !this.isOnFire)
                        {
                           this.isOnFire = true;
                           this.connection.send("effect",cx,cy,Config.effectFire);
                        }
                        break;
                     case ItemId.WATER:
                     case ItemId.MUD:
                        if(!isgodmod && this.isOnFire)
                        {
                           this.connection.send("effect",cx,cy,Config.effectFire);
                           this.isOnFire = false;
                        }
                        break;
                     case ItemId.EFFECT_MULTIJUMP:
                        if(!isgodmod)
                        {
                           jps = this.world.lookup.getInt(cx,cy);
                           if(jps != this.maxJumps)
                           {
                              this.maxJumps = jps;
                              this.connection.send("effect",cx,cy,Config.effectMultijump);
                           }
                        }
                        break;
                     case ItemId.SWITCH_ORANGE:
                        if(!isgodmod)
                        {
                           osid = this.world.lookup.getInt(cx,cy);
                           enableOrangeSwitch = !this.world.orangeSwitches[osid];
                           this.connection.send("ps",cx,cy,1,osid,enableOrangeSwitch);
                           this.state.pressOrangeSwitch(osid,enableOrangeSwitch);
                        }
                  }
                  this.pastx = cx;
                  this.pasty = cy;
               }
            }
            if((this.oh != this.horizontal || this.ov != this.vertical || this.ospacedown != this.spacedown || this.ospaceJP != this.spacejustdown) && this.isme)
            {
               if(this.connection.connected && (this.oh != this.horizontal || this.ov != this.vertical || this.ospacedown != this.spacedown || this.ospaceJP != this.spacejustdown && this.spacejustdown))
               {
                  this.connection.send("m",this.x,this.y,this.speedX,this.speedY,this.modifierX,this.modifierY,this.horizontal,this.vertical,this.gravityMultiplier,this.spacedown,this.spacejustdown,this.TickID);
               }
               this.oh = this.horizontal;
               this.ov = this.vertical;
               this.ospacedown = this.spacedown;
               this.ospaceJP = this.spacejustdown;
            }
            this.TickID++;
            this.spacejustdown = false;
            if(cchanged)
            {
               this.connection.send("c",this.coins,this.bcoins,cx,cy,this.TickID);
            }
            this.changed = false;
         }
         if(this.hasLevitation)
         {
            this.updateThrust();
         }
         var imx:int = _speedX << 8;
         var imy:int = _speedY << 8;
         moving = false;
         if(imx != 0 || (this.current == ItemId.WATER || this.current == ItemId.MUD || this.current == ItemId.LAVA) && !isgodmod)
         {
            moving = true;
         }
         else if(_modifierX < 0.1 && _modifierX > -0.1)
         {
            tx = this.x % 16;
            if(tx < 2)
            {
               if(tx < 0.2)
               {
                  this.x = this.x >> 0;
               }
               else
               {
                  this.x = this.x - tx / 15;
               }
            }
            else if(tx > 14)
            {
               if(tx > 15.8)
               {
                  this.x = this.x >> 0;
                  this.x++;
               }
               else
               {
                  this.x = this.x + (tx - 14) / 15;
               }
            }
         }
         if(imy != 0 || (this.current == ItemId.WATER || this.current == ItemId.MUD || this.current == ItemId.LAVA) && !isgodmod)
         {
            moving = true;
         }
         else if(_modifierY < 0.1 && _modifierY > -0.1)
         {
            ty = this.y % 16;
            if(ty < 2)
            {
               if(ty < 0.2)
               {
                  this.y = this.y >> 0;
               }
               else
               {
                  this.y = this.y - ty / 15;
               }
            }
            else if(ty > 14)
            {
               if(ty > 15.8)
               {
                  this.y = this.y >> 0;
                  this.y++;
               }
               else
               {
                  this.y = this.y + (ty - 14) / 15;
               }
            }
         }
      }
      
      override public function update() : void
      {
      }
      
      public function drawChat(param1:BitmapData, param2:Number, param3:Number, param4:Boolean) : void
      {
         if(Global.showUI && (Global.showChatAndNames || Global.chatIsVisible))
         {
            this.chat.drawChat(param1,param2 + this.x,param3 + this.y,param4,Global.cookie.data.hideUsernames,Global.cookie.data.hideChatBubbles,this.team);
         }
      }
      
      public function enterChat() : void
      {
         this.chat.enterFrame();
      }
      
      public function say(param1:String) : void
      {
         this.chat.say(param1);
      }
      
      public function killPlayer() : void
      {
         this.isDead = true;
         this.deadAnim = AnimationManager.animRandomDeath();
      }
      
      public function respawn() : void
      {
         _modifierX = 0;
         _modifierY = 0;
         modifierX = 0;
         modifierY = 0;
         _speedX = 0;
         _speedY = 0;
         speedX = 0;
         speedY = 0;
         this.isDead = false;
         this.deathsend = false;
         this.isOnFire = false;
         this.last_respawn = new Date().time;
         this.resetSend = false;
      }
      
      public function resetDeath() : void
      {
         this.isDead = false;
         this.deathsend = false;
      }
      
      public function resetCoins() : void
      {
         this.coins = 0;
         this.bcoins = 0;
      }
      
      public function resetCheckpoint() : void
      {
         this.checkpoint_x = -1;
         this.checkpoint_y = -1;
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle = null;
         var _loc6_:int = 0;
         if(this.isFlying)
         {
            return;
         }
         if(!this.state)
         {
            return;
         }
         this.starty = -this.state.y - 90;
         this.startx = -this.state.x - 90;
         this.endy = this.starty + Bl.height + 180;
         this.endx = this.startx + Bl.width + 180;
         if(this.x > this.startx && this.y > this.starty && this.x < this.endx && this.y < this.endy || this.state.player == this)
         {
            if(this.isDead)
            {
               if(this.deadoffset > 16)
               {
                  if(this.isme && !this.deathsend)
                  {
                     this.deathsend = true;
                     this.connection.send("death");
                  }
                  return;
               }
               if(this.deadoffset < 2)
               {
                  param1.copyPixels(bmd,this.rect2,new Point(this.x + param2 - 5,this.y + param3 - 5));
               }
               _loc6_ = this.deadoffset;
               param1.copyPixels(this.deadAnim,new Rectangle(_loc6_ * 64,0,64,64),new Point(this.x + param2 - 24,this.y + param3 - 24));
               return;
            }
            _loc4_ = this.rect2.clone();
            _loc4_.x = 26 * 87;
            _loc5_ = this.rect2;
            if(this.zombie)
            {
               _loc5_ = _loc4_;
            }
            param1.copyPixels(bmd,_loc5_,new Point(this.x + param2 - 5,this.y + param3 - 5));
            if(this.hascrown)
            {
               param1.copyPixels(this.crown,this.crown.rect,new Point(this.x + param2 - 5,this.y + param3 - 6));
            }
            else if(this.hascrownsilver)
            {
               param1.copyPixels(this.crown_silver,this.crown_silver.rect,new Point(this.x + param2 - 5,this.y + param3 - 6));
            }
            if(this.isOnFire)
            {
               if((this.animoffset >> 0) % 3 == 0)
               {
                  if(this.fireAnimation.frame < this.fireAnimation.totalFrames - 1)
                  {
                     this.fireAnimation.frame++;
                  }
                  else
                  {
                     this.fireAnimation.frame = 0;
                  }
               }
               this.fireAnimation.draw(param1,this.x + param2 - 4,this.y + param3 - 5);
            }
            if(this.hasLevitation && this.isThrusting)
            {
               this.playLevitationAnimation(param1,param2,param3);
            }
            this.drawTagged(param1,param2,param3);
         }
      }
      
      private function playLevitationAnimation(param1:BitmapData, param2:int, param3:int) : void
      {
         if(this.morx == 0 && this.mory == 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 8;
         var _loc6_:int = -5;
         var _loc7_:int = -5;
         if(this.mory != 0)
         {
            if(this.mory < 0)
            {
               _loc6_ = -21;
               _loc4_ = 8;
            }
            else
            {
               _loc6_ = 12;
               _loc4_ = 0;
            }
         }
         if(this.morx != 0)
         {
            if(this.morx < 0)
            {
               _loc7_ = -24;
               _loc4_ = 16;
            }
            else
            {
               _loc7_ = 14;
               _loc4_ = 24;
            }
         }
         if(this.levitationAnimation.frame < _loc4_ + _loc5_ - 1)
         {
            this.levitationAnimation.frame++;
         }
         else
         {
            this.levitationAnimation.frame = _loc4_;
         }
         this.levitationAnimation.draw(param1,this.x + param2 + _loc7_,this.y + param3 + _loc6_);
      }
      
      public function drawGods(param1:BitmapData, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         if(!this.isFlying)
         {
            return;
         }
         if(this.isInGodMode)
         {
            ItemManager.getAuraByIdAndColor(this.aura,this.auraColor).drawTo(param1,this.x + param2 - 24,this.y + param3 - 24,this.auraAnimOffset);
         }
         else if(this.isInAdminMode || this.isInModeratorMode)
         {
            _loc4_ = this.modoffset;
            this.modrect.x = _loc4_ * 64;
            param1.copyPixels(!!this.isInAdminMode?this.adminAuraBMD:this.modAuraBMD,this.modrect,new Point(this.x + param2 - 24,this.y + param3 - 24));
         }
         param1.copyPixels(bmd,this.rect2,new Point(this.x + param2 - 5,this.y + param3 - 5));
         if(this.hascrown)
         {
            param1.copyPixels(this.crown,this.crown.rect,new Point(this.x + param2 - 5,this.y + param3 - 6));
         }
         else if(this.hascrownsilver)
         {
            param1.copyPixels(this.crown_silver,this.crown_silver.rect,new Point(this.x + param2 - 5,this.y + param3 - 6));
         }
      }
      
      override public function set frame(param1:int) : void
      {
         this.rect2.x = param1 * 26;
      }
      
      override public function get frame() : int
      {
         return this.rect2.x / 26;
      }
      
      public function set wearsGoldSmiley(param1:Boolean) : void
      {
         this.rect2.y = !!param1?Number(26):Number(0);
      }
      
      public function get wearsGoldSmiley() : Boolean
      {
         return this.rect2.y == 26;
      }
      
      public function set nameColor(param1:int) : void
      {
         this.chat.textColor = param1;
      }
      
      public function pressPurpleSwitch(param1:int, param2:Boolean) : void
      {
         var switchId:int = param1;
         var enabled:Boolean = param2;
         this.switches[switchId] = enabled;
         if(this.world.overlaps(this))
         {
            this.switches[switchId] = !enabled;
            this.tilequeue.push(function():void
            {
               pressPurpleSwitch(switchId,enabled);
            });
         }
      }
      
      public function UpdateTeamDoors(param1:int, param2:int) : void
      {
         var _loc3_:int = this.world.lookup.getInt(param1,param2);
         var _loc4_:int = this.team;
         if(this.team != _loc3_)
         {
            this.team = _loc3_;
            if(!hitmap.overlaps(this.that))
            {
               if(this.isme)
               {
                  this.connection.send("team",param1,param2,_loc3_);
               }
               this.tx = -1;
               this.ty = -1;
            }
            else
            {
               this.team = _loc4_;
               this.tx = param1;
               this.ty = param2;
            }
         }
      }
      
      public function get minimapColor() : uint
      {
         var _loc1_:uint = uint(ItemManager.getSmileyById(this.frame).minimapcolor) || uint(16777215);
         if(this.isInAdminMode || this.isInModeratorMode)
         {
            return !!this.isInAdminMode?uint(Config.admin_color):uint(Config.moderator_color);
         }
         if(_loc1_ != 4294967295)
         {
            return _loc1_;
         }
         if(this.isme)
         {
            return !!Global.showGreenOnMinimap?uint(4278255360):uint(4294967295);
         }
         return _loc1_;
      }
      
      private function drawTagged(param1:BitmapData, param2:Number, param3:Number) : void
      {
         var _loc4_:int = -16;
         if(this.isInvulnerable)
         {
            this.effectIcons.frame = 0;
            this.effectIcons.draw(param1,this.x + param2,this.y + param3 + _loc4_);
            _loc4_ = _loc4_ - 12;
         }
         if(this.cursed)
         {
            this.effectIcons.frame = 1;
            this.effectIcons.draw(param1,this.x + param2,this.y + param3 + _loc4_);
            _loc4_ = _loc4_ - 12;
         }
      }
      
      public function get speedBoost() : Boolean
      {
         return this._speedBoost.value;
      }
      
      public function set speedBoost(param1:Boolean) : void
      {
         this._speedBoost.value = param1;
      }
      
      public function get jumpBoost() : Boolean
      {
         return this._jumpBoost.value;
      }
      
      public function set jumpBoost(param1:Boolean) : void
      {
         this._jumpBoost.value = param1;
      }
      
      public function set cursed(param1:Boolean) : void
      {
         this._cursed.value = param1;
      }
      
      public function get cursed() : Boolean
      {
         return this._cursed.value;
      }
      
      public function set zombie(param1:Boolean) : void
      {
         this._zombie.value = param1;
      }
      
      public function get zombie() : Boolean
      {
         if(this.isFlying)
         {
            return false;
         }
         return this._zombie.value;
      }
      
      public function getCanTag() : Boolean
      {
         if(this.isFlying || this.isDead)
         {
            return false;
         }
         return this.cursed || this.isInvulnerable || this.zombie;
      }
      
      public function getCanBeTagged() : Boolean
      {
         if(this.isFlying || this.isDead || this.isInvulnerable)
         {
            return false;
         }
         return new Date().time - this.last_respawn > 1000;
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function setEffect(param1:int, param2:Boolean, param3:int = 0) : void
      {
         switch(param1)
         {
            case Config.effectJump:
               this.jumpBoost = param2;
               break;
            case Config.effectFly:
               this.hasLevitation = param2;
               break;
            case Config.effectRun:
               this.speedBoost = param2;
               break;
            case Config.effectProtection:
               this.isInvulnerable = param2;
               break;
            case Config.effectCurse:
               this.cursed = param2;
               break;
            case Config.effectZombie:
               this.zombie = param2;
               break;
            case Config.effectLowGravity:
               this.low_gravity = param2;
               break;
            case Config.effectFire:
               this.isOnFire = param2;
               break;
            case Config.effectMultijump:
               this.maxJumps = !!param2?int(param3):1;
         }
      }
      
      public function set isInvulnerable(param1:Boolean) : void
      {
         this._isInvulnerable.value = param1;
      }
      
      public function get isInvulnerable() : Boolean
      {
         return this._isInvulnerable.value;
      }
      
      public function get hasLevitation() : Boolean
      {
         return this._hasLevitation.value;
      }
      
      public function set hasLevitation(param1:Boolean) : void
      {
         this._hasLevitation.value = param1;
         if(!param1)
         {
            this._currentThrust = 0;
         }
      }
      
      public function updateThrust() : void
      {
         if(this.mory != 0)
         {
            this.speedY = this.speedY - this._currentThrust * (Config.physics_jump_height / 2) * (this.mory * 0.5);
         }
         if(this.morx != 0)
         {
            this.speedX = this.speedX - this._currentThrust * (Config.physics_jump_height / 2) * (this.morx * 0.5);
         }
         if(!this.isThrusting)
         {
            if(this._currentThrust > 0)
            {
               this._currentThrust = this._currentThrust - this._thrustBurnOff;
            }
            else
            {
               this._currentThrust = 0;
            }
         }
      }
      
      public function get isThrusting() : Boolean
      {
         return this._isThrusting.value;
      }
      
      public function set isThrusting(param1:Boolean) : void
      {
         this._isThrusting.value = param1;
      }
      
      public function applyThrust() : void
      {
         this._currentThrust = this._maxThrust;
      }
      
      public function get isFlying() : Boolean
      {
         return this.isInGodMode || this.isInAdminMode || this.isInModeratorMode;
      }
      
      public function get isFlaunting() : Boolean
      {
         return this._isFlaunting;
      }
      
      public function set isFlaunting(param1:Boolean) : void
      {
         this._isFlaunting = param1;
      }
      
      public function get canToggleGodMode() : Boolean
      {
         return this.canEdit || this._canToggleGod;
      }
      
      public function set canToggleGodMode(param1:Boolean) : void
      {
         this._canToggleGod = param1;
      }
   }
}
