package fl.managers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectBidInitView;
   import flash.display.InteractiveObject;
   import flash.display.SimpleButton;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import fl.core.UIComponent;
   import fl.controls.Button;
   
   public class FocusManager implements IFocusManager
   {
       
      
      private var _form:DisplayObjectBidInitView;
      
      private var §՘§:Dictionary;
      
      private var ՙ:Array;
      
      private var activated:Boolean = false;
      
      private var §՛§:Boolean = true;
      
      private var §՜§:InteractiveObject;
      
      private var §՝§:Boolean = true;
      
      private var §՞§:String;
      
      private var §՟§:Button;
      
      private var §ՠ§:Button;
      
      private var _uniqueid:Boolean = true;
      
      public function FocusManager(param1:DisplayObjectBidInitView)
      {
         super();
         this.§՘§ = new Dictionary(true);
         if(param1 != null)
         {
            this._form = param1;
            this.activate();
         }
      }
      
      private function addedHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         if(_loc2_["@doswf__stage"])
         {
            this.xxteaHttp(DisplayObject(param1.target));
         }
      }
      
      private function removedHandler(param1:Event) : void
      {
         var _loc4_:InteractiveObject = null;
         var _loc3_:DisplayObject = DisplayObject(param1.target);
         if(_loc3_ is IFocusManagerComponent && this.§՘§[_loc3_] == true)
         {
            if(_loc3_ == this.§՜§)
            {
               IFocusManagerComponent(this.§՜§).drawFocus(false);
               this.§՜§ = null;
            }
            _loc3_.removeEventListener(Event.TAB_ENABLED_CHANGE,this.է,false);
            delete this.§՘§[_loc3_];
            this.§՛§ = true;
         }
         else if(_loc3_ is InteractiveObject && this.§՘§[_loc3_] == true)
         {
            _loc4_ = _loc3_ as InteractiveObject;
            if(_loc4_)
            {
               if(_loc4_ == this.§՜§)
               {
                  this.§՜§ = null;
               }
               delete this.§՘§[_loc4_];
               this.§՛§ = true;
            }
            _loc3_.addEventListener(Event.TAB_ENABLED_CHANGE,this.է,false,0,true);
         }
         this.loadimage(_loc3_);
      }
      
      private function xxteaHttp(param1:DisplayObject, param2:Boolean = false) : void
      {
         var ݿ:IFocusManagerComponent = null;
         var ހ:InteractiveObject = null;
         var ށ:DisplayObjectBidInitView = null;
         var ނ:DisplayObjectBidInitView = null;
         var i:int = 0;
         var child:DisplayObject = null;
         var o:DisplayObject = param1;
         var ݾ:Boolean = param2;
         if(!ݾ)
         {
            if(o is IFocusManagerComponent)
            {
               ݿ = IFocusManagerComponent(o);
               if(ݿ.focusEnabled)
               {
                  if(ݿ.tabEnabled && this.դ(o))
                  {
                     this.§՘§[o] = true;
                     this.§՛§ = true;
                  }
                  o.addEventListener(Event.TAB_ENABLED_CHANGE,this.է,false,0,true);
                  o.addEventListener(Event.TAB_INDEX_CHANGE,this.ը,false,0,true);
               }
            }
            else if(o is InteractiveObject)
            {
               ހ = o as InteractiveObject;
               if(ހ && ހ.tabEnabled && this.Ք(ހ) == ހ)
               {
                  this.§՘§[ހ] = true;
                  this.§՛§ = true;
               }
               ހ.addEventListener(Event.TAB_ENABLED_CHANGE,this.է,false,0,true);
               ހ.addEventListener(Event.TAB_INDEX_CHANGE,this.ը,false,0,true);
            }
         }
         if(o is DisplayObjectBidInitView)
         {
            ށ = DisplayObjectBidInitView(o);
            o.addEventListener(Event.TAB_CHILDREN_CHANGE,this.թ,false,0,true);
            ނ = null;
            try
            {
               ނ = ށ.parent;
            }
            catch(se:SecurityError)
            {
               ނ = null;
            }
            if(ށ is Stage || ނ is Stage || ށ.tabChildren)
            {
               i = 0;
               while(i < ށ.numChildren)
               {
                  try
                  {
                     child = ށ.getChildAt(i);
                     if(child != null)
                     {
                        this.xxteaHttp(ށ.getChildAt(i));
                     }
                  }
                  catch(error:SecurityError)
                  {
                  }
                  i++;
               }
            }
         }
      }
      
      private function loadimage(param1:DisplayObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:DisplayObject = null;
         if(param1 is DisplayObjectBidInitView)
         {
            param1.removeEventListener(Event.TAB_CHILDREN_CHANGE,this.թ,false);
            param1.removeEventListener(Event.TAB_INDEX_CHANGE,this.ը,false);
            for(_loc2_ in this.§՘§)
            {
               _loc3_ = DisplayObject(_loc2_);
               if(DisplayObjectBidInitView(param1).contains(_loc3_))
               {
                  if(_loc3_ == this.§՜§)
                  {
                     this.§՜§ = null;
                  }
                  _loc3_.removeEventListener(Event.TAB_ENABLED_CHANGE,this.է,false);
                  delete this.§՘§[_loc2_];
                  this.§՛§ = true;
               }
            }
         }
      }
      
      private function դ(param1:DisplayObject) : Boolean
      {
         var _loc2_:DisplayObjectBidInitView = null;
         try
         {
            _loc2_ = param1.parent;
            while(_loc2_ && !(_loc2_ is Stage) && !(_loc2_.parent && _loc2_.parent is Stage))
            {
               if(!_loc2_.tabChildren)
               {
                  return false;
               }
               _loc2_ = _loc2_.parent;
            }
         }
         catch(se:SecurityError)
         {
         }
         return true;
      }
      
      private function showSelfTopPriceWindow(param1:DisplayObject, param2:String) : Boolean
      {
         var _loc3_:IFocusManagerGroup = null;
         if(!this.sendAndGetPriceInfo(param1))
         {
            return false;
         }
         if(param1 is IFocusManagerGroup)
         {
            _loc3_ = IFocusManagerGroup(param1);
            if(param2 == _loc3_.groupName)
            {
               return false;
            }
         }
         return true;
      }
      
      private function sendAndGetPriceInfo(param1:DisplayObject) : Boolean
      {
         var _loc2_:DisplayObjectBidInitView = null;
         var _loc3_:TextField = null;
         var _loc4_:SimpleButton = null;
         try
         {
            _loc2_ = DisplayObject(this.form).parent;
            while(param1 != _loc2_)
            {
               if(param1 is UIComponent)
               {
                  if(!UIComponent(param1).enabled)
                  {
                     return false;
                  }
               }
               else if(param1 is TextField)
               {
                  _loc3_ = TextField(param1);
                  if(_loc3_.type == TextFieldType.DYNAMIC || !_loc3_.selectable)
                  {
                     return false;
                  }
               }
               else if(param1 is SimpleButton)
               {
                  _loc4_ = SimpleButton(param1);
                  if(!_loc4_.enabled)
                  {
                     return false;
                  }
               }
               if(!param1.visible)
               {
                  return false;
               }
               param1 = param1.parent;
            }
         }
         catch(se:SecurityError)
         {
         }
         return true;
      }
      
      private function է(param1:Event) : void
      {
         this.§՛§ = true;
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
         var _loc3_:* = this.§՘§[_loc2_] == true;
         if(_loc2_.tabEnabled)
         {
            if(!_loc3_ && this.դ(_loc2_))
            {
               if(!(_loc2_ is IFocusManagerComponent))
               {
                  _loc2_.focusRect = false;
               }
               this.§՘§[_loc2_] = true;
            }
         }
         else if(_loc3_)
         {
            delete this.§՘§[_loc2_];
         }
      }
      
      private function ը(param1:Event) : void
      {
         this.§՛§ = true;
      }
      
      private function թ(param1:Event) : void
      {
         if(param1.target != param1.currentTarget)
         {
            return;
         }
         this.§՛§ = true;
         var _loc2_:DisplayObjectBidInitView = DisplayObjectBidInitView(param1.target);
         if(_loc2_.tabChildren)
         {
            this.xxteaHttp(_loc2_,true);
         }
         else
         {
            this.loadimage(_loc2_);
         }
      }
      
      public function activate() : void
      {
         if(this.activated)
         {
            return;
         }
         this.xxteaHttp(this.form);
         this.form.addEventListener(Event.ADDED,this.addedHandler,false,0,true);
         this.form.addEventListener(Event.REMOVED,this.removedHandler,false,0,true);
         try
         {
            this.form["@doswf__stage"].addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.լ,false,0,true);
            this.form["@doswf__stage"].addEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.խ,false,0,true);
            this.form["@doswf__stage"].addEventListener(Event.ACTIVATE,this.ժ,false,0,true);
            this.form["@doswf__stage"].addEventListener(Event.DEACTIVATE,this.ի,false,0,true);
         }
         catch(se:SecurityError)
         {
            form.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,լ,false,0,true);
            form.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,խ,false,0,true);
            form.addEventListener(Event.ACTIVATE,ժ,false,0,true);
            form.addEventListener(Event.DEACTIVATE,ի,false,0,true);
         }
         this.form.addEventListener(FocusEvent.FOCUS_IN,this.focusInHandler,true,0,true);
         this.form.addEventListener(FocusEvent.FOCUS_OUT,this.focusOutHandler,true,0,true);
         this.form.addEventListener(MouseEvent.MOUSE_DOWN,this.ծ,false,0,true);
         this.form.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,true,0,true);
         this.activated = true;
         if(this.§՜§)
         {
            this.setFocus(this.§՜§);
         }
      }
      
      public function deactivate() : void
      {
         if(!this.activated)
         {
            return;
         }
         this.§՘§ = new Dictionary(true);
         this.ՙ = null;
         this.§՜§ = null;
         this.§՟§ = null;
         this.form.removeEventListener(Event.ADDED,this.addedHandler,false);
         this.form.removeEventListener(Event.REMOVED,this.removedHandler,false);
         try
         {
            this.form["@doswf__stage"].removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.լ,false);
            this.form["@doswf__stage"].removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.խ,false);
            this.form["@doswf__stage"].removeEventListener(Event.ACTIVATE,this.ժ,false);
            this.form["@doswf__stage"].removeEventListener(Event.DEACTIVATE,this.ի,false);
         }
         catch(se:SecurityError)
         {
         }
         this.form.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.լ,false);
         this.form.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.խ,false);
         this.form.removeEventListener(Event.ACTIVATE,this.ժ,false);
         this.form.removeEventListener(Event.DEACTIVATE,this.ի,false);
         this.form.removeEventListener(FocusEvent.FOCUS_IN,this.focusInHandler,true);
         this.form.removeEventListener(FocusEvent.FOCUS_OUT,this.focusOutHandler,true);
         this.form.removeEventListener(MouseEvent.MOUSE_DOWN,this.ծ,false);
         this.form.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,true);
         this.activated = false;
      }
      
      private function focusInHandler(param1:FocusEvent) : void
      {
         var _loc3_:Button = null;
         if(!this.activated)
         {
            return;
         }
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
         if(this.form.contains(_loc2_))
         {
            this.§՜§ = this.Ք(InteractiveObject(_loc2_));
            if(this.§՜§ is Button)
            {
               _loc3_ = Button(this.§՜§);
               if(this.§՟§)
               {
                  this.§՟§.ҁ = false;
                  this.§՟§ = _loc3_;
                  _loc3_.ҁ = true;
               }
            }
            else if(this.§՟§ && this.§՟§ != this.§ՠ§)
            {
               this.§՟§.ҁ = false;
               this.§՟§ = this.§ՠ§;
               this.§ՠ§.ҁ = true;
            }
         }
      }
      
      private function focusOutHandler(param1:FocusEvent) : void
      {
         if(!this.activated)
         {
            return;
         }
         var _loc2_:InteractiveObject = param1.target as InteractiveObject;
      }
      
      private function ժ(param1:Event) : void
      {
         if(!this.activated)
         {
            return;
         }
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
         if(this.§՜§)
         {
            if(this.§՜§ is IFocusManagerComponent)
            {
               IFocusManagerComponent(this.§՜§).setFocus();
            }
            else
            {
               this.form["@doswf__stage"].focus = this.§՜§;
            }
         }
         this.§՞§ = "ACTIVATE";
      }
      
      private function ի(param1:Event) : void
      {
         if(!this.activated)
         {
            return;
         }
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
      }
      
      private function լ(param1:FocusEvent) : void
      {
         if(!this.activated)
         {
            return;
         }
         if(param1.relatedObject is TextField)
         {
            return;
         }
         param1.preventDefault();
      }
      
      private function խ(param1:FocusEvent) : void
      {
         if(!this.activated)
         {
            return;
         }
         this.Ց = true;
         if((param1.keyCode == Keyboard.TAB || param1.keyCode == 0) && !param1.isDefaultPrevented())
         {
            this.հ(param1);
            param1.preventDefault();
         }
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(!this.activated)
         {
            return;
         }
         if(param1.keyCode == Keyboard.TAB)
         {
            this.§՞§ = "KEY";
            if(this.§՛§)
            {
               this.մ();
               this.§՛§ = false;
            }
         }
         if(this.Տ && param1.keyCode == Keyboard.ENTER && this.Վ && this.§՟§.enabled)
         {
            this.կ();
         }
      }
      
      private function ծ(param1:MouseEvent) : void
      {
         if(!this.activated)
         {
            return;
         }
         if(param1.isDefaultPrevented())
         {
            return;
         }
         var _loc2_:InteractiveObject = this.ո(InteractiveObject(param1.target));
         if(!_loc2_)
         {
            return;
         }
         this.Ց = false;
         if((_loc2_ != this.§՜§ || this.§՞§ == "ACTIVATE") && !(_loc2_ is TextField))
         {
            this.setFocus(_loc2_);
         }
         this.§՞§ = "MOUSEDOWN";
      }
      
      public function get Վ() : Button
      {
         return this.§ՠ§;
      }
      
      public function set Վ(param1:Button) : void
      {
         var _loc2_:Button = !!param1?Button(param1):null;
         if(_loc2_ != this.§ՠ§)
         {
            if(this.§ՠ§)
            {
               this.§ՠ§.ҁ = false;
            }
            if(this.§՟§)
            {
               this.§՟§.ҁ = false;
            }
            this.§ՠ§ = _loc2_;
            this.§՟§ = _loc2_;
            if(_loc2_)
            {
               _loc2_.ҁ = true;
            }
         }
      }
      
      public function կ() : void
      {
         this.§՟§.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function հ(param1:FocusEvent) : void
      {
         if(!this.ձ())
         {
            return;
         }
         var _loc2_:InteractiveObject = this.Օ(param1.shiftKey);
         if(_loc2_)
         {
            this.setFocus(_loc2_);
         }
      }
      
      private function ձ() : Boolean
      {
         var _loc1_:* = null;
         for(_loc1_ in this.§՘§)
         {
            return true;
         }
         return false;
      }
      
      public function Օ(param1:Boolean = false) : InteractiveObject
      {
         var _loc8_:IFocusManagerGroup = null;
         if(!this.ձ())
         {
            return null;
         }
         if(this.§՛§)
         {
            this.մ();
            this.§՛§ = false;
         }
         var _loc2_:DisplayObject = this.form["@doswf__stage"].focus;
         _loc2_ = DisplayObject(this.Ք(InteractiveObject(_loc2_)));
         var _loc3_:String = "";
         if(_loc2_ is IFocusManagerGroup)
         {
            _loc8_ = IFocusManagerGroup(_loc2_);
            _loc3_ = _loc8_.groupName;
         }
         var _loc4_:int = this.ղ(_loc2_);
         var _loc5_:Boolean = false;
         var _loc6_:int = _loc4_;
         if(_loc4_ == -1)
         {
            if(param1)
            {
               _loc4_ = this.ՙ.length;
            }
            _loc5_ = true;
         }
         var _loc7_:int = this.ճ(_loc4_,param1,_loc5_,_loc3_);
         return this.Ք(this.ՙ[_loc7_]);
      }
      
      private function ղ(param1:DisplayObject) : int
      {
         var _loc2_:int = this.ՙ.length;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.ՙ[_loc3_] == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function ճ(param1:int, param2:Boolean, param3:Boolean, param4:String) : int
      {
         var _loc7_:DisplayObject = null;
         var _loc8_:IFocusManagerGroup = null;
         var _loc9_:int = 0;
         var _loc10_:DisplayObject = null;
         var _loc11_:IFocusManagerGroup = null;
         var _loc5_:int = this.ՙ.length;
         var _loc6_:int = param1;
         while(true)
         {
            if(param2)
            {
               param1--;
            }
            else
            {
               param1++;
            }
            if(param3)
            {
               if(param2 && param1 < 0)
               {
                  break;
               }
               if(!param2 && param1 == _loc5_)
               {
                  break;
               }
            }
            else
            {
               param1 = (param1 + _loc5_) % _loc5_;
               if(_loc6_ == param1)
               {
                  break;
               }
            }
            if(this.showSelfTopPriceWindow(this.ՙ[param1],param4))
            {
               _loc7_ = DisplayObject(this.Ք(this.ՙ[param1]));
               if(_loc7_ is IFocusManagerGroup)
               {
                  _loc8_ = IFocusManagerGroup(_loc7_);
                  _loc9_ = 0;
                  while(_loc9_ < this.ՙ.length)
                  {
                     _loc10_ = this.ՙ[_loc9_];
                     if(_loc10_ is IFocusManagerGroup)
                     {
                        _loc11_ = IFocusManagerGroup(_loc10_);
                        if(_loc11_.groupName == _loc8_.groupName && _loc11_.selected)
                        {
                           param1 = _loc9_;
                           break;
                        }
                     }
                     _loc9_++;
                  }
               }
               return param1;
            }
         }
         return param1;
      }
      
      private function մ() : void
      {
         var _loc1_:* = null;
         var _loc2_:InteractiveObject = null;
         this.ՙ = [];
         for(_loc1_ in this.§՘§)
         {
            _loc2_ = InteractiveObject(_loc1_);
            if(_loc2_.tabIndex && !isNaN(Number(_loc2_.tabIndex)) && _loc2_.tabIndex > 0)
            {
               this.յ();
               return;
            }
            this.ՙ.push(_loc2_);
         }
         this.ՙ.sort(this.ն);
      }
      
      private function յ() : void
      {
         var _loc1_:* = null;
         var _loc2_:InteractiveObject = null;
         this.ՙ = [];
         for(_loc1_ in this.§՘§)
         {
            _loc2_ = InteractiveObject(_loc1_);
            if(_loc2_.tabIndex && !isNaN(Number(_loc2_.tabIndex)))
            {
               this.ՙ.push(_loc2_);
            }
         }
         this.ՙ.sort(this.շ);
      }
      
      private function ն(param1:InteractiveObject, param2:InteractiveObject) : Number
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc9_:DisplayObject = DisplayObject(param1);
         var _loc10_:DisplayObject = DisplayObject(param2);
         try
         {
            while(_loc9_ != DisplayObject(this.form) && _loc9_.parent)
            {
               _loc5_ = this.getChildIndex(_loc9_.parent,_loc9_);
               _loc6_ = _loc5_.toString(16);
               if(_loc6_.length < 4)
               {
                  _loc7_ = "0000".substring(0,4 - _loc6_.length) + _loc6_;
               }
               _loc3_ = _loc7_ + _loc3_;
               _loc9_ = _loc9_.parent;
            }
         }
         catch(se1:SecurityError)
         {
            try
            {
               while(_loc10_ != DisplayObject(this.form) && _loc10_.parent)
               {
                  _loc5_ = this.getChildIndex(_loc10_.parent,_loc10_);
                  _loc6_ = _loc5_.toString(16);
                  if(_loc6_.length < 4)
                  {
                     _loc7_ = "0000".substring(0,4 - _loc6_.length) + _loc6_;
                  }
                  _loc4_ = _loc7_ + _loc4_;
                  _loc10_ = _loc10_.parent;
               }
            }
            catch(se2:SecurityError)
            {
            }
            return _loc3_ > _loc4_?Number(1):_loc3_ < _loc4_?Number(-1):Number(0);
         }
         continue loop1;
      }
      
      private function getChildIndex(param1:DisplayObjectBidInitView, param2:DisplayObject) : int
      {
         return param1.getChildIndex(param2);
      }
      
      private function շ(param1:InteractiveObject, param2:InteractiveObject) : int
      {
         return param1.tabIndex > param2.tabIndex?1:param1.tabIndex < param2.tabIndex?-1:int(this.ն(param1,param2));
      }
      
      public function get Տ() : Boolean
      {
         return this._uniqueid;
      }
      
      public function set Տ(param1:Boolean) : void
      {
         this._uniqueid = param1;
      }
      
      public function get Ր() : int
      {
         return 0;
      }
      
      public function get Ց() : Boolean
      {
         return this.§՝§;
      }
      
      public function set Ց(param1:Boolean) : void
      {
         this.§՝§ = param1;
      }
      
      public function get form() : DisplayObjectBidInitView
      {
         return this._form;
      }
      
      public function set form(param1:DisplayObjectBidInitView) : void
      {
         this._form = param1;
      }
      
      public function main() : InteractiveObject
      {
         var _loc1_:InteractiveObject = this.form["@doswf__stage"].focus;
         return this.Ք(_loc1_);
      }
      
      public function setFocus(param1:InteractiveObject) : void
      {
         if(param1 is IFocusManagerComponent)
         {
            IFocusManagerComponent(param1).setFocus();
         }
         else
         {
            this.form["@doswf__stage"].focus = param1;
         }
      }
      
      public function Ւ() : void
      {
      }
      
      public function Փ() : void
      {
      }
      
      public function Ք(param1:InteractiveObject) : InteractiveObject
      {
         var _loc2_:InteractiveObject = param1;
         try
         {
            while(param1)
            {
               if(param1 is IFocusManagerComponent && IFocusManagerComponent(param1).focusEnabled)
               {
                  return param1;
               }
               param1 = param1.parent;
            }
         }
         catch(se:SecurityError)
         {
         }
         return _loc2_;
      }
      
      private function ո(param1:InteractiveObject) : InteractiveObject
      {
         try
         {
            while(true)
            {
               if(param1 != InteractiveObject(this.form))
               {
                  if(param1 is IFocusManagerComponent && IFocusManagerComponent(param1).focusEnabled && IFocusManagerComponent(param1).mouseFocusEnabled && UIComponent(param1).enabled)
                  {
                     return param1;
                  }
                  param1 = param1.parent;
                  if(param1 == null)
                  {
                     break;
                  }
                  continue;
               }
            }
         }
         catch(se:SecurityError)
         {
         }
         break loop0;
      }
   }
}
