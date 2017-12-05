package fl.core
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectBidInitView;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.system.IME;
   import flash.system.IMEConversionMode;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import fl.managers.IFocusManagerComponent;
   import fl.managers.IFocusManager;
   import fl.managers.FocusManager;
   import fl.managers.StyleManager;
   import mx.events.ComponentEvent;
   
   public class UIComponent extends Sprite
   {
      
      public static var Ѣ:Boolean = false;
      
      private static var defaultStyles :Object = {
         "focusRectSkin":"focusRectSkin",
         "focusRectPadding":2,
         "textFormat":new TextFormat("_sans",11,0,false,false,false,"","",TextFormatAlign.LEFT,0,0,0,0),
         "disabledTextFormat":new TextFormat("_sans",11,10066329,false,false,false,"","",TextFormatAlign.LEFT,0,0,0,0),
         "defaultTextFormat":new TextFormat("_sans",11,0,false,false,false,"","",TextFormatAlign.LEFT,0,0,0,0),
         "defaultDisabledTextFormat":new TextFormat("_sans",11,10066329,false,false,false,"","",TextFormatAlign.LEFT,0,0,0,0)
      };
      
      private static var Ѥ:Dictionary = new Dictionary(true);
      
      private static var ѥ:Dictionary = new Dictionary(true);
      
      public static var Ѧ:Function;
       
      
      public const version:String = "3.0.4.1";
      
      public var Ю:IFocusManagerComponent;
      
      protected var Я:Boolean = false;
      
      private var а:TextField;
      
      protected var б:Object;
      
      protected var в:Object;
      
      protected var г:Dictionary;
      
      protected var handler:Boolean = false;
      
      protected var _enabled:Boolean = true;
      
      protected var е:Object;
      
      protected var ж:DisplayObject;
      
      protected var з:Boolean = false;
      
      private var и:Boolean = true;
      
      private var й:Boolean = true;
      
      protected var к:Number;
      
      protected var л:Number;
      
      protected var м:Number;
      
      protected var н:Number;
      
      protected var о:Number;
      
      protected var п:Number;
      
      protected var р:String = null;
      
      protected var с:String = null;
      
      protected var Reader0to0Handler:Boolean = false;
      
      protected var у:Boolean = false;
      
      public function UIComponent()
      {
         super();
         this.б = {};
         this.в = {};
         this.е = {};
         this.г = new Dictionary();
         StyleManager.վ(this);
         this.configUI();
         this.invalidate(InvalidationType.ALL);
         tabEnabled = this is IFocusManagerComponent;
         focusRect = false;
         if(tabEnabled)
         {
            addEventListener(FocusEvent.FOCUS_IN,this.focusInHandler);
            addEventListener(FocusEvent.FOCUS_OUT,this.focusOutHandler);
            addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
            addEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
         }
         this.њ();
         addEventListener(Event.ENTER_FRAME,this.ѡ,false,0,true);
      }
      
      public static function getStyleDefinition() : Object
      {
         return defaultStyles ;
      }
      
      public static function mergeStyles(... rest) : Object
      {
         var _loc5_:Object = null;
         var _loc6_:* = null;
         var _loc2_:Object = {};
         var _loc3_:uint = rest.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = rest[_loc4_];
            for(_loc6_ in _loc5_)
            {
               if(_loc2_[_loc6_] == null)
               {
                  _loc2_[_loc6_] = rest[_loc4_][_loc6_];
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get componentInspectorSetting() : Boolean
      {
         return this.у;
      }
      
      public function set componentInspectorSetting(param1:Boolean) : void
      {
         this.у = param1;
         if(this.у)
         {
            this.ф();
         }
         else
         {
            this.х();
         }
      }
      
      protected function ф() : void
      {
      }
      
      protected function х() : void
      {
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(param1 == this._enabled)
         {
            return;
         }
         this._enabled = param1;
         this.invalidate(InvalidationType.STATE);
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this.к = param1;
         this.л = param2;
         this.invalidate(InvalidationType.SIZE);
         dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE,false));
      }
      
      override public function get width() : Number
      {
         return this.к;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this.к == param1)
         {
            return;
         }
         this.setSize(param1,this.height);
      }
      
      override public function get height() : Number
      {
         return this.л;
      }
      
      override public function set height(param1:Number) : void
      {
         if(this.л == param1)
         {
            return;
         }
         this.setSize(this.width,param1);
      }
      
      public function ц(param1:String, param2:Object) : void
      {
         if(this.б[param1] === param2 && !(param2 is TextFormat))
         {
            return;
         }
         this.б[param1] = param2;
         this.invalidate(InvalidationType.STYLES);
      }
      
      public function ч(param1:String) : void
      {
         this.ц(param1,null);
      }
      
      public function ш(param1:String) : Object
      {
         return this.б[param1];
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         this.м = param1;
         this.н = param2;
         super.x = Math.round(param1);
         super.y = Math.round(param2);
         dispatchEvent(new ComponentEvent(ComponentEvent.MOVE));
      }
      
      override public function get x() : Number
      {
         return !!isNaN(this.м)?Number(super.x):Number(this.м);
      }
      
      override public function set x(param1:Number) : void
      {
         this.move(param1,this.н);
      }
      
      override public function get y() : Number
      {
         return !!isNaN(this.н)?Number(super.y):Number(this.н);
      }
      
      override public function set y(param1:Number) : void
      {
         this.move(this.м,param1);
      }
      
      override public function get scaleX() : Number
      {
         return this.width / this.о;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         this.setSize(this.о * param1,this.height);
      }
      
      override public function get scaleY() : Number
      {
         return this.height / this.п;
      }
      
      override public function set scaleY(param1:Number) : void
      {
         this.setSize(this.width,this.п * param1);
      }
      
      protected function щ() : Number
      {
         return super.scaleY;
      }
      
      protected function ъ(param1:Number) : void
      {
         super.scaleY = param1;
      }
      
      protected function ы() : Number
      {
         return super.scaleX;
      }
      
      protected function ь(param1:Number) : void
      {
         super.scaleX = param1;
      }
      
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible == param1)
         {
            return;
         }
         super.visible = param1;
         var _loc2_:String = !!param1?ComponentEvent.SHOW:ComponentEvent.HIDE;
         dispatchEvent(new ComponentEvent(_loc2_,true));
      }
      
      public function э() : void
      {
         this.invalidate(InvalidationType.ALL,false);
         this.draw();
      }
      
      public function invalidate(param1:String = "all", param2:Boolean = true) : void
      {
         this.е[param1] = true;
         if(param2)
         {
            this.ј(this.draw);
         }
      }
      
      public function ю(param1:String, param2:Object) : void
      {
         if(this.в[param1] === param2 && !(param2 is TextFormat))
         {
            return;
         }
         this.в[param1] = param2;
         if(this.б[param1] == null)
         {
            this.invalidate(InvalidationType.STYLES);
         }
      }
      
      public function get focusEnabled() : Boolean
      {
         return this.и;
      }
      
      public function set focusEnabled(param1:Boolean) : void
      {
         this.и = param1;
      }
      
      public function get mouseFocusEnabled() : Boolean
      {
         return this.й;
      }
      
      public function set mouseFocusEnabled(param1:Boolean) : void
      {
         this.й = param1;
      }
      
      public function get я() : IFocusManager
      {
         var o:DisplayObject = this;
         while(o)
         {
            if(UIComponent.Ѥ[o] != null)
            {
               return IFocusManager(UIComponent.Ѥ[o]);
            }
            try
            {
               o = o.parent;
            }
            catch(se:SecurityError)
            {
               return null;
            }
         }
         return null;
      }
      
      public function set я(param1:IFocusManager) : void
      {
         UIComponent.Ѥ[this] = param1;
      }
      
      public function drawFocus(param1:Boolean) : void
      {
         var _loc2_:Number = NaN;
         this.з = param1;
         if(this.ж != null && contains(this.ж))
         {
            removeChild(this.ж);
            this.ж = null;
         }
         if(param1)
         {
            this.ж = this.ѕ(this.і("focusRectSkin")) as Sprite;
            if(this.ж == null)
            {
               return;
            }
            _loc2_ = Number(this.і("focusRectPadding"));
            this.ж.x = -_loc2_;
            this.ж.y = -_loc2_;
            this.ж.width = this.width + _loc2_ * 2;
            this.ж.height = this.height + _loc2_ * 2;
            addChildAt(this.ж,0);
         }
      }
      
      public function setFocus() : void
      {
         if(stage)
         {
            stage.focus = this;
         }
      }
      
      public function main() : InteractiveObject
      {
         if(stage)
         {
            return stage.focus;
         }
         return null;
      }
      
      protected function ё(param1:Boolean) : *
      {
         var enabled:Boolean = param1;
         if(this.р != null)
         {
            if(enabled)
            {
               IME.enabled = true;
               this.с = IME.conversionMode;
               try
               {
                  if(!this.Reader0to0Handler && IME.conversionMode != IMEConversionMode.UNKNOWN)
                  {
                     IME.conversionMode = this.р;
                  }
                  this.Reader0to0Handler = false;
                  return;
               }
               catch(e:Error)
               {
                  Reader0to0Handler = true;
                  throw new Error("IME mode not supported: " + р);
               }
            }
            else
            {
               if(IME.conversionMode != IMEConversionMode.UNKNOWN && this.с != IMEConversionMode.UNKNOWN)
               {
                  IME.conversionMode = this.с;
               }
               IME.enabled = false;
            }
         }
      }
      
      public function drawNow() : void
      {
         this.draw();
      }
      
      protected function configUI() : void
      {
         this.Я = this.ђ();
         var _loc1_:Number = rotation;
         rotation = 0;
         var _loc2_:Number = super.width;
         var _loc3_:Number = super.height;
         super.scaleY = 1;
         super.scaleX = 1;
         this.setSize(_loc2_,_loc3_);
         this.move(super.x,super.y);
         rotation = _loc1_;
         this.о = _loc2_;
         this.п = _loc3_;
         if(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      protected function ђ() : Boolean
      {
         var _loc1_:String = null;
         if(parent == null)
         {
            return false;
         }
         try
         {
            _loc1_ = getQualifiedClassName(parent);
         }
         catch(e:Error)
         {
         }
         return _loc1_ == "fl.livepreview::LivePreviewParent";
      }
      
      protected function ѓ(param1:String, ... rest) : Boolean
      {
         if(this.е[param1] || this.е[InvalidationType.ALL])
         {
            return true;
         }
         while(rest.length > 0)
         {
            if(this.е[rest.pop()])
            {
               return true;
            }
         }
         return false;
      }
      
      protected function є() : void
      {
         this.е = {};
      }
      
      protected function draw() : void
      {
         if(this.ѓ(InvalidationType.SIZE,InvalidationType.STYLES))
         {
            if(this.з && this.я.Ց)
            {
               this.drawFocus(true);
            }
         }
         this.є();
      }
      
      protected function ѕ(param1:Object) : DisplayObject
      {
         var skin:Object = param1;
         var ݪ:Object = null;
         var ݫ:Object = null;
         if(skin is Class)
         {
            ݪ = new skin();
            if(ݪ is BitmapData)
            {
               return new Bitmap(ݪ as BitmapData);
            }
            return ݪ as DisplayObject;
         }
         if(skin is DisplayObject)
         {
            (skin as DisplayObject).x = 0;
            (skin as DisplayObject).y = 0;
            return skin as DisplayObject;
         }
         if(skin is BitmapData)
         {
            return new Bitmap(skin as BitmapData);
         }
         try
         {
            ݫ = getDefinitionByName(skin.toString());
         }
         catch(e:Error)
         {
            try
            {
               ݫ = loaderInfo.applicationDomain.getDefinition(skin.toString()) as Object;
            }
            catch(e:Error)
            {
            }
         }
         if(ݫ == null)
         {
            return null;
         }
         ݪ = new ݫ();
         if(ݪ is BitmapData)
         {
            return new Bitmap(ݪ as BitmapData);
         }
         return ݪ as DisplayObject;
      }
      
      protected function і(param1:String) : Object
      {
         return this.б[param1] == null?this.в[param1]:this.б[param1];
      }
      
      protected function ї(param1:UIComponent, param2:Object) : void
      {
         var _loc3_:* = null;
         for(_loc3_ in param2)
         {
            param1.ц(_loc3_,this.і(param2[_loc3_]));
         }
      }
      
      protected function ј(param1:Function) : void
      {
         var ݬ:Function = param1;
         if(Ѣ)
         {
            return;
         }
         this.г[ݬ] = true;
         if(stage != null)
         {
            try
            {
               stage.addEventListener(Event.RENDER,this.љ,false,0,true);
               stage.invalidate();
               return;
            }
            catch(se:SecurityError)
            {
               addEventListener(Event.ENTER_FRAME,љ,false,0,true);
               return;
            }
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.љ,false,0,true);
         }
      }
      
      private function љ(param1:Event) : void
      {
         var method:Object = null;
         var Event:Event = param1;
         if(Event.type == Event.ADDED_TO_STAGE)
         {
            try
            {
               removeEventListener(Event.ADDED_TO_STAGE,this.љ);
               stage.addEventListener(Event.RENDER,this.љ,false,0,true);
               stage.invalidate();
               return;
            }
            catch(se1:SecurityError)
            {
               addEventListener(Event.ENTER_FRAME,љ,false,0,true);
            }
            Ѣ = true;
            var ݭ:Dictionary = this.г;
            for(method in ݭ)
            {
               method();
               delete ݭ[method];
            }
            Ѣ = false;
            return;
         }
         Event.target.removeEventListener(Event.RENDER,this.љ);
         Event.target.removeEventListener(Event.ENTER_FRAME,this.љ);
         try
         {
            if(stage == null)
            {
               addEventListener(Event.ADDED_TO_STAGE,this.љ,false,0,true);
               return;
            }
         }
         catch(se2:SecurityError)
         {
         }
         Ѣ = true;
         ݭ = this.г;
         addr142:
         for(method in ݭ)
         {
            method();
            delete ݭ[method];
            §§goto(addr142);
         }
         Ѣ = false;
      }
      
      private function њ() : void
      {
         var _loc1_:IFocusManager = null;
         var _loc2_:Dictionary = null;
         if(stage == null)
         {
            addEventListener(Event.ADDED_TO_STAGE,this.addedHandler,false,0,true);
         }
         else
         {
            this.ѝ();
            _loc1_ = this.я;
            if(_loc1_ != null)
            {
               _loc2_ = ѥ[_loc1_];
               if(_loc2_ == null)
               {
                  _loc2_ = new Dictionary(true);
                  ѥ[_loc1_] = _loc2_;
               }
               _loc2_[this] = true;
            }
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedHandler);
      }
      
      private function addedHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedHandler);
         this.њ();
      }
      
      private function removedHandler(param1:Event) : void
      {
         var _loc3_:Dictionary = null;
         var _loc4_:Boolean = false;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:IFocusManager = null;
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedHandler);
         addEventListener(Event.ADDED_TO_STAGE,this.addedHandler);
         var _loc2_:IFocusManager = this.я;
         if(_loc2_ != null)
         {
            _loc3_ = ѥ[_loc2_];
            if(_loc3_ != null)
            {
               delete _loc3_[this];
               _loc4_ = true;
               for(_loc5_ in _loc3_)
               {
                  _loc4_ = false;
               }
               if(_loc4_)
               {
                  delete ѥ[_loc2_];
                  _loc3_ = null;
               }
            }
            if(_loc3_ == null)
            {
               _loc2_.deactivate();
               for(_loc6_ in Ѥ)
               {
                  _loc7_ = Ѥ[_loc6_];
                  if(_loc2_ == _loc7_)
                  {
                     delete Ѥ[_loc6_];
                  }
               }
            }
         }
      }
      
      protected function ѝ() : void
      {
         var ݮ:Boolean = true;
         try
         {
            stage.getChildAt(0);
         }
         catch(se:SecurityError)
         {
            ݮ = false;
         }
         var ݯ:DisplayObjectBidInitView = null;
         if(ݮ)
         {
            ݯ = stage;
         }
         else
         {
            ݯ = this;
            try
            {
               while(ݯ.parent != null)
               {
                  ݯ = ݯ.parent;
               }
            }
            catch(se:SecurityError)
            {
            }
         }
         if(Ѥ[ݯ] == null)
         {
            Ѥ[ݯ] = new FocusManager(ݯ);
         }
      }
      
      protected function ў(param1:DisplayObject) : Boolean
      {
         return param1 == this;
      }
      
      protected function focusInHandler(param1:FocusEvent) : void
      {
         var _loc2_:IFocusManager = null;
         if(this.ў(param1.target as DisplayObject))
         {
            _loc2_ = this.я;
            if(_loc2_ && _loc2_.Ց)
            {
               this.drawFocus(true);
               this.з = true;
            }
         }
      }
      
      protected function focusOutHandler(param1:FocusEvent) : void
      {
         if(this.ў(param1.target as DisplayObject))
         {
            this.drawFocus(false);
            this.з = false;
         }
      }
      
      protected function keyDownHandler(param1:KeyboardEvent) : void
      {
      }
      
      protected function keyUpHandler(param1:KeyboardEvent) : void
      {
      }
      
      protected function ѡ(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.ѡ);
         this.initializeAccessibility();
      }
      
      protected function initializeAccessibility() : void
      {
         if(UIComponent.Ѧ != null)
         {
            UIComponent.Ѧ(this);
         }
      }
   }
}
