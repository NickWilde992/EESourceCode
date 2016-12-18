package
{
   import blitter.BlSprite;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.AntiAliasType;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.display.Sprite;
   import flash.display.GradientType;
   import flash.geom.Matrix;
   import flash.display.SpreadMethod;
   import flash.display.Bitmap;
   import flash.filters.GlowFilter;
   
   public class WorldPortalHelpBubble extends BlSprite
   {
       
      
      protected var helpimage:Class;
      
      private var BMDhelpimage:BitmapData;
      
      public function WorldPortalHelpBubble(param1:String = "")
      {
         var _loc2_:TextField = null;
         var _loc6_:Number = NaN;
         this.helpimage = WorldPortalHelpBubble_helpimage;
         this.BMDhelpimage = new this.helpimage().bitmapData;
         _loc2_ = new TextField();
         _loc2_.y = this.BMDhelpimage.height + 10 + 4;
         _loc2_.multiline = true;
         _loc2_.selectable = false;
         _loc2_.wordWrap = false;
         _loc2_.width = 75;
         _loc2_.height = 50;
         _loc2_.antiAliasType = AntiAliasType.ADVANCED;
         _loc2_.autoSize = TextFieldAutoSize.CENTER;
         var _loc3_:TextFormat = new TextFormat("Tahoma",9,16777215);
         _loc3_.align = TextFormatAlign.CENTER;
         _loc2_.defaultTextFormat = _loc3_;
         if(param1 != "")
         {
            _loc2_.text = "\"" + param1 + "\"\n";
         }
         _loc2_.appendText("Press Y");
         var _loc4_:Sprite = new Sprite();
         var _loc5_:Sprite = new Sprite();
         _loc6_ = Math.max(_loc2_.width + 6,90);
         var _loc7_:Number = Math.max(_loc2_.y + _loc2_.height,30);
         var _loc8_:String = GradientType.LINEAR;
         var _loc9_:Array = [0,0];
         var _loc10_:Array = [0.5,0.3];
         var _loc11_:Array = [0,255];
         var _loc12_:Matrix = new Matrix();
         _loc12_.createGradientBox(20,_loc7_ + 3,Math.PI / 2,0,0);
         var _loc13_:String = SpreadMethod.PAD;
         _loc5_.graphics.beginGradientFill(_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_);
         _loc5_.graphics.lineStyle(0,16777215);
         _loc5_.graphics.moveTo(0,0);
         _loc5_.graphics.lineTo(_loc6_,0);
         _loc5_.graphics.lineTo(_loc6_,_loc7_ + 3);
         _loc5_.graphics.lineTo(_loc6_ / 2 + 3,_loc7_ + 3);
         _loc5_.graphics.lineTo(_loc6_ / 2,_loc7_ + 10);
         _loc5_.graphics.lineTo(_loc6_ / 2 - 3,_loc7_ + 3);
         _loc5_.graphics.lineTo(0,_loc7_ + 3);
         _loc5_.graphics.lineTo(0,0);
         _loc5_.graphics.lineStyle(0,0);
         var _loc14_:Sprite = new Sprite();
         var _loc15_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         _loc15_.draw(_loc5_);
         _loc14_.x = 1;
         _loc14_.addChild(new Bitmap(_loc15_));
         var _loc16_:GlowFilter = new GlowFilter(0,0.5,4,4,3,3,false,true);
         _loc14_.filters = [_loc16_];
         _loc2_.x = (_loc6_ - _loc2_.width) / 2 >> 0;
         _loc4_.addChild(_loc2_);
         _loc4_.addChildAt(_loc5_,0);
         _loc4_.addChildAt(_loc14_,0);
         var _loc17_:BitmapData = new BitmapData(_loc4_.width + 4,_loc4_.height + 4,true,0);
         _loc17_.draw(_loc4_);
         var _loc18_:Matrix = new Matrix();
         _loc18_.translate((_loc6_ - this.BMDhelpimage.width) / 2,10);
         _loc17_.draw(this.BMDhelpimage,_loc18_);
         super(_loc17_,0,0,_loc17_.width,_loc17_.height,1);
         rect = _loc17_.rect;
         frames = 1;
         width = rect.width;
         height = rect.height;
         x = -(width / 2 >> 0) + 8;
         y = -height + 3;
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         param1.copyPixels(bmd,rect,new Point(param2 + x,param3 + y));
      }
      
      override public function drawPoint(param1:BitmapData, param2:Point, param3:int = 0) : void
      {
         this.draw(param1,param2.x,param2.y);
      }
   }
}
