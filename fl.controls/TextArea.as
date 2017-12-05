package fl.controls
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.system.IME;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import flash.ui.Keyboard;
   import fl.managers.IFocusManagerComponent;
   import fl.managers.IFocusManager;
   import fl.core.UIComponent;
   import fl.core.InvalidationType;
   import mx.events.ComponentEvent;
   import mx.events.ScrollEvent;
   
   public class TextArea extends UIComponent implements IFocusManagerComponent
   {
      
      private static var defaultStyles :Object = {
         "upSkin":"TextArea_upSkin",
         "disabledSkin":"TextArea_disabledSkin",
         "focusRectSkin":null,
         "focusRectPadding":null,
         "textFormat":null,
         "disabledTextFormat":null,
         "textPadding":3,
         "embedFonts":false
      };
      
      protected static const Ң:Object = {
         "downArrowDisabledSkin":"downArrowDisabledSkin",
         "downArrowDownSkin":"downArrowDownSkin",
         "downArrowOverSkin":"downArrowOverSkin",
         "downArrowUpSkin":"downArrowUpSkin",
         "upArrowDisabledSkin":"upArrowDisabledSkin",
         "upArrowDownSkin":"upArrowDownSkin",
         "upArrowOverSkin":"upArrowOverSkin",
         "upArrowUpSkin":"upArrowUpSkin",
         "thumbDisabledSkin":"thumbDisabledSkin",
         "thumbDownSkin":"thumbDownSkin",
         "thumbOverSkin":"thumbOverSkin",
         "thumbUpSkin":"thumbUpSkin",
         "thumbIcon":"thumbIcon",
         "trackDisabledSkin":"trackDisabledSkin",
         "trackDownSkin":"trackDownSkin",
         "trackOverSkin":"trackOverSkin",
         "trackUpSkin":"trackUpSkin",
         "repeatDelay":"repeatDelay",
         "repeatInterval":"repeatInterval"
      };
      
      public static var Ѧ:Function;
       
      
      public var ѵ:TextField;
      
      protected var §҃§:Boolean = true;
      
      protected var §҄§:Boolean = true;
      
      protected var §҅§:String = "auto";
      
      protected var §҆§:String = "auto";
      
      protected var §҇§:UIScrollBar;
      
      protected var §҈§:UIScrollBar;
      
      protected var background:DisplayObject;
      
      protected var §҉§:Boolean = false;
      
      protected var Ҋ:String;
      
      protected var ҋ:Boolean = false;
      
      public function TextArea()
      {
         super();
      }
      
      public static function getStyleDefinition() : Object
      {
         return UIComponent.mergeStyles(defaultStyles ,ScrollBar.getStyleDefinition());
      }
      
      public function get Ҍ() : UIScrollBar
      {
         return this.§҇§;
      }
      
      public function get ҍ() : UIScrollBar
      {
         return this.§҈§;
      }
      
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = this.enabled;
         invalidate(InvalidationType.STATE);
      }
      
      public function get text() : String
      {
         return this.ѵ.text;
      }
      
      public function set text(param1:String) : void
      {
         if(componentInspectorSetting && param1 == "")
         {
            return;
         }
         this.ѵ.text = param1;
         this.§҉§ = false;
         invalidate(InvalidationType.DATA);
         invalidate(InvalidationType.STYLES);
         this.ҋ = true;
      }
      
      public function get htmlText() : String
      {
         return this.ѵ.htmlText;
      }
      
      public function set htmlText(param1:String) : void
      {
         if(componentInspectorSetting && param1 == "")
         {
            return;
         }
         if(param1 == "")
         {
            this.text = "";
            return;
         }
         this.§҉§ = true;
         this.Ҋ = param1;
         this.ѵ.htmlText = param1;
         invalidate(InvalidationType.DATA);
         invalidate(InvalidationType.STYLES);
         this.ҋ = true;
      }
      
      public function get condenseWhite() : Boolean
      {
         return this.ѵ.condenseWhite;
      }
      
      public function set condenseWhite(param1:Boolean) : void
      {
         this.ѵ.condenseWhite = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function get Ҏ() : String
      {
         return this.§҅§;
      }
      
      public function set Ҏ(param1:String) : void
      {
         this.§҅§ = param1;
         invalidate(InvalidationType.SIZE);
      }
      
      public function get ҏ() : String
      {
         return this.§҆§;
      }
      
      public function set ҏ(param1:String) : void
      {
         this.§҆§ = param1;
         invalidate(InvalidationType.SIZE);
      }
      
      public function get Ґ() : Number
      {
         return this.ѵ.scrollH;
      }
      
      public function set Ґ(param1:Number) : void
      {
         drawNow();
         this.ѵ.scrollH = param1;
      }
      
      public function get ґ() : Number
      {
         return this.ѵ.scrollV;
      }
      
      public function set ґ(param1:Number) : void
      {
         drawNow();
         this.ѵ.scrollV = param1;
      }
      
      public function get textWidth() : Number
      {
         drawNow();
         return this.ѵ.textWidth;
      }
      
      public function get textHeight() : Number
      {
         drawNow();
         return this.ѵ.textHeight;
      }
      
      public function get length() : Number
      {
         return this.ѵ.text.length;
      }
      
      public function get restrict() : String
      {
         return this.ѵ.restrict;
      }
      
      public function set restrict(param1:String) : void
      {
         if(componentInspectorSetting && param1 == "")
         {
            param1 = null;
         }
         this.ѵ.restrict = param1;
      }
      
      public function get maxChars() : int
      {
         return this.ѵ.maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         this.ѵ.maxChars = param1;
      }
      
      public function get Ғ() : int
      {
         return this.ѵ.maxScrollH;
      }
      
      public function get ғ() : int
      {
         return this.ѵ.maxScrollV;
      }
      
      public function get wordWrap() : Boolean
      {
         return this.§҄§;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         this.§҄§ = param1;
         invalidate(InvalidationType.STATE);
      }
      
      public function get selectionBeginIndex() : int
      {
         return this.ѵ.selectionBeginIndex;
      }
      
      public function get selectionEndIndex() : int
      {
         return this.ѵ.selectionEndIndex;
      }
      
      public function get displayAsPassword() : Boolean
      {
         return this.ѵ.displayAsPassword;
      }
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         this.ѵ.displayAsPassword = param1;
      }
      
      public function get Ҕ() : Boolean
      {
         return this.§҃§;
      }
      
      public function set Ҕ(param1:Boolean) : void
      {
         this.§҃§ = param1;
         invalidate(InvalidationType.STATE);
      }
      
      public function get ҕ() : String
      {
         return IME.conversionMode;
      }
      
      public function set ҕ(param1:String) : void
      {
         р = param1;
      }
      
      public function get alwaysShowSelection() : Boolean
      {
         return this.ѵ.alwaysShowSelection;
      }
      
      public function set alwaysShowSelection(param1:Boolean) : void
      {
         this.ѵ.alwaysShowSelection = param1;
      }
      
      override public function drawFocus(param1:Boolean) : void
      {
         if(Ю != null)
         {
            Ю.drawFocus(param1);
            return;
         }
         super.drawFocus(param1);
      }
      
      public function getLineMetrics(param1:int) : TextLineMetrics
      {
         return this.ѵ.getLineMetrics(param1);
      }
      
      public function setSelection(param1:int, param2:int) : void
      {
         this.ѵ.setSelection(param1,param2);
      }
      
      public function appendText(param1:String) : void
      {
         this.ѵ.appendText(param1);
         invalidate(InvalidationType.DATA);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tabChildren = true;
         this.ѵ = new TextField();
         addChild(this.ѵ);
         this.Җ();
         this.§҈§ = new UIScrollBar();
         this.§҈§.name = "V";
         this.§҈§.visible = false;
         this.§҈§.focusEnabled = false;
         ї(this.§҈§,Ң);
         this.§҈§.addEventListener(ScrollEvent.SCROLL,this.Қ,false,0,true);
         addChild(this.§҈§);
         this.§҇§ = new UIScrollBar();
         this.§҇§.name = "H";
         this.§҇§.visible = false;
         this.§҇§.focusEnabled = false;
         this.§҇§.direction = ScrollBarDirection.HORIZONTAL;
         ї(this.§҇§,Ң);
         this.§҇§.addEventListener(ScrollEvent.SCROLL,this.Қ,false,0,true);
         addChild(this.§҇§);
         this.ѵ.addEventListener(TextEvent.TEXT_INPUT,this.ҙ,false,0,true);
         this.ѵ.addEventListener(Event.CHANGE,this.Ҙ,false,0,true);
         this.ѵ.addEventListener(KeyboardEvent.KEY_DOWN,this.җ,false,0,true);
         this.§҇§.Ӆ = this.ѵ;
         this.§҈§.Ӆ = this.ѵ;
         addEventListener(MouseEvent.MOUSE_WHEEL,this.қ,false,0,true);
      }
      
      protected function Җ() : void
      {
         this.ѵ.type = this.enabled && this.§҃§?TextFieldType.INPUT:TextFieldType.DYNAMIC;
         this.ѵ.selectable = this.enabled;
         this.ѵ.wordWrap = this.§҄§;
         this.ѵ.multiline = true;
      }
      
      protected function җ(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            dispatchEvent(new ComponentEvent(ComponentEvent.ENTER,true));
         }
      }
      
      protected function Ҙ(param1:Event) : void
      {
         param1.stopPropagation();
         dispatchEvent(new Event(Event.CHANGE,true));
         invalidate(InvalidationType.DATA);
      }
      
      protected function ҙ(param1:TextEvent) : void
      {
         param1.stopPropagation();
         dispatchEvent(new TextEvent(TextEvent.TEXT_INPUT,true,false,param1.text));
      }
      
      protected function Қ(param1:ScrollEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function қ(param1:MouseEvent) : void
      {
         if(!this.enabled || !this.§҈§.visible)
         {
            return;
         }
         this.§҈§.scrollPosition = this.§҈§.scrollPosition - param1.delta * this.§҈§.lineScrollSize;
         dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL,param1.delta * this.§҈§.lineScrollSize,this.§҈§.scrollPosition));
      }
      
      protected function Ѿ() : *
      {
         var _loc1_:Object = і("embedFonts");
         if(_loc1_ != null)
         {
            this.ѵ.embedFonts = _loc1_;
         }
      }
      
      override protected function draw() : void
      {
         if(ѓ(InvalidationType.STATE))
         {
            this.Җ();
         }
         if(ѓ(InvalidationType.STYLES))
         {
            this.Ҝ();
            this.Ѿ();
         }
         if(ѓ(InvalidationType.STYLES,InvalidationType.STATE))
         {
            this.ѽ();
            this.ѳ();
            invalidate(InvalidationType.SIZE,false);
         }
         if(ѓ(InvalidationType.SIZE,InvalidationType.DATA))
         {
            this.Ѵ();
         }
         super.draw();
      }
      
      protected function Ҝ() : void
      {
         ї(this.§҈§,Ң);
         ї(this.§҇§,Ң);
      }
      
      protected function ѽ() : void
      {
         var _loc1_:Object = UIComponent.getStyleDefinition();
         var _loc2_:TextFormat = !!this.enabled?_loc1_.defaultTextFormat as TextFormat:_loc1_.defaultDisabledTextFormat as TextFormat;
         this.ѵ.setTextFormat(_loc2_);
         var _loc3_:TextFormat = і(!!this.enabled?"textFormat":"disabledTextFormat") as TextFormat;
         if(_loc3_ != null)
         {
            this.ѵ.setTextFormat(_loc3_);
         }
         else
         {
            _loc3_ = _loc2_;
         }
         this.ѵ.defaultTextFormat = _loc3_;
         this.Ѿ();
         if(this.§҉§)
         {
            this.ѵ.htmlText = this.Ҋ;
         }
      }
      
      protected function ѳ() : void
      {
         var _loc1_:DisplayObject = this.background;
         var _loc2_:String = !!this.enabled?"upSkin":"disabledSkin";
         this.background = ѕ(і(_loc2_));
         if(this.background != null)
         {
            addChildAt(this.background,0);
         }
         if(_loc1_ != null && _loc1_ != this.background && contains(_loc1_))
         {
            removeChild(_loc1_);
         }
      }
      
      protected function Ѵ() : void
      {
         var _loc1_:Number = Number(і("textPadding"));
         this.ѵ.x = this.ѵ.y = _loc1_;
         this.background.width = width;
         this.background.height = height;
         var _loc2_:Number = height;
         var _loc3_:Boolean = this.ҟ();
         var _loc4_:Number = width - (!!_loc3_?this.§҈§.width:0);
         var _loc5_:Boolean = this.Ҡ();
         if(_loc5_)
         {
            _loc2_ = _loc2_ - this.§҇§.height;
         }
         this.ҡ(_loc4_,_loc2_,_loc1_);
         if(_loc5_ && !_loc3_ && this.ҟ())
         {
            _loc3_ = true;
            _loc4_ = _loc4_ - this.§҈§.width;
            this.ҡ(_loc4_,_loc2_,_loc1_);
         }
         if(_loc3_)
         {
            this.§҈§.visible = true;
            this.§҈§.x = width - this.§҈§.width;
            this.§҈§.height = _loc2_;
            this.§҈§.visible = true;
            this.§҈§.enabled = this.enabled;
         }
         else
         {
            this.§҈§.visible = false;
         }
         if(_loc5_)
         {
            this.§҇§.visible = true;
            this.§҇§.y = height - this.§҇§.height;
            this.§҇§.width = _loc4_;
            this.§҇§.visible = true;
            this.§҇§.enabled = this.enabled;
         }
         else
         {
            this.§҇§.visible = false;
         }
         this.Ҟ();
         addEventListener(Event.ENTER_FRAME,this.ҝ,false,0,true);
      }
      
      protected function ҝ(param1:Event) : void
      {
         if(this.ҋ)
         {
            this.ҋ = false;
            this.Ѵ();
            return;
         }
         removeEventListener(Event.ENTER_FRAME,this.ҝ);
      }
      
      protected function Ҟ() : *
      {
         this.§҇§.update();
         this.§҈§.update();
         this.§҈§.enabled = this.enabled;
         this.§҇§.enabled = this.enabled;
         this.§҇§.drawNow();
         this.§҈§.drawNow();
      }
      
      protected function ҟ() : Boolean
      {
         if(this.§҆§ == ScrollPolicy.OFF)
         {
            return false;
         }
         if(this.§҆§ == ScrollPolicy.ON)
         {
            return true;
         }
         return this.ѵ.maxScrollV > 1;
      }
      
      protected function Ҡ() : Boolean
      {
         if(this.§҅§ == ScrollPolicy.OFF)
         {
            return false;
         }
         if(this.§҅§ == ScrollPolicy.ON)
         {
            return true;
         }
         return this.ѵ.maxScrollH > 0;
      }
      
      protected function ҡ(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = param1 - param3 * 2;
         var _loc5_:Number = param2 - param3 * 2;
         if(_loc4_ != this.ѵ.width)
         {
            this.ѵ.width = _loc4_;
         }
         if(_loc5_ != this.ѵ.height)
         {
            this.ѵ.height = _loc5_;
         }
      }
      
      override protected function ў(param1:DisplayObject) : Boolean
      {
         return param1 == this.ѵ || super.ў(param1);
      }
      
      override protected function focusInHandler(param1:FocusEvent) : void
      {
         ё(true);
         if(param1.target == this)
         {
            stage.focus = this.ѵ;
         }
         var _loc2_:IFocusManager = я;
         if(_loc2_)
         {
            if(this.Ҕ)
            {
               _loc2_.Ց = true;
            }
            _loc2_.Տ = false;
         }
         super.focusInHandler(param1);
         if(this.Ҕ)
         {
            ё(true);
         }
      }
      
      override protected function focusOutHandler(param1:FocusEvent) : void
      {
         var _loc2_:IFocusManager = я;
         if(_loc2_)
         {
            _loc2_.Տ = true;
         }
         this.setSelection(0,0);
         super.focusOutHandler(param1);
         if(this.Ҕ)
         {
            ё(false);
         }
      }
   }
}
