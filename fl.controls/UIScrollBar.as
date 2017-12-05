package fl.controls
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TextEvent;
   import fl.core.UIComponent;
   import fl.core.InvalidationType;
   import ɴ.ScrollEvent;
   
   public class UIScrollBar extends ScrollBar
   {
      
      private static var defaultStyles :Object = {};
       
      
      protected var Ӏ:DisplayObject;
      
      protected var inEdit:Boolean = false;
      
      protected var ӂ:Boolean = false;
      
      protected var Ӄ:String;
      
      protected var ӄ:String;
      
      public function UIScrollBar()
      {
         super();
      }
      
      public static function getStyleDefinition() : Object
      {
         return UIComponent.mergeStyles(defaultStyles ,ScrollBar.getStyleDefinition());
      }
      
      override public function set ұ(param1:Number) : void
      {
         super.ұ = param1 < 0?Number(0):Number(param1);
      }
      
      override public function set Ҳ(param1:Number) : void
      {
         var _loc2_:Number = param1;
         if(this.Ӏ != null)
         {
            _loc2_ = Math.min(_loc2_,this.Ӏ[this.ӄ]);
         }
         super.Ҳ = _loc2_;
      }
      
      public function get Ӆ() : DisplayObject
      {
         return this.Ӏ;
      }
      
      public function set Ӆ(param1:DisplayObject) : void
      {
         var target:DisplayObject = param1;
         if(this.Ӏ != null)
         {
            this.Ӏ.removeEventListener(Event.CHANGE,this.ӊ,false);
            this.Ӏ.removeEventListener(TextEvent.TEXT_INPUT,this.ӊ,false);
            this.Ӏ.removeEventListener(Event.SCROLL,this.Ӌ,false);
         }
         this.Ӏ = target;
         var ݰ:String = null;
         var ݱ:String = null;
         var ݲ:Boolean = false;
         if(this.Ӏ != null)
         {
            try
            {
               if(this.Ӏ.hasOwnProperty("blockProgression"))
               {
                  ݰ = this.Ӏ["blockProgression"];
               }
               if(this.Ӏ.hasOwnProperty("direction"))
               {
                  ݱ = this.Ӏ["direction"];
               }
               if(this.Ӏ.hasOwnProperty("pixelScrollV"))
               {
                  ݲ = true;
               }
            }
            catch(e:Error)
            {
               ݰ = null;
               ݱ = null;
            }
         }
         var ݳ:Boolean = this.direction == ScrollBarDirection.HORIZONTAL;
         var ݴ:Number = Math.abs(this.rotation);
         if(ݳ && (ݰ == "rl" || ݱ == "rtl"))
         {
            if(щ() > 0 && rotation == 90)
            {
               x = x + width;
            }
            ъ(-1);
         }
         else if(!ݳ && ݰ == "rl" && ݱ == "rtl")
         {
            if(щ() > 0 && rotation != 90)
            {
               y = y + height;
            }
            ъ(-1);
         }
         else
         {
            if(щ() < 0)
            {
               if(ݳ)
               {
                  if(rotation == 90)
                  {
                     x = x - width;
                  }
               }
               else if(rotation != 90)
               {
                  y = y - height;
               }
            }
            ъ(1);
         }
         this.ӌ(ݳ,ݰ,ݲ);
         if(this.Ӏ != null)
         {
            this.Ӏ.addEventListener(Event.CHANGE,this.ӊ,false,0,true);
            this.Ӏ.addEventListener(TextEvent.TEXT_INPUT,this.ӊ,false,0,true);
            this.Ӏ.addEventListener(Event.SCROLL,this.Ӌ,false,0,true);
         }
         invalidate(InvalidationType.DATA);
      }
      
      public function get ӆ() : String
      {
         return this.Ӏ.name;
      }
      
      public function set ӆ(param1:String) : void
      {
         var target:String = param1;
         try
         {
            this.Ӆ = parent.getChildByName(target);
            return;
         }
         catch(error:Error)
         {
            throw new Error("ScrollTarget not found, or is not a valid target");
         }
      }
      
      override public function get direction() : String
      {
         return super.direction;
      }
      
      override public function set direction(param1:String) : void
      {
         var _loc2_:DisplayObject = null;
         if(Я)
         {
            return;
         }
         if(!componentInspectorSetting && this.Ӏ != null)
         {
            _loc2_ = this.Ӏ;
            this.Ӆ = null;
         }
         super.direction = param1;
         if(_loc2_ != null)
         {
            this.Ӆ = _loc2_;
         }
         else
         {
            this.ӈ();
         }
      }
      
      public function Ӈ() : void
      {
         this.inEdit = true;
         this.ӈ();
         this.inEdit = false;
      }
      
      override protected function draw() : void
      {
         if(ѓ(InvalidationType.DATA))
         {
            this.ӈ();
         }
         super.draw();
      }
      
      protected function ӈ() : void
      {
         var ݰ:String = null;
         var ݲ:Boolean = false;
         var ҳ:Number = NaN;
         var ݵ:Number = NaN;
         var ݷ:* = undefined;
         if(this.Ӏ == null)
         {
            this.Ұ(ҳ,ұ,Ҳ);
            scrollPosition = 0;
         }
         else
         {
            ݰ = null;
            ݲ = false;
            try
            {
               if(this.Ӏ.hasOwnProperty("blockProgression"))
               {
                  ݰ = this.Ӏ["blockProgression"];
               }
               if(this.Ӏ.hasOwnProperty("pixelScrollV"))
               {
                  ݲ = true;
               }
            }
            catch(e1:Error)
            {
            }
            this.ӌ(this.direction == ScrollBarDirection.HORIZONTAL,ݰ,ݲ);
            if(this.Ӄ == "scrollH")
            {
               ݵ = 0;
               try
               {
                  if(this.Ӏ.hasOwnProperty("controller") && this.Ӏ["controller"].hasOwnProperty("compositionWidth"))
                  {
                     ҳ = this.Ӏ["controller"]["compositionWidth"];
                  }
                  else
                  {
                     ҳ = this.Ӏ.width;
                  }
               }
               catch(e2:Error)
               {
                  ҳ = Ӏ.width;
               }
            }
            else
            {
               try
               {
                  if(ݰ != null)
                  {
                     ݷ = this.Ӏ["pixelMinScrollV"];
                     if(ݷ is int)
                     {
                        ݵ = ݷ;
                     }
                     else
                     {
                        ݵ = 1;
                     }
                  }
                  else
                  {
                     ݵ = 1;
                  }
               }
               catch(e3:Error)
               {
                  ݵ = 1;
               }
               ҳ = 10;
            }
            this.Ұ(ҳ,ݵ,this.Ӆ[this.ӄ]);
            scrollPosition = this.Ӏ[this.Ӄ];
         }
      }
      
      override public function Ұ(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
      {
         var _loc5_:Number = param3;
         var _loc6_:Number = param2 < 0?Number(0):Number(param2);
         if(this.Ӏ != null)
         {
            _loc5_ = Math.min(param3,this.Ӏ[this.ӄ]);
         }
         super.Ұ(param1,_loc6_,_loc5_,param4);
      }
      
      override public function ҹ(param1:Number, param2:Boolean = true) : void
      {
         super.ҹ(param1,param2);
         if(!this.Ӏ)
         {
            this.ӂ = false;
            return;
         }
         this.Ӊ();
      }
      
      protected function Ӊ(param1:ScrollEvent = null) : void
      {
         if(this.inEdit)
         {
            return;
         }
         this.Ӏ[this.Ӄ] = scrollPosition;
      }
      
      protected function ӊ(param1:Event) : void
      {
         this.inEdit = true;
         this.ҹ(this.Ӏ[this.Ӄ],true);
         this.ӈ();
         this.inEdit = false;
      }
      
      protected function Ӌ(param1:Event) : void
      {
         if(ҫ)
         {
            return;
         }
         if(!enabled)
         {
            return;
         }
         this.inEdit = true;
         this.ӈ();
         scrollPosition = this.Ӏ[this.Ӄ];
         this.inEdit = false;
      }
      
      private function ӌ(param1:Boolean, param2:String, param3:Boolean = false) : void
      {
         if(param2 == "rl")
         {
            if(param1)
            {
               this.Ӄ = !!param3?"pixelScrollV":"scrollV";
               this.ӄ = !!param3?"pixelMaxScrollV":"maxScrollV";
            }
            else
            {
               this.Ӄ = "scrollH";
               this.ӄ = "maxScrollH";
            }
         }
         else if(param1)
         {
            this.Ӄ = "scrollH";
            this.ӄ = "maxScrollH";
         }
         else
         {
            this.Ӄ = !!param3?"pixelScrollV":"scrollV";
            this.ӄ = !!param3?"pixelMaxScrollV":"maxScrollV";
         }
      }
   }
}
