package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.text.TextFormat;
   import flash.events.ContextMenuEvent;
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   import flash.text.AntiAliasType;
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   
   public class loader extends MovieClip
   {
       
      
      private var systemFont:Class;
      
      private var t:TextField;
      
      private var ee_menu:ContextMenu;
      
      public function loader()
      {
         var showHelp:Function = null;
         var showBlog:Function = null;
         var showTAC:Function = null;
         var showForums:Function = null;
         var loader:preloader = null;
         this.systemFont = loader_systemFont;
         this.t = new TextField();
         this.ee_menu = new ContextMenu();
         super();
         showHelp = function(param1:ContextMenuEvent):void
         {
            navigateToURL(new URLRequest(Config.url_help_page));
         };
         showBlog = function(param1:ContextMenuEvent):void
         {
            navigateToURL(new URLRequest(Config.url_blog));
         };
         showTAC = function(param1:ContextMenuEvent):void
         {
            navigateToURL(new URLRequest(Config.url_terms_page));
         };
         showForums = function(param1:ContextMenuEvent):void
         {
            navigateToURL(new URLRequest(Config.url_forums));
         };
         this.ee_menu.hideBuiltInItems();
         this.ee_menu.builtInItems.zoom = true;
         var version:ContextMenuItem = new ContextMenuItem("Everybody Edits v" + Config.server_type_version);
         var help_cm:ContextMenuItem = new ContextMenuItem("Help");
         var blog_cm:ContextMenuItem = new ContextMenuItem("Blog");
         var tac_cm:ContextMenuItem = new ContextMenuItem("Terms and Conditions");
         var forums_cm:ContextMenuItem = new ContextMenuItem("Forums");
         version.enabled = false;
         help_cm.separatorBefore = true;
         this.ee_menu.customItems.push(version,help_cm,blog_cm,tac_cm,forums_cm);
         help_cm.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,showHelp);
         blog_cm.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,showBlog);
         tac_cm.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,showTAC);
         forums_cm.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,showForums);
         contextMenu = this.ee_menu;
         loader = new preloader();
         loader.masker.scaleX = 0;
         loader.x = (stage.stageWidth - loader.width) / 2;
         loader.y = 180;
         var tf:TextFormat = new TextFormat("system",36,12303291,null,null,null,null,null,"center");
         this.t.embedFonts = true;
         this.t.defaultTextFormat = tf;
         this.t.text = "0%";
         this.t.selectable = false;
         this.t.width = this.t.textWidth + 90;
         this.t.height = this.t.textHeight + 5;
         this.t.x = stage.stageWidth / 2 - this.t.width / 2;
         this.t.y = loader.y + loader.height - 20;
         this.t.alpha = 0;
         this.t.antiAliasType = AntiAliasType.ADVANCED;
         addChild(this.t);
         addChild(loader);
         TweenMax.to(loader,0.35,{
            "delay":0.5,
            "y":155,
            "onComplete":function():void
            {
               TweenMax.to(t,0.8,{"alpha":1});
            }
         });
         addEventListener(Event.ENTER_FRAME,function(param1:Event):void
         {
            var _loc3_:int = 0;
            var _loc4_:Class = null;
            if(stage.loaderInfo.bytesTotal != 0)
            {
               _loc3_ = Math.round(stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal * 100);
               t.text = "" + _loc3_ + "%";
               loader.masker.scaleX = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;
               if(stage.loaderInfo.bytesLoaded == stage.loaderInfo.bytesTotal)
               {
                  removeChild(loader);
                  removeChild(t);
                  nextFrame();
                  _loc4_ = Class(getDefinitionByName("EverybodyEdits"));
                  addChild(new _loc4_());
                  removeEventListener(Event.ENTER_FRAME,arguments.callee);
               }
            }
         });
      }
   }
}
