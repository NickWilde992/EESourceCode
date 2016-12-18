package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;
   
   public class CreateRoom extends MovieClip
   {
       
      
      public var bg_mail:MovieClip;
      
      public var closebtn:SimpleButton;
      
      public var roomname:TextField;
      
      public var start:MovieClip;
      
      public var title:TextField;
      
      public function CreateRoom(param1:Function)
      {
         var self:CreateRoom = null;
         var callback:Function = param1;
         super();
         this.roomname.embedFonts = true;
         this.roomname.defaultTextFormat = new TextFormat(new system().fontName,14);
         this.roomname.restrict = "0-9 A-Za-z";
         this.roomname.maxChars = 25;
         this.roomname.text = ["The","My","Our"][Math.random() * 3 >> 0] + [" Awesome"," Cool"," Spectacular"," Pretty"," Wild"," Great"," Fun",""][Math.random() * 8 >> 0] + [" World"," Creation"," Room"," Area"][Math.random() * 4 >> 0];
         self = this;
         this.start.buttonMode = true;
         this.start.useHandCursor = true;
         this.start.mouseChildren = false;
         this.start.addEventListener(MouseEvent.CLICK,function():void
         {
            if(roomname.text.replace(/ /gi,"") != "")
            {
               self.parent.removeChild(self);
               callback(roomname.text,true);
            }
         });
         this.closebtn.addEventListener(MouseEvent.CLICK,function():void
         {
            self.parent.removeChild(self);
         });
      }
   }
}
