package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.events.KeyboardEvent;
   import flash.events.Event;
   
   public class WorldsFilter extends MovieClip
   {
       
      
      public var filter:TextField;
      
      public function WorldsFilter(param1:Function)
      {
         var callback:Function = param1;
         super();
         this.filter.addEventListener(KeyboardEvent.KEY_UP,function(param1:Event):*
         {
            callback(filter.text);
         });
      }
   }
}
