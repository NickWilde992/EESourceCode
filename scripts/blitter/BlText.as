package blitter
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.display.StageQuality;
   import flash.geom.Point;
   import flash.text.AntiAliasType;
   
   public class BlText extends BlObject
   {
       
      
      private var systemFont:Class;
      
      private var visitorFont:Class;
      
      protected var _text:String = "";
      
      protected var bmd:BitmapData;
      
      protected var tf:TextField;
      
      protected var tff:TextFormat;
      
      public function BlText(param1:int, param2:Number, param3:Number = 16777215, param4:String = "left", param5:String = "system", param6:Boolean = false)
      {
         this.systemFont = BlText_systemFont;
         this.visitorFont = BlText_visitorFont;
         this.tf = new TextField();
         this.tf.embedFonts = true;
         this.tf.selectable = false;
         this.tf.sharpness = 100;
         if(param6)
         {
            this.tf.antiAliasType = AntiAliasType.ADVANCED;
         }
         this.tf.multiline = true;
         this.tf.wordWrap = true;
         this.tf.width = param2;
         this.tff = new TextFormat(param5,param1,param3,null,null,null,null,null,param4);
         this.tf.defaultTextFormat = this.tff;
         this.tf.text = "qi´";
         this.bmd = new BitmapData(param2,this.tf.textHeight + 5,true,0);
         this.tf.text = "";
         super();
      }
      
      public function set text(param1:String) : void
      {
         if(this._text != param1)
         {
            this._text = param1;
            if(param1)
            {
               this.tf.text = param1;
            }
            Bl.stage.quality = StageQuality.LOW;
            this.bmd = new BitmapData(this.tf.width,this.tf.textHeight + 2,true,0);
            this.bmd.draw(this.tf);
            Bl.stage.quality = StageQuality.BEST;
         }
      }
      
      public function set filters(param1:Array) : void
      {
         this.tf.filters = param1;
         this.text = this._text;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get textfield() : TextField
      {
         return this.tf;
      }
      
      override public function draw(param1:BitmapData, param2:int, param3:int) : void
      {
         param1.copyPixels(this.bmd,this.bmd.rect,new Point(param2 + x,param3 + y));
      }
      
      public function clone() : BitmapData
      {
         return this.bmd.clone();
      }
   }
}
