package
{
   import blitter.BlSprite;
   import flash.geom.Point;
   import flash.filters.ColorMatrixFilter;
   import flash.display.BitmapData;
   import flash.text.TextField;
   import flash.text.AntiAliasType;
   import flash.text.GridFitType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.display.Sprite;
   import flash.display.GradientType;
   import flash.geom.Matrix;
   import flash.display.SpreadMethod;
   import flash.filters.GlowFilter;
   
   public class ChatBubble extends BlSprite
   {
       
      
      public var time:Date;
      
      public var text:String = "";
      
      public function ChatBubble(param1:String, param2:String)
      {
         var _loc3_:TextField = null;
         this.time = new Date();
         this.text = param2;
         _loc3_ = new TextField();
         _loc3_.x = 2;
         _loc3_.y = 2;
         _loc3_.multiline = true;
         _loc3_.selectable = false;
         _loc3_.wordWrap = true;
         _loc3_.width = 110;
         _loc3_.height = 500;
         _loc3_.antiAliasType = AntiAliasType.ADVANCED;
         _loc3_.gridFitType = GridFitType.SUBPIXEL;
         _loc3_.condenseWhite = true;
         var _loc4_:TextFormat = new TextFormat("Tahoma",11,0,false,false,false);
         _loc4_.align = TextFormatAlign.CENTER;
         _loc3_.defaultTextFormat = _loc4_;
         _loc3_.text = param2;
         if(_loc3_.numLines == 1)
         {
            _loc3_.width = _loc3_.textWidth + 5;
         }
         _loc3_.height = _loc3_.textHeight + 5;
         var _loc5_:Number = _loc3_.textHeight;
         if(_loc3_.numLines != 1)
         {
            while(_loc5_ == _loc3_.textHeight)
            {
               _loc3_.width--;
            }
            _loc3_.width++;
         }
         var _loc6_:Sprite = new Sprite();
         _loc6_.addChild(_loc3_);
         var _loc7_:String = GradientType.LINEAR;
         var _loc8_:Array = [13816530,16777215];
         var _loc9_:Array = [0.9,0.9];
         var _loc10_:Array = [0,255];
         var _loc11_:Matrix = new Matrix();
         _loc11_.createGradientBox(20,_loc3_.height + 3,Math.PI / 2,0,0);
         var _loc12_:String = SpreadMethod.PAD;
         _loc6_.graphics.beginGradientFill(_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_);
         _loc6_.graphics.drawRoundRect(0,0,_loc3_.width + 4,_loc3_.height + 3,4,4);
         _loc6_.graphics.moveTo(_loc3_.width / 2,_loc3_.height + 3);
         _loc6_.graphics.lineTo(_loc3_.width / 2,_loc3_.height + 10);
         _loc6_.graphics.lineTo(_loc3_.width / 2 + 7,_loc3_.height + 3);
         var _loc13_:GlowFilter = new GlowFilter(0,1,2,2,2,3,false);
         _loc6_.filters = [_loc13_];
         var _loc14_:BitmapData = new BitmapData(_loc6_.width + 4,_loc6_.height + 4,true,0);
         var _loc15_:Matrix = new Matrix();
         _loc15_.translate(2,2);
         _loc14_.draw(_loc6_,_loc15_);
         super(_loc14_,0,0,_loc14_.width,_loc14_.height,1);
         rect = _loc14_.rect;
         frames = 1;
         width = rect.width;
         height = rect.height;
         x = -(width / 2 >> 0) + 19;
         y = -height + 7;
      }
      
      public function age(param1:Number) : void
      {
         if(param1 > 14000)
         {
            bmd.applyFilter(bmd,bmd.rect,new Point(0,0),new ColorMatrixFilter([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.9,0]));
         }
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         param1.copyPixels(bmd,rect,new Point(param2 + x,param3 + y));
      }
   }
}
