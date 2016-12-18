package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   public dynamic class LobbyLoginBox_Asset extends MovieClip
   {
       
      
      public var bg:MovieClip;
      
      public var login_btn:SimpleButton;
      
      public var logininfo:TextField;
      
      public var logout_btn:SimpleButton;
      
      public var profilestate:TextField;
      
      public function LobbyLoginBox_Asset()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
