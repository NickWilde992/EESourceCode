package
{
   import ui.BadgeInstance;
   import playerio.Achievement;
   
   public class Badges
   {
      
      private static var badges:Object = {};
      
      private static var _loaded:Boolean;
       
      
      public function Badges()
      {
         super();
      }
      
      public static function getBadge(param1:String) : BadgeInstance
      {
         return badges[param1] as BadgeInstance;
      }
      
      public static function getCompletedBadges() : Vector.<BadgeInstance>
      {
         var _loc2_:BadgeInstance = null;
         var _loc1_:Vector.<BadgeInstance> = new Vector.<BadgeInstance>();
         for each(_loc2_ in badges)
         {
            if(_loc2_.item.completed)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public static function refresh(param1:Function = null) : void
      {
         var callback:Function = param1;
         Global.client.achievements.refresh(function():void
         {
            var _loc3_:Achievement = null;
            var _loc1_:Array = Global.client.achievements.myAchievements;
            var _loc2_:int = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc3_ = _loc1_[_loc2_] as Achievement;
               badges[_loc3_.id] = new BadgeInstance(_loc3_);
               _loc2_++;
            }
            _loaded = true;
            if(callback != null)
            {
               callback();
            }
         });
      }
      
      public static function get loaded() : Boolean
      {
         return _loaded;
      }
   }
}
