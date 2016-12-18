package
{
   import blitter.BlObject;
   
   public class SynchronizedObject extends BlObject
   {
       
      
      protected var _speedX:Number = 0;
      
      protected var _speedY:Number = 0;
      
      protected var _modifierX:Number = 0;
      
      protected var _modifierY:Number = 0;
      
      protected var _baseDragX:Number;
      
      protected var _baseDragY:Number;
      
      protected var _no_modifier_dragX:Number;
      
      protected var _no_modifier_dragY:Number;
      
      protected var _water_drag:Number;
      
      protected var _water_buoyancy:Number;
      
      protected var _mud_drag:Number;
      
      protected var _mud_buoyancy:Number;
      
      protected var _lava_drag:Number;
      
      protected var _lava_buoyancy:Number;
      
      protected var _boost:Number;
      
      protected var _gravity:Number;
      
      public var mox:Number = 0;
      
      public var moy:Number = 0;
      
      public var mx:Number = 0;
      
      public var my:Number = 0;
      
      public var last:Number = 0;
      
      protected var offset:Number = 0;
      
      private var mult:Number;
      
      public function SynchronizedObject()
      {
         this._baseDragX = Config.physics_base_drag;
         this._baseDragY = Config.physics_base_drag;
         this._no_modifier_dragX = Config.physics_no_modifier_drag;
         this._no_modifier_dragY = Config.physics_no_modifier_drag;
         this._water_drag = Config.physics_water_drag;
         this._water_buoyancy = Config.physics_water_buoyancy;
         this._mud_drag = Config.physics_mud_drag;
         this._mud_buoyancy = Config.physics_mud_buoyancy;
         this._lava_drag = Config.physics_lava_drag;
         this._lava_buoyancy = Config.physics_lava_buoyancy;
         this._boost = Config.physics_boost;
         this._gravity = Config.physics_gravity;
         this.mult = Config.physics_variable_multiplyer;
         super();
         this.last = new Date().time;
      }
      
      public function get speedX() : Number
      {
         return this._speedX * this.mult;
      }
      
      public function set speedX(param1:Number) : void
      {
         this._speedX = param1 / this.mult;
      }
      
      public function get speedY() : Number
      {
         return this._speedY * this.mult;
      }
      
      public function set speedY(param1:Number) : void
      {
         this._speedY = param1 / this.mult;
      }
      
      public function get modifierX() : Number
      {
         return this._modifierX * this.mult;
      }
      
      public function set modifierX(param1:Number) : void
      {
         this._modifierX = param1 / this.mult;
      }
      
      public function get modifierY() : Number
      {
         return this._modifierY * this.mult;
      }
      
      public function set modifierY(param1:Number) : void
      {
         this._modifierY = param1 / this.mult;
      }
   }
}
