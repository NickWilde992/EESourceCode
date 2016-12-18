package animations
{
   import flash.display.BitmapData;
   import items.ItemManager;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.geom.Matrix;
   import flash.geom.ColorTransform;
   import ui.ingame.DeathStar;
   import flash.display.Sprite;
   
   public class AnimationManager
   {
      
      protected static var deathBM:Class = AnimationManager_deathBM;
      
      private static var death:BitmapData = new deathBM().bitmapData;
      
      public static var favorite:BitmapData;
      
      public static var animFavorite:BitmapData;
      
      public static var like:BitmapData;
      
      public static var animLike:BitmapData;
      
      public static var animGoldMemberAura:BitmapData;
      
      public static var animProtection:BitmapData;
      
      public static var animDeaths:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      public static var stars_yellow:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      public static var particleEffects:Array = [];
       
      
      public function AnimationManager()
      {
         super();
      }
      
      public static function init() : void
      {
         var _loc4_:BitmapData = null;
         favorite = new BitmapData(40,40,true,0);
         favorite.copyPixels(ItemManager.sprFavoriteStar.bmd,new Rectangle(0,0,15,15),new Point(12,12));
         favorite.applyFilter(favorite,favorite.rect,new Point(0,0),new GlowFilter(16773846,0.5,12,12,1,BitmapFilterQuality.LOW));
         animFavorite = createScaledAnimation(favorite,5);
         like = new BitmapData(40,40,true,0);
         like.copyPixels(ItemManager.sprLikeHeart.bmd,new Rectangle(0,0,15,15),new Point(12,12));
         like.applyFilter(like,like.rect,new Point(0,0),new GlowFilter(16773846,0.5,12,12,1,BitmapFilterQuality.LOW));
         animLike = createScaledAnimation(like,5);
         var _loc1_:int = 0;
         while(_loc1_ < ItemManager.allParticles.width / 5)
         {
            particleEffects[_loc1_] = new BitmapData(5,5,true,0);
            particleEffects[_loc1_].copyPixels(ItemManager.allParticles,new Rectangle(5 * _loc1_,0,5,5),new Point(0,0));
            _loc1_++;
         }
         var _loc2_:int = 1;
         while(_loc2_ < 4)
         {
            _loc4_ = new BitmapData(5,5,true,0);
            _loc4_.copyPixels(ItemManager.allParticles,new Rectangle(5 * _loc2_,0,5,5),new Point(0,0));
            stars_yellow.push(_loc4_);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < 20)
         {
            animDeaths.push(createDeathAnim());
            _loc3_++;
         }
      }
      
      public static function createScaledAnimation(param1:BitmapData, param2:int, param3:Number = 1, param4:Number = 0) : BitmapData
      {
         var _loc7_:Matrix = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc5_:BitmapData = new BitmapData(param1.width * param2,param1.height,true,0);
         var _loc6_:int = 0;
         while(_loc6_ < param2)
         {
            _loc7_ = new Matrix();
            _loc8_ = _loc6_ / param2;
            _loc9_ = param3 + _loc8_ * (param4 - param3);
            _loc10_ = (param1.width - _loc9_ * param1.width) / 2;
            _loc7_.scale(_loc9_,_loc9_);
            _loc7_.translate(param1.width * _loc6_ + _loc10_,_loc10_);
            _loc5_.draw(param1,_loc7_,null,null,null,true);
            _loc6_++;
         }
         return _loc5_;
      }
      
      public static function createRotationAnimation(param1:BitmapData, param2:int, param3:int) : BitmapData
      {
         var _loc6_:Matrix = null;
         var _loc7_:Number = NaN;
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height * param2,true,0);
         var _loc5_:int = 0;
         while(_loc5_ < param2)
         {
            _loc6_ = new Matrix();
            _loc7_ = param3 / (param2 - 1) * _loc5_;
            _loc6_.translate(-param1.width / 2,-param1.height / 2);
            _loc6_.rotate(_loc7_ * Math.PI / 180);
            _loc6_.translate(param1.width / 2,param1.height / 2);
            _loc6_.translate(0,param1.height * _loc5_);
            _loc4_.draw(param1,_loc6_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function duplicateFrame(param1:BitmapData, param2:int) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(param1.width * param2,param1.height,true,0);
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc3_.copyPixels(param1,param1.rect,new Point(_loc4_ * param1.width,0));
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function addToEnd(param1:BitmapData, param2:BitmapData) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(param1.width + param2.width,param1.height,true,0);
         _loc3_.copyPixels(param1,param1.rect,new Point());
         _loc3_.copyPixels(param2,param2.rect,new Point(param1.width,0));
         return _loc3_;
      }
      
      public static function colorize(param1:BitmapData, param2:uint) : BitmapData
      {
         var _loc3_:BitmapData = param1.clone();
         var _loc4_:ColorTransform = new ColorTransform();
         _loc4_.color = param2;
         _loc3_.colorTransform(_loc3_.rect,_loc4_);
         return _loc3_;
      }
      
      public static function animRandomDeath() : BitmapData
      {
         var _loc1_:int = animDeaths.length * Math.random();
         return animDeaths[_loc1_];
      }
      
      public static function randomDeathStar() : BitmapData
      {
         var _loc1_:int = stars_yellow.length * Math.random();
         return stars_yellow[_loc1_];
      }
      
      private static function createDeathAnim() : BitmapData
      {
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:DeathStar = null;
         var _loc12_:Number = NaN;
         var _loc13_:DeathStar = null;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc1_:int = 16;
         var _loc2_:int = 6;
         var _loc3_:BitmapData = new BitmapData(_loc1_ * 128,128,true,0);
         _loc3_.copyPixels(death,death.rect,new Point(0,0));
         var _loc4_:Sprite = new Sprite();
         var _loc5_:int = 2;
         while(_loc5_ < 4)
         {
            _loc9_ = _loc5_ / 2;
            _loc10_ = 0;
            while(_loc10_ < _loc2_)
            {
               _loc11_ = new DeathStar(randomDeathStar());
               _loc12_ = (_loc10_ + _loc9_) / _loc2_ * Math.PI * 2;
               _loc11_.speed = 5 + Math.random() * 2;
               _loc11_.speed_x = Math.cos(_loc12_);
               _loc11_.speed_y = Math.sin(_loc12_);
               _loc11_.max_dist = 32;
               _loc4_.addChild(_loc11_);
               _loc11_.tick(_loc5_);
               _loc10_++;
            }
            _loc5_++;
         }
         _loc2_ = 8;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc13_ = new DeathStar(randomDeathStar());
            _loc14_ = _loc6_ / _loc2_ * Math.PI * 2;
            _loc13_.speed = 1 + Math.random() * 8;
            _loc13_.speed_x = Math.cos(_loc14_);
            _loc13_.speed_y = Math.sin(_loc14_);
            _loc13_.max_dist = 32;
            _loc4_.addChild(_loc13_);
            _loc13_.tick();
            _loc6_++;
         }
         var _loc7_:Matrix = new Matrix();
         var _loc8_:int = 0;
         while(_loc8_ < _loc1_)
         {
            _loc7_.tx = _loc8_ * 64 + 32;
            _loc7_.ty = 32;
            _loc3_.draw(_loc4_,_loc7_);
            if(_loc8_ >= 1)
            {
               _loc15_ = 0;
               while(_loc15_ < _loc4_.numChildren)
               {
                  if(_loc8_ > _loc1_ - 7)
                  {
                     _loc4_.getChildAt(_loc15_).alpha = (_loc1_ - _loc8_) / 6;
                  }
                  _loc4_.getChildAt(_loc15_)["tick"]();
                  _loc15_++;
               }
            }
            _loc8_++;
         }
         return _loc3_;
      }
   }
}
