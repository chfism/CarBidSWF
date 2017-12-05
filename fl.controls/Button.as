package fl.controls
{
   import flash.display.DisplayObject;
   import fl.managers.IFocusManagerComponent;
   import fl.core.UIComponent;
   import fl.core.InvalidationType;
   
   public class Button extends LabelButton implements IFocusManagerComponent
   {
      
      private static var defaultStyles :Object = {
         "emphasizedSkin":"Button_emphasizedSkin",
         "emphasizedPadding":2
      };
      
      public static var Ѧ:Function;
       
      
      protected var _emphasized:Boolean = false;
      
      protected var Ҁ:DisplayObject;
      
      public function Button()
      {
         super();
      }
      
      public static function getStyleDefinition() : Object
      {
         return UIComponent.mergeStyles(LabelButton.getStyleDefinition(),defaultStyles );
      }
      
      public function get ҁ() : Boolean
      {
         return this._emphasized;
      }
      
      public function set ҁ(param1:Boolean) : void
      {
         this._emphasized = param1;
         invalidate(InvalidationType.STYLES);
      }
      
      override protected function draw() : void
      {
         if(ѓ(InvalidationType.STYLES) || ѓ(InvalidationType.SIZE))
         {
            this.§҂§();
         }
         super.draw();
         if(this.Ҁ != null)
         {
            setChildIndex(this.Ҁ,numChildren - 1);
         }
      }
      
      protected function §҂§() : void
      {
         var _loc2_:Number = NaN;
         if(this.Ҁ != null)
         {
            removeChild(this.Ҁ);
         }
         this.Ҁ = null;
         if(!this._emphasized)
         {
            return;
         }
         var _loc1_:Object = і("emphasizedSkin");
         if(_loc1_ != null)
         {
            this.Ҁ = ѕ(_loc1_);
         }
         if(this.Ҁ != null)
         {
            addChildAt(this.Ҁ,0);
            _loc2_ = Number(і("emphasizedPadding"));
            this.Ҁ.x = this.Ҁ.y = -_loc2_;
            this.Ҁ.width = width + _loc2_ * 2;
            this.Ҁ.height = height + _loc2_ * 2;
         }
      }
      
      override public function drawFocus(param1:Boolean) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = undefined;
         super.drawFocus(param1);
         if(param1)
         {
            _loc2_ = Number(і("emphasizedPadding"));
            if(_loc2_ < 0 || !this._emphasized)
            {
               _loc2_ = 0;
            }
            _loc3_ = і("focusRectPadding");
            _loc3_ = _loc3_ == null?2:_loc3_;
            _loc3_ = _loc3_ + _loc2_;
            ж.x = -_loc3_;
            ж.y = -_loc3_;
            ж.width = width + _loc3_ * 2;
            ж.height = height + _loc3_ * 2;
         }
      }
      
      override protected function initializeAccessibility() : void
      {
         if(Button.Ѧ != null)
         {
            Button.Ѧ(this);
         }
      }
   }
}
