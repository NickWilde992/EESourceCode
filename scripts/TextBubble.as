package
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.AntiAliasType;
   import flash.text.GridFitType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.filters.GlowFilter;
   import states.PlayState;
   import io.player.tools.Badwords;
   import flash.geom.Point;
   
   public class TextBubble
   {
       
      
      private var colors:Array;
      
      private var bmd:BitmapData;
      
      private var s:Sprite;
      
      private var latest:String = "";
      
      private var latest2:int = -1;
      
      public function TextBubble()
      {
         this.colors = [16777215,6724095,16732240,16765210];
         super();
      }
      
      private function updateGraphics(param1:String, param2:int, param3:uint) : void
      {
         var _loc4_:TextField = null;
         _loc4_ = new TextField();
         _loc4_.x = 3;
         _loc4_.y = 3;
         _loc4_.multiline = true;
         _loc4_.selectable = false;
         _loc4_.wordWrap = true;
         _loc4_.width = 150;
         _loc4_.height = 500;
         _loc4_.antiAliasType = AntiAliasType.ADVANCED;
         _loc4_.gridFitType = GridFitType.SUBPIXEL;
         _loc4_.condenseWhite = true;
         var _loc5_:TextFormat = new TextFormat("Tahoma",11,this.colors[param2],false,false,false);
         _loc5_.align = TextFormatAlign.CENTER;
         _loc4_.defaultTextFormat = _loc5_;
         _loc4_.text = param1;
         if(_loc4_.numLines == 1)
         {
            _loc4_.width = _loc4_.textWidth + 5;
         }
         _loc4_.height = _loc4_.textHeight + 5;
         var _loc6_:Number = _loc4_.textHeight;
         if(_loc4_.numLines != 1)
         {
            while(_loc6_ == _loc4_.textHeight && _loc4_.width > 11)
            {
               _loc4_.width--;
            }
            _loc4_.width++;
         }
         if(_loc4_.height > 135)
         {
            _loc4_.height = 135;
         }
         this.s = new Sprite();
         this.s.addChild(_loc4_);
         this.s.graphics.beginFill(param3,1);
         this.s.graphics.drawRoundRect(2,2,_loc4_.width + 1,_loc4_.height + 1,4,4);
         this.s.graphics.moveTo(_loc4_.width / 2 + 7,_loc4_.height + 3);
         this.s.graphics.lineTo(_loc4_.width / 2 - 1,_loc4_.height + 10);
         this.s.graphics.lineTo(_loc4_.width / 2 - 1,_loc4_.height + 3);
         var _loc7_:GlowFilter = new GlowFilter(0,1,2,2,2,3,false);
         this.s.filters = [_loc7_];
         this.bmd = new BitmapData(this.s.width + 4,this.s.height + 4,true,0);
         this.bmd.draw(this.s);
      }
      
      public function update(param1:String, param2:int = 0, param3:Boolean = true, param4:uint = 0) : void
      {
         var _loc6_:String = null;
         var _loc5_:Player = (Global.base.state as PlayState).player;
         param1 = param1.replace(/%username%/g,_loc5_.name);
         param1 = param1.replace(/%coins%/g,_loc5_.coins);
         param1 = param1.replace(/%bcoins%/g,_loc5_.bcoins);
         param1 = param1.replace(/%deaths%/g,_loc5_.deaths);
         param1 = param1.replace(/%levelname%/g,Global.currentLevelname);
         param1 = param1.replace(/\\n/g,"\n");
         if(this.latest != param1 || this.latest2 != param2)
         {
            _loc6_ = param1;
            if(param3)
            {
               _loc6_ = Badwords.Filter(param1);
            }
            this.updateGraphics(_loc6_,param2,param4);
         }
         this.latest = param1;
         this.latest2 = param2;
      }
      
      public function drawPoint(param1:BitmapData, param2:Point) : void
      {
         var _loc3_:int = this.bmd.rect.width;
         var _loc4_:int = this.bmd.rect.height;
         var _loc5_:int = (_loc3_ / 2 >> 0) - 12;
         var _loc6_:int = _loc4_ - 2;
         var _loc7_:Point = param2.subtract(new Point(_loc5_,_loc6_));
         param1.copyPixels(this.bmd,this.bmd.rect,_loc7_);
      }
   }
}
