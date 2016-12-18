package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class asset_tab extends MovieClip
   {
       
      
      public var bg:MovieClip;
      
      public var icon:MovieClip;
      
      public var tf_label:TextField;
      
      public function asset_tab()
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
