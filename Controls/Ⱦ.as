package Controls
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import fl.managers.IFocusManagerComponent;
   import fl.core.UIComponent;
   import fl.core.InvalidationType;
   import mx.events.ComponentEvent;
   
   public class Ⱦ extends ȼ implements IFocusManagerComponent
   {
      
      private static var defaultStyles :Object = {
         "icon":null,
         "upIcon":null,
         "downIcon":null,
         "overIcon":null,
         "disabledIcon":null,
         "selectedDisabledIcon":null,
         "selectedUpIcon":null,
         "selectedDownIcon":null,
         "selectedOverIcon":null,
         "textFormat":null,
         "disabledTextFormat":null,
         "textPadding":5,
         "embedFonts":false
      };
      
      public static var Ѧ:Function;
       
      
      public var ѵ:TextField;
      
      protected var Ѷ:String = "right";
      
      protected var ѷ:Boolean = false;
      
      protected var icon:DisplayObject;
      
      protected var Ѹ:String;
      
      protected var ѹ:String = "ʢ";
      
      protected var Ѻ:String = "center";
      
      public function Ⱦ()
      {
         super();
      }
      
      public static function getStyleDefinition() : Object
      {
         return mergeStyles(defaultStyles ,ȼ.getStyleDefinition());
      }
      
      public function get label() : String
      {
         return this.ѹ;
      }
      
      public function set label(param1:String) : void
      {
         this.ѹ = param1;
         if(this.ѵ.text != this.ѹ)
         {
            this.ѵ.text = this.ѹ;
            dispatchEvent(new ComponentEvent(ComponentEvent.LABELCHANGE));
         }
         invalidate(InvalidationType.SIZE);
         invalidate(InvalidationType.STYLES);
      }
      
      public function get labelPlacement() : String
      {
         return this.Ѷ;
      }
      
      public function set labelPlacement(param1:String) : void
      {
         this.Ѷ = param1;
         invalidate(InvalidationType.SIZE);
      }
      
      public function get tomd5_ggle() : Boolean
      {
         return this.ѷ;
      }
      
      public function set tomd5_ggle(param1:Boolean) : void
      {
         if(!param1 && super.selected)
         {
            this.selected = false;
         }
         this.ѷ = param1;
         if(this.ѷ)
         {
            addEventListener(MouseEvent.CLICK,this.ѻ,false,0,true);
         }
         else
         {
            removeEventListener(MouseEvent.CLICK,this.ѻ);
         }
         invalidate(InvalidationType.STATE);
      }
      
      protected function ѻ(param1:MouseEvent) : void
      {
         this.selected = !this.selected;
         dispatchEvent(new Event(Event.CHANGE,true));
      }
      
      override public function get selected() : Boolean
      {
         return !!this.ѷ?Boolean(Ѩ):false;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         Ѩ = param1;
         if(this.ѷ)
         {
            invalidate(InvalidationType.STATE);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ѵ = new TextField();
         this.ѵ.type = TextFieldType.DYNAMIC;
         this.ѵ.selectable = false;
         addChild(this.ѵ);
      }
      
      override protected function draw() : void
      {
         if(this.ѵ.text != this.ѹ)
         {
            this.label = this.ѹ;
         }
         if(ѓ(InvalidationType.STYLES,InvalidationType.STATE))
         {
            ѳ();
            this.Ѽ();
            this.ѽ();
            invalidate(InvalidationType.SIZE,false);
         }
         if(ѓ(InvalidationType.SIZE))
         {
            this.Ѵ();
         }
         if(ѓ(InvalidationType.SIZE,InvalidationType.STYLES))
         {
            if(з && я.Ց)
            {
               drawFocus(true);
            }
         }
         є();
      }
      
      protected function Ѽ() : void
      {
         var _loc1_:DisplayObject = this.icon;
         var _loc2_:* = !!enabled?ѧ:"disabled";
         if(this.selected)
         {
            _loc2_ = "selected" + _loc2_.substr(0,1).toUpperCase() + _loc2_.substr(1);
         }
         _loc2_ = _loc2_ + "Icon";
         var _loc3_:Object = і(_loc2_);
         if(_loc3_ == null)
         {
            _loc3_ = і("icon");
         }
         if(_loc3_ != null)
         {
            this.icon = ѕ(_loc3_);
         }
         if(this.icon != null)
         {
            addChildAt(this.icon,1);
         }
         if(_loc1_ != null && _loc1_ != this.icon)
         {
            removeChild(_loc1_);
         }
      }
      
      protected function ѽ() : void
      {
         var _loc1_:Object = UIComponent.getStyleDefinition();
         var _loc2_:TextFormat = !!enabled?_loc1_.defaultTextFormat as TextFormat:_loc1_.defaultDisabledTextFormat as TextFormat;
         this.ѵ.setTextFormat(_loc2_);
         var _loc3_:TextFormat = і(!!enabled?"textFormat":"disabledTextFormat") as TextFormat;
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
      }
      
      protected function Ѿ() : *
      {
         var _loc1_:Object = і("embedFonts");
         if(_loc1_ != null)
         {
            this.ѵ.embedFonts = _loc1_;
         }
      }
      
      override protected function Ѵ() : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:Number = Number(і("textPadding"));
         var _loc2_:String = this.icon == null && this.Ѻ == "center"?ɶ.TOP:this.Ѷ;
         this.ѵ.height = this.ѵ.textHeight + 4;
         var _loc3_:Number = this.ѵ.textWidth + 4;
         var _loc4_:Number = this.ѵ.textHeight + 4;
         var _loc5_:Number = this.icon == null?Number(0):Number(this.icon.width + _loc1_);
         var _loc6_:Number = this.icon == null?Number(0):Number(this.icon.height + _loc1_);
         this.ѵ.visible = this.label.length > 0;
         if(this.icon != null)
         {
            this.icon.x = Math.round((width - this.icon.width) / 2);
            this.icon.y = Math.round((height - this.icon.height) / 2);
         }
         if(this.ѵ.visible == false)
         {
            this.ѵ.width = 0;
            this.ѵ.height = 0;
         }
         else if(_loc2_ == ɶ.BOTTOM || _loc2_ == ɶ.TOP)
         {
            _loc7_ = Math.max(0,Math.min(_loc3_,width - 2 * _loc1_));
            if(height - 2 > _loc4_)
            {
               _loc8_ = _loc4_;
            }
            else
            {
               _loc8_ = height - 2;
            }
            this.ѵ.width = _loc3_ = _loc7_;
            this.ѵ.height = _loc4_ = _loc8_;
            this.ѵ.x = Math.round((width - _loc3_) / 2);
            this.ѵ.y = Math.round((height - this.ѵ.height - _loc6_) / 2 + (_loc2_ == ɶ.BOTTOM?_loc6_:0));
            if(this.icon != null)
            {
               this.icon.y = Math.round(_loc2_ == ɶ.BOTTOM?Number(this.ѵ.y - _loc6_):Number(this.ѵ.y + this.ѵ.height + _loc1_));
            }
         }
         else
         {
            _loc7_ = Math.max(0,Math.min(_loc3_,width - _loc5_ - 2 * _loc1_));
            this.ѵ.width = _loc3_ = _loc7_;
            this.ѵ.x = Math.round((width - _loc3_ - _loc5_) / 2 + (_loc2_ != ɶ.LEFT?_loc5_:0));
            this.ѵ.y = Math.round((height - this.ѵ.height) / 2);
            if(this.icon != null)
            {
               this.icon.x = Math.round(_loc2_ != ɶ.LEFT?Number(this.ѵ.x - _loc5_):Number(this.ѵ.x + _loc3_ + _loc1_));
            }
         }
         super.Ѵ();
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            if(this.Ѹ == null)
            {
               this.Ѹ = ѧ;
            }
            Ѯ("down");
            ѱ();
         }
      }
      
      override protected function keyUpHandler(param1:KeyboardEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            Ѯ(this.Ѹ);
            this.Ѹ = null;
            Ѳ();
            dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override protected function initializeAccessibility() : void
      {
         if(Ⱦ.Ѧ != null)
         {
            Ⱦ.Ѧ(this);
         }
      }
   }
}
