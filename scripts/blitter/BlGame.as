package blitter
{
   import flash.display.MovieClip;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import ui.OverlayContainer;
   import flash.events.Event;
   import flash.display.PixelSnapping;
   
   public class BlGame extends MovieClip
   {
       
      
      protected var screen:BitmapData;
      
      protected var screenContainer:Bitmap;
      
      public var overlayContainer:OverlayContainer;
      
      protected var _state:blitter.BlState;
      
      protected var bw:int = 0;
      
      protected var bh:int = 0;
      
      public function BlGame(param1:int, param2:int, param3:Number)
      {
         this.overlayContainer = new OverlayContainer();
         super();
         this.screen = new BitmapData(param1,param2 - 10,false,0);
         this.screenContainer = new Bitmap(this.screen,PixelSnapping.ALWAYS,false);
         Bl.screenContainer = this.screenContainer;
         this.screenContainer.width = param1 * param3;
         this.screenContainer.height = param2 * param3 - 10;
         this.bw = param1;
         this.bh = param2;
         addChild(this.screenContainer);
         this.overlayContainer.addEventListener(Event.ADDED,this.handleNewOverlay,false,0,true);
         this.overlayContainer.addEventListener(Event.REMOVED,this.handleNewOverlay,false,0,true);
         Bl.overlayContainer = this.overlayContainer;
         addEventListener(Event.ADDED_TO_STAGE,this.handleAttach);
      }
      
      public function clearOverlayContainer() : void
      {
         while(this.overlayContainer.numChildren > 0)
         {
            this.overlayContainer.removeChildAt(0);
         }
      }
      
      protected function handleNewOverlay(param1:Event) : void
      {
         addEventListener(Event.EXIT_FRAME,this.handleExitFrame,false,0,true);
      }
      
      protected function handleExitFrame(param1:Event) : void
      {
         removeEventListener(Event.EXIT_FRAME,this.handleExitFrame);
         this.alignOverlay();
      }
      
      protected function alignOverlay() : void
      {
         var _loc1_:String = this.state != null?this.state.align:blitter.BlState.STATE_ALIGN_CENTER;
         switch(_loc1_)
         {
            case blitter.BlState.STATE_ALIGN_LEFT:
               this.overlayContainer.x = 0;
               if(stage.stageWidth > Config.maxwidth)
               {
                  this.overlayContainer.x = (stage.stageWidth - Config.maxwidth) / 2 >> 0;
               }
               break;
            case blitter.BlState.STATE_ALIGN_CENTER:
               this.overlayContainer.x = (stage.stageWidth - this.overlayContainer.width) / 2 >> 0;
               break;
            case blitter.BlState.STATE_ALIGN_RIGHT:
               this.overlayContainer.x = stage.stageWidth - this.overlayContainer.width;
         }
         Bl.stage.addChild(this.overlayContainer);
      }
      
      protected function handleResize(param1:Event = null) : void
      {
         this.alignOverlay();
         if(this.state != null)
         {
            this.state.resize();
            switch(this.state.align)
            {
               case blitter.BlState.STATE_ALIGN_LEFT:
                  this.screenContainer.x = 0;
                  if(stage.stageWidth > Config.maxwidth)
                  {
                     this.screenContainer.x = (stage.stageWidth - Config.maxwidth) / 2 >> 0;
                  }
                  break;
               case blitter.BlState.STATE_ALIGN_CENTER:
                  this.screenContainer.x = (stage.stageWidth - this.bw) / 2 >> 0;
                  break;
               case blitter.BlState.STATE_ALIGN_RIGHT:
                  this.screenContainer.x = stage.stageWidth - this.bw;
            }
         }
      }
      
      private function handleAttach(param1:Event) : void
      {
         Bl.init(stage,this.bw,this.bh);
         stage.frameRate = Config.maxFrameRate;
         addEventListener(Event.ENTER_FRAME,this.handleEnterFrame);
         stage.addEventListener(Event.RESIZE,this.handleResize);
         stage.addChild(this.overlayContainer);
      }
      
      public function get state() : blitter.BlState
      {
         return this._state;
      }
      
      public function set state(param1:blitter.BlState) : void
      {
         this._state = param1;
         this.handleResize();
      }
      
      protected function handleEnterFrame(param1:Event = null) : void
      {
         if(this.state != null && !this.state.stopRendering)
         {
            if((new Date().time - Bl.time) / Config.physics_ms_per_tick > 15)
            {
               Bl.time = new Date().time - Config.physics_ms_per_tick * 15;
            }
            while(Bl.time < new Date().time)
            {
               this.state.tick();
               Bl.time = Bl.time + Config.physics_ms_per_tick;
            }
            this.state.enterFrame();
            Bl.exitFrame();
            this.state.exitFrame();
            this.screen.lock();
            this.state.draw(this.screen,0,0);
            this.screen.unlock();
         }
      }
   }
}
