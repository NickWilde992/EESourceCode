package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   public dynamic class asset_loginbox extends MovieClip
   {
       
      
      public var armorloginbtn:MovieClip;
      
      public var btn_close:SimpleButton;
      
      public var btn_guestplay:SimpleButton;
      
      public var fbbtn:SimpleButton;
      
      public var inppassword:TextField;
      
      public var inpusername:TextField;
      
      public var keeplogin:MovieClip;
      
      public var kongloginbtn:SimpleButton;
      
      public var labelemail:TextField;
      
      public var labelepassword:TextField;
      
      public var loginbtn:SimpleButton;
      
      public var playonfbbtn:SimpleButton;
      
      public var recoverpass:SimpleButton;
      
      public var registerbtn:asset_registerBTN;
      
      public function asset_loginbox()
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
