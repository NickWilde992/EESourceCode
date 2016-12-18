package
{
   import blitter.BlContainer;
   import blitter.BlSprite;
   import blitter.BlText;
   import flash.filters.GlowFilter;
   import mx.utils.StringUtil;
   import io.player.tools.Badwords;
   import flash.display.BitmapData;
   
   public class Chat extends BlContainer
   {
      
      public static var queue:Array = [];
       
      
      protected var microchatimage:Class;
      
      private var microchat:BlSprite;
      
      private var chats:Vector.<ChatBubble>;
      
      private var name:BlText;
      
      private var color:uint;
      
      protected var teamdotsimage:Class;
      
      private var teamdot:BlSprite;
      
      public function Chat(param1:String)
      {
         this.microchatimage = Chat_microchatimage;
         this.microchat = BlSprite.createFromBitmapData(new this.microchatimage().bitmapData);
         this.chats = new Vector.<ChatBubble>();
         this.teamdotsimage = Chat_teamdotsimage;
         this.teamdot = new BlSprite(new this.teamdotsimage().bitmapData,0,0,16,16,6);
         super();
         var _loc2_:Number = Player.getNameColor(param1);
         this.name = new BlText(14,160,_loc2_,"center","visitor");
         this.name.filters = [new GlowFilter(0,2,2,2,2,3)];
         this.name.x = -80 + 8;
         this.name.y = 15;
         this.name.text = param1;
         this.teamdot.y = 15;
      }
      
      public static function drawAll() : void
      {
         var _loc1_:Object = null;
         queue.sortOn(["t"],Array.NUMERIC);
         while(queue.length)
         {
            _loc1_ = queue.shift();
            _loc1_.m();
         }
      }
      
      public function set textColor(param1:uint) : void
      {
         this.color = param1;
         var _loc2_:String = this.name.text;
         this.name = new BlText(14,160,this.color,"center","visitor");
         this.name.filters = [new GlowFilter(0,2,2,2,2,3)];
         this.name.x = -80 + 8;
         this.name.y = 15;
         this.name.text = _loc2_;
      }
      
      public function say(param1:String) : void
      {
         var _loc4_:ChatBubble = null;
         if(param1.length > 80)
         {
            param1 = param1.substring(0,80);
            param1 = StringUtil.trim(param1);
            param1 = param1 + "...";
         }
         param1 = Badwords.Filter(param1);
         var _loc2_:ChatBubble = new ChatBubble(this.name.text,param1);
         var _loc3_:int = 0;
         while(_loc3_ < this.chats.length)
         {
            _loc4_ = this.chats[_loc3_] as ChatBubble;
            _loc4_.y = _loc4_.y - (_loc2_.height - 5);
            _loc3_++;
         }
         this.chats.push(_loc2_);
         if(this.chats.length > 3)
         {
            this.chats.shift();
         }
      }
      
      override public function enterFrame() : void
      {
         var _loc2_:ChatBubble = null;
         var _loc3_:Number = NaN;
         var _loc1_:int = 0;
         while(_loc1_ < this.chats.length)
         {
            _loc2_ = this.chats[_loc1_] as ChatBubble;
            _loc3_ = new Date().time - _loc2_.time.getTime();
            _loc2_.age(_loc3_);
            if(_loc3_ > 15000)
            {
               this.chats.shift();
               _loc1_--;
            }
            _loc1_++;
         }
      }
      
      public function drawChat(param1:BitmapData, param2:Number, param3:Number, param4:Boolean, param5:Boolean, param6:Boolean, param7:int) : void
      {
         var _loc8_:int = 0;
         if(param5 == false)
         {
            if(param4)
            {
               this.name.draw(param1,param2,param3);
            }
         }
         this.teamdot.frame = param7 - 1;
         if(param7 > 0)
         {
            if(param4 && !param5)
            {
               this.teamdot.draw(param1,param2 - this.name.textfield.textWidth / 2 - 6,param3);
            }
            else
            {
               this.teamdot.draw(param1,param2,param3);
            }
         }
         if(param6 == false)
         {
            if(param4)
            {
               _loc8_ = 0;
               while(_loc8_ < this.chats.length)
               {
                  if(this.chats[_loc8_].text == "")
                  {
                     this.microchat.draw(param1,param2 + 8,param3 - 5);
                  }
                  else
                  {
                     this.addToQueue(this.chats[_loc8_],param1,param2,param3);
                  }
                  _loc8_++;
               }
            }
            else if(this.chats.length > 0)
            {
               this.microchat.draw(param1,param2 + 8,param3 - 5);
            }
         }
      }
      
      private function addToQueue(param1:ChatBubble, param2:BitmapData, param3:Number, param4:Number) : void
      {
         var c:ChatBubble = param1;
         var target:BitmapData = param2;
         var ox:Number = param3;
         var oy:Number = param4;
         queue.push({
            "t":c.time.getTime(),
            "m":function():void
            {
               c.draw(target,ox,oy);
            }
         });
      }
   }
}
