package fl.controls
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import fl.core.UIComponent;
   import fl.core.InvalidationType;
   import mx.events.ComponentEvent;
   
   public class BaseButton extends UIComponent
   {
      
      private static var defaultStyles :Object = {
         "upSkin":"Button_upSkin",
         "downSkin":"Button_downSkin",
         "overSkin":"Button_overSkin",
         "disabledSkin":"Button_disabledSkin",
         "selectedDisabledSkin":"Button_selectedDisabledSkin",
         "selectedUpSkin":"Button_selectedUpSkin",
         "selectedDownSkin":"Button_selectedDownSkin",
         "selectedOverSkin":"Button_selectedOverSkin",
         "focusRectSkin":null,
         "focusRectPadding":null,
         "repeatDelay":500,
         "repeatInterval":35
      };
       
      
      protected var background:DisplayObject;
      
      protected var ѧ:String;
      
      protected var Ѩ:Boolean = false;
      
      protected var ѩ:Boolean = false;
      
      protected var Ѫ:Timer;
      
      private var ѫ:Boolean = false;
      
      private var Ѭ:String;
      
      public function BaseButton()
      {
         super();
         buttonMode = true;
         mouseChildren = false;
         useHandCursor = false;
         this.ѯ();
         this.Ѯ("up");
         this.Ѫ = new Timer(1,0);
         this.Ѫ.addEventListener(TimerEvent.TIMER,this.buttonDown,false,0,true);
      }
      
      public static function getStyleDefinition() : Object
      {
         return defaultStyles ;
      }
      
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseEnabled = param1;
      }
      
      public function get selected() : Boolean
      {
         return this.Ѩ;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this.Ѩ == param1)
         {
            return;
         }
         this.Ѩ = param1;
         invalidate(InvalidationType.STATE);
      }
      
      public function get ѭ() : Boolean
      {
         return this.ѩ;
      }
      
      public function set ѭ(param1:Boolean) : void
      {
         this.ѩ = param1;
      }
      
      public function set mouseStateLocked(param1:Boolean) : void
      {
         this.ѫ = param1;
         if(param1 == false)
         {
            this.Ѯ(this.Ѭ);
         }
         else
         {
            this.Ѭ = this.ѧ;
         }
      }
      
      public function Ѯ(param1:String) : void
      {
         if(this.ѫ)
         {
            this.Ѭ = param1;
            return;
         }
         if(this.ѧ == param1)
         {
            return;
         }
         this.ѧ = param1;
         invalidate(InvalidationType.STATE);
      }
      
      protected function ѯ() : void
      {
         addEventListener(MouseEvent.ROLL_OVER,this.Ѱ,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.Ѱ,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.Ѱ,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.Ѱ,false,0,true);
      }
      
      protected function Ѱ(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            this.Ѯ("down");
            this.ѱ();
         }
         else if(param1.type == MouseEvent.ROLL_OVER || param1.type == MouseEvent.MOUSE_UP)
         {
            this.Ѯ("over");
            this.Ѳ();
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            this.Ѯ("up");
            this.Ѳ();
         }
      }
      
      protected function ѱ() : void
      {
         if(this.ѩ)
         {
            this.Ѫ.delay = Number(і("repeatDelay"));
            this.Ѫ.start();
         }
         dispatchEvent(new ComponentEvent(ComponentEvent.BUTTONDOWN,true));
      }
      
      protected function buttonDown(param1:TimerEvent) : void
      {
         if(!this.ѩ)
         {
            this.Ѳ();
            return;
         }
         if(this.Ѫ.currentCount == 1)
         {
            this.Ѫ.delay = Number(і("repeatInterval"));
         }
         dispatchEvent(new ComponentEvent(ComponentEvent.BUTTONDOWN,true));
      }
      
      protected function Ѳ() : void
      {
         this.Ѫ.reset();
      }
      
      override protected function draw() : void
      {
         if(ѓ(InvalidationType.STYLES,InvalidationType.STATE))
         {
            this.ѳ();
            invalidate(InvalidationType.SIZE,false);
         }
         if(ѓ(InvalidationType.SIZE))
         {
            this.Ѵ();
         }
         super.draw();
      }
      
      protected function ѳ() : void
      {
         var _loc1_:* = !!this.enabled?this.ѧ:"disabled";
         if(this.selected)
         {
            _loc1_ = "selected" + _loc1_.substr(0,1).toUpperCase() + _loc1_.substr(1);
         }
         _loc1_ = _loc1_ + "Skin";
         var _loc2_:DisplayObject = this.background;
         this.background = ѕ(і(_loc1_));
         addChildAt(this.background,0);
         if(_loc2_ != null && _loc2_ != this.background)
         {
            removeChild(_loc2_);
         }
      }
      
      protected function Ѵ() : void
      {
         this.background.width = width;
         this.background.height = height;
      }
   }
}
