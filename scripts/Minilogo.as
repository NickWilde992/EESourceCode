package
{
   import flash.display.MovieClip;
   import fl.transitions.Tween;
   import flash.geom.Rectangle;
   import flash.events.MouseEvent;
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   import flash.events.Event;
   import playerio.utils.SWFReader;
   import fl.transitions.easing.Strong;
   import fl.transitions.TweenEvent;
   import flash.utils.setTimeout;
   import flash.filters.BlurFilter;
   
   public class Minilogo extends MovieClip
   {
      
      public static var showLogo:Boolean = true;
       
      
      private var align:String;
      
      private var t:Tween;
      
      private var rect:Rectangle;
      
      public function Minilogo(param1:String = "BC")
      {
         var _loc2_:* = null;
         super();
         this.align = param1;
         this.alpha = 0;
         this.buttonMode = true;
         addEventListener("addedToStage",handleAttach);
         this.addEventListener("mouseDown",handleClick);
         Minilogo.showLogo = false;
      }
      
      private function handleClick(param1:MouseEvent) : void
      {
         param1.preventDefault();
         param1.stopImmediatePropagation();
         try
         {
            navigateToURL(new URLRequest("http://playerio.com/?ref=gamelogo"),"_new");
            return;
         }
         catch(e:Error)
         {
            trace("Error occurred!");
            return;
         }
      }
      
      private function handleResize(param1:Event = null) : void
      {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(this.parent)
         {
            _loc2_ = 0;
            _loc3_ = 0;
            if(stage.scaleMode == "noScale")
            {
               var _loc4_:* = stage.align;
               if("" !== _loc4_)
               {
                  if("T" === _loc4_)
                  {
                     _loc2_ = Number(-(stage.stageWidth - rect.width) / 2);
                  }
               }
               else
               {
                  _loc2_ = Number(-(stage.stageWidth - rect.width) / 2);
                  _loc3_ = Number(-(stage.stageHeight - rect.height) / 2);
               }
            }
            _loc4_ = align;
            if("TL" !== _loc4_)
            {
               if("CL" !== _loc4_)
               {
                  if("BL" !== _loc4_)
                  {
                     if("TC" !== _loc4_)
                     {
                        if("CC" !== _loc4_)
                        {
                           if("TR" !== _loc4_)
                           {
                              if("CR" !== _loc4_)
                              {
                                 if("BR" !== _loc4_)
                                 {
                                    this.x = _loc2_ + stage.stageWidth / 2;
                                    this.y = _loc3_ + stage.stageHeight - 45;
                                 }
                                 else
                                 {
                                    this.x = _loc2_ + stage.stageWidth - 140;
                                    this.y = _loc3_ + stage.stageHeight - 45;
                                 }
                              }
                              else
                              {
                                 this.x = _loc2_ + stage.stageWidth - 140;
                                 this.y = _loc3_ + stage.stageHeight / 2;
                              }
                           }
                           else
                           {
                              this.x = _loc2_ + stage.stageWidth - 140;
                              this.y = _loc3_ + 45;
                           }
                        }
                        else
                        {
                           this.x = _loc2_ + stage.stageWidth / 2;
                           this.y = _loc3_ + stage.stageHeight / 2;
                        }
                     }
                     else
                     {
                        this.x = _loc2_ + stage.stageWidth / 2;
                        this.y = _loc3_ + 45;
                     }
                  }
                  else
                  {
                     this.x = _loc2_ + 140;
                     this.y = _loc3_ + stage.stageHeight - 45;
                  }
               }
               else
               {
                  this.x = _loc2_ + 140;
                  this.y = _loc3_ + stage.stageHeight / 2;
               }
            }
            else
            {
               this.x = _loc2_ + 140;
               this.y = _loc3_ + 45;
            }
         }
      }
      
      private function handleEnterFrame(param1:Event) : void
      {
         if(stage.getChildAt(stage.numChildren - 1) != this)
         {
            stage.addChild(this);
         }
      }
      
      private function handleAttach(param1:Event) : void
      {
         if((stage.loaderInfo as Object).hasOwnProperty("bytes"))
         {
            rect = new SWFReader((stage.loaderInfo as Object).bytes).dimensions;
         }
         else
         {
            rect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
         }
         stage.addEventListener("resize",handleResize);
         handleResize();
         t = new Tween(this,"alpha",Strong.easeIn,0,1,0.5,true);
         t.addEventListener("motionFinish",handleCreated);
         t.addEventListener("motionChange",handleTick);
         addEventListener("enterFrame",handleEnterFrame);
      }
      
      private function handleCreated(param1:TweenEvent) : void
      {
      }
      
      private function handleTick(param1:Event) : void
      {
         this.filters = [new BlurFilter((1 - this.alpha) * 100,(1 - this.alpha) * 10)];
      }
      
      private function doRemove() : void
      {
         t = new Tween(this,"alpha",Strong.easeIn,1,0,0.5,true);
         t.addEventListener("motionChange",handleTick);
         t.addEventListener("motionFinish",kill);
         removeEventListener("enterFrame",handleEnterFrame);
         stage.removeEventListener("resize",handleResize);
      }
      
      private function kill(param1:Event) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
