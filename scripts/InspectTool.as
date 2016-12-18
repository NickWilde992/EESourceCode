package
{
   public class InspectTool extends TextBubble
   {
       
      
      private var world:World;
      
      public function InspectTool(param1:World)
      {
         super();
         this.world = param1;
      }
      
      public function updateForBlockAt(param1:int, param2:int) : void
      {
         update(this.getInspectText(param1,param2),0,false);
      }
      
      private function getInspectText(param1:int, param2:int) : String
      {
         var _loc3_:String = param1 + "x" + param2;
         var _loc4_:String = this.getLayerText(0,param1,param2);
         var _loc5_:String = this.getLayerText(1,param1,param2);
         if(_loc4_ != "")
         {
            _loc3_ = _loc3_ + ("\n\n" + _loc4_);
         }
         if(_loc5_ != "")
         {
            _loc3_ = _loc3_ + ("\n\n" + _loc5_);
         }
         if(_loc4_ == "" && _loc5_ == "")
         {
            _loc3_ = _loc3_ + ("\n\n" + "No data");
         }
         return _loc3_;
      }
      
      private function getLayerText(param1:int, param2:int, param3:int) : String
      {
         var _loc4_:int = this.world.getTile(param1,param2,param3);
         var _loc5_:String = this.world.lookup.getPlacer(param2,param3,param1);
         if(_loc5_ == "")
         {
            return "";
         }
         var _loc6_:String = param1 == 0?"Foreground":"Background";
         return _loc6_ + ":\n" + this.getPlacerText(_loc5_,_loc4_);
      }
      
      private function getPlacerText(param1:String, param2:int) : String
      {
         return (param2 == 0?"Removed":"Placed") + " by " + param1;
      }
   }
}
