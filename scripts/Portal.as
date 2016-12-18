package
{
   public class Portal
   {
       
      
      private var _id:int = 0;
      
      private var _target:int = 0;
      
      private var _rotation:int = 0;
      
      private var _type:int = 0;
      
      public function Portal(param1:int, param2:int, param3:int, param4:int = 242)
      {
         super();
         this._id = param1;
         this._target = param2;
         this._rotation = param3;
         this._type = param4;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get target() : int
      {
         return this._target;
      }
      
      public function get rotation() : int
      {
         return this._rotation;
      }
      
      public function get type() : int
      {
         return this._type;
      }
   }
}
