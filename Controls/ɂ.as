package Controls
{
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import fl.core.UIComponent;
   import fl.core.InvalidationType;
   import mx.events.ComponentEvent;
   import mx.events.ScrollEvent;
   
   public class ɂ extends UIComponent
   {
      
      public static const һ:Number = 15;
      
      private static var defaultStyles :Object = {
         "downArrowDisabledSkin":"ScrollArrowDown_disabledSkin",
         "downArrowDownSkin":"ScrollArrowDown_downSkin",
         "downArrowOverSkin":"ScrollArrowDown_overSkin",
         "downArrowUpSkin":"ScrollArrowDown_upSkin",
         "thumbDisabledSkin":"ScrollThumb_upSkin",
         "thumbDownSkin":"ScrollThumb_downSkin",
         "thumbOverSkin":"ScrollThumb_overSkin",
         "thumbUpSkin":"ScrollThumb_upSkin",
         "trackDisabledSkin":"ScrollTrack_skin",
         "trackDownSkin":"ScrollTrack_skin",
         "trackOverSkin":"ScrollTrack_skin",
         "trackUpSkin":"ScrollTrack_skin",
         "upArrowDisabledSkin":"ScrollArrowUp_disabledSkin",
         "upArrowDownSkin":"ScrollArrowUp_downSkin",
         "upArrowOverSkin":"ScrollArrowUp_overSkin",
         "upArrowUpSkin":"ScrollArrowUp_upSkin",
         "thumbIcon":"ScrollBar_thumbIcon",
         "repeatDelay":500,
         "repeatInterval":35
      };
      
      protected static const Ҽ:Object = {
         "disabledSkin":"downArrowDisabledSkin",
         "downSkin":"downArrowDownSkin",
         "overSkin":"downArrowOverSkin",
         "upSkin":"downArrowUpSkin",
         "repeatDelay":"repeatDelay",
         "repeatInterval":"repeatInterval"
      };
      
      protected static const ҽ:Object = {
         "disabledSkin":"thumbDisabledSkin",
         "downSkin":"thumbDownSkin",
         "overSkin":"thumbOverSkin",
         "upSkin":"thumbUpSkin",
         "icon":"thumbIcon",
         "textPadding":0
      };
      
      protected static const Ҿ:Object = {
         "disabledSkin":"trackDisabledSkin",
         "downSkin":"trackDownSkin",
         "overSkin":"trackOverSkin",
         "upSkin":"trackUpSkin",
         "repeatDelay":"repeatDelay",
         "repeatInterval":"repeatInterval"
      };
      
      protected static const ҿ:Object = {
         "disabledSkin":"upArrowDisabledSkin",
         "downSkin":"upArrowDownSkin",
         "overSkin":"upArrowOverSkin",
         "upSkin":"upArrowUpSkin",
         "repeatDelay":"repeatDelay",
         "repeatInterval":"repeatInterval"
      };
       
      
      private var ң:Number = 10;
      
      private var Ҥ:Number = 0;
      
      private var ҥ:Number = 1;
      
      private var Ҧ:Number = 0;
      
      private var ҧ:Number = 0;
      
      private var Ҩ:Number = 0;
      
      private var direction:String = "vertical";
      
      private var Ҫ:Number;
      
      protected var ҫ:Boolean = false;
      
      protected var Ҭ:ȼ;
      
      protected var ҭ:ȼ;
      
      protected var Ү:Ⱦ;
      
      protected var ү:ȼ;
      
      public function ɂ()
      {
         super();
         this.Ҝ();
         focusEnabled = false;
      }
      
      public static function getStyleDefinition() : Object
      {
         return defaultStyles ;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         if(this.direction == ɸ.HORIZONTAL)
         {
            super.setSize(param2,param1);
         }
         else
         {
            super.setSize(param1,param2);
         }
      }
      
      override public function get width() : Number
      {
         return this.direction == ɸ.HORIZONTAL?Number(super.height):Number(super.width);
      }
      
      override public function get height() : Number
      {
         return this.direction == ɸ.HORIZONTAL?Number(super.width):Number(super.height);
      }
      
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.ҭ.enabled = this.ү.enabled = this.Ү.enabled = this.Ҭ.enabled = this.enabled && this.ҧ > this.Ҧ;
         this.Һ();
      }
      
      public function Ұ(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
      {
         this.ҳ = param1;
         this.Ҧ = param2;
         this.ҧ = param3;
         if(param4 >= 0)
         {
            this.Ҥ = param4;
         }
         this.enabled = this.ҧ > this.Ҧ;
         this.ҹ(this.Ҩ,false);
         this.Һ();
      }
      
      public function get scrollPosition() : Number
      {
         return this.Ҩ;
      }
      
      public function set scrollPosition(param1:Number) : void
      {
         this.ҹ(param1,true);
      }
      
      public function get ұ() : Number
      {
         return this.Ҧ;
      }
      
      public function set ұ(param1:Number) : void
      {
         this.Ұ(this.ң,param1,this.ҧ);
      }
      
      public function get Ҳ() : Number
      {
         return this.ҧ;
      }
      
      public function set Ҳ(param1:Number) : void
      {
         this.Ұ(this.ң,this.Ҧ,param1);
      }
      
      public function get ҳ() : Number
      {
         return this.ң;
      }
      
      public function set ҳ(param1:Number) : void
      {
         if(param1 > 0)
         {
            this.ң = param1;
         }
      }
      
      public function get Ҵ() : Number
      {
         return this.Ҥ == 0?Number(this.ң):Number(this.Ҥ);
      }
      
      public function set Ҵ(param1:Number) : void
      {
         if(param1 >= 0)
         {
            this.Ҥ = param1;
         }
      }
      
      public function get lineScrollSize() : Number
      {
         return this.ҥ;
      }
      
      public function set lineScrollSize(param1:Number) : void
      {
         if(param1 > 0)
         {
            this.ҥ = param1;
         }
      }
      
      public function get direction() : String
      {
         return this.direction;
      }
      
      public function set direction(param1:String) : void
      {
         if(this.direction == param1)
         {
            return;
         }
         this.direction = param1;
         if(Я)
         {
            return;
         }
         ъ(1);
         var _loc2_:* = this.direction == ɸ.HORIZONTAL;
         if(_loc2_ && componentInspectorSetting)
         {
            if(rotation == 90)
            {
               return;
            }
            ь(-1);
            rotation = -90;
         }
         if(!componentInspectorSetting)
         {
            if(_loc2_ && rotation == 0)
            {
               rotation = -90;
               ь(-1);
            }
            else if(!_loc2_ && rotation == -90)
            {
               rotation = 0;
               ь(1);
            }
         }
         invalidate(InvalidationType.SIZE);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ү = new ȼ();
         this.ү.move(0,14);
         this.ү.useHandCursor = false;
         this.ү.ѭ = true;
         this.ү.focusEnabled = false;
         addChild(this.ү);
         this.Ү = new Ⱦ();
         this.Ү.label = "";
         this.Ү.setSize(һ,15);
         this.Ү.move(0,15);
         this.Ү.focusEnabled = false;
         addChild(this.Ү);
         this.ҭ = new ȼ();
         this.ҭ.setSize(һ,14);
         this.ҭ.ѭ = true;
         this.ҭ.focusEnabled = false;
         addChild(this.ҭ);
         this.Ҭ = new ȼ();
         this.Ҭ.setSize(һ,14);
         this.Ҭ.move(0,0);
         this.Ҭ.ѭ = true;
         this.Ҭ.focusEnabled = false;
         addChild(this.Ҭ);
         this.Ҭ.addEventListener(ComponentEvent.BUTTONDOWN,this.ҵ,false,0,true);
         this.ҭ.addEventListener(ComponentEvent.BUTTONDOWN,this.ҵ,false,0,true);
         this.ү.addEventListener(ComponentEvent.BUTTONDOWN,this.ҵ,false,0,true);
         this.Ү.addEventListener(MouseEvent.MOUSE_DOWN,this.Ҷ,false,0,true);
         this.enabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         if(ѓ(InvalidationType.SIZE))
         {
            _loc1_ = super.height;
            this.ҭ.move(0,Math.max(this.Ҭ.height,_loc1_ - this.ҭ.height));
            this.ү.setSize(һ,Math.max(0,_loc1_ - (this.ҭ.height + this.Ҭ.height)));
            this.Һ();
         }
         if(ѓ(InvalidationType.STYLES,InvalidationType.STATE))
         {
            this.Ҝ();
         }
         this.ҭ.drawNow();
         this.Ҭ.drawNow();
         this.ү.drawNow();
         this.Ү.drawNow();
         є();
      }
      
      protected function ҵ(param1:ComponentEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         param1.stopImmediatePropagation();
         if(param1.currentTarget == this.Ҭ)
         {
            this.ҹ(this.Ҩ - this.ҥ);
         }
         else if(param1.currentTarget == this.ҭ)
         {
            this.ҹ(this.Ҩ + this.ҥ);
         }
         else
         {
            _loc2_ = this.ү.mouseY / this.ү.height * (this.ҧ - this.Ҧ) + this.Ҧ;
            _loc3_ = this.Ҵ == 0?Number(this.ҳ):Number(this.Ҵ);
            if(this.Ҩ < _loc2_)
            {
               this.ҹ(Math.min(_loc2_,this.Ҩ + _loc3_));
            }
            else if(this.Ҩ > _loc2_)
            {
               this.ҹ(Math.max(_loc2_,this.Ҩ - _loc3_));
            }
         }
      }
      
      protected function Ҷ(param1:MouseEvent) : void
      {
         this.ҫ = true;
         this.Ҫ = mouseY - this.Ү.y;
         this.Ү.mouseStateLocked = true;
         mouseChildren = false;
         var _loc2_:DisplayObjectContainer = я.form;
         _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.ҷ,false,0,true);
         _loc2_.addEventListener(MouseEvent.MOUSE_UP,this.Ҹ,false,0,true);
      }
      
      protected function ҷ(param1:MouseEvent) : void
      {
         var _loc2_:Number = Math.max(0,Math.min(this.ү.height - this.Ү.height,mouseY - this.ү.y - this.Ҫ));
         this.ҹ(_loc2_ / (this.ү.height - this.Ү.height) * (this.ҧ - this.Ҧ) + this.Ҧ);
      }
      
      protected function Ҹ(param1:MouseEvent) : void
      {
         this.ҫ = false;
         mouseChildren = true;
         this.Ү.mouseStateLocked = false;
         var _loc2_:DisplayObjectContainer = я.form;
         _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,this.ҷ);
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,this.Ҹ);
      }
      
      public function ҹ(param1:Number, param2:Boolean = true) : void
      {
         var _loc3_:Number = this.scrollPosition;
         this.Ҩ = Math.max(this.Ҧ,Math.min(this.ҧ,param1));
         if(_loc3_ == this.Ҩ)
         {
            return;
         }
         if(param2)
         {
            dispatchEvent(new ScrollEvent(this.direction,this.scrollPosition - _loc3_,this.scrollPosition));
         }
         this.Һ();
      }
      
      protected function Ҝ() : void
      {
         ї(this.ҭ,Ҽ);
         ї(this.Ү,ҽ);
         ї(this.ү,Ҿ);
         ї(this.Ҭ,ҿ);
      }
      
      protected function Һ() : void
      {
         var _loc1_:Number = this.ҧ - this.Ҧ + this.ң;
         if(this.ү.height <= 12 || this.ҧ <= this.Ҧ || (_loc1_ == 0 || isNaN(_loc1_)))
         {
            this.Ү.height = 12;
            this.Ү.visible = false;
         }
         else
         {
            this.Ү.height = Math.max(13,this.ң / _loc1_ * this.ү.height);
            this.Ү.y = this.ү.y + (this.ү.height - this.Ү.height) * ((this.Ҩ - this.Ҧ) / (this.ҧ - this.Ҧ));
            this.Ү.visible = this.enabled;
         }
      }
   }
}
