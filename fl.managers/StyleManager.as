package fl.managers
{
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import fl.core.UIComponent;
   
   public class StyleManager
   {
      
      private static var ռ:StyleManager;
       
      
      private var styleToClassesHash:Object;
      
      private var classToInstancesDict:Dictionary;
      
      private var classToStylesDict:Dictionary;
      
      private var ջ:Dictionary;
      
      private var globalStyles:Object;
      
      public function StyleManager()
      {
         super();
         this.styleToClassesHash = {};
         this.classToInstancesDict = new Dictionary(true);
         this.classToStylesDict = new Dictionary(true);
         this.ջ = new Dictionary(true);
         this.globalStyles = UIComponent.getStyleDefinition();
      }
      
      private static function ս() : *
      {
         if(ռ == null)
         {
            ռ = new StyleManager();
         }
         return ռ;
      }
      
      public static function վ(param1:UIComponent) : void
      {
         var target:Class = null;
         var defaultStyles :Object = null;
         var styleToClasses:Object = null;
         var n:String = null;
         var instance:UIComponent = param1;
         var ބ:StyleManager = ս();
         var ݫ:Class = ք(instance);
         if(ݫ == null)
         {
            return;
         }
         if(ބ.classToInstancesDict[ݫ] == null)
         {
            ބ.classToInstancesDict[ݫ] = new Dictionary(true);
            target = ݫ;
            while(defaultStyles  == null)
            {
               if(target["getStyleDefinition"] != null)
               {
                  defaultStyles  = target["getStyleDefinition"]();
                  break;
               }
               try
               {
                  target = instance.loaderInfo.applicationDomain.getDefinition(getQualifiedSuperclassName(target)) as Class;
               }
               catch(err:Error)
               {
                  try
                  {
                     target = getDefinitionByName(getQualifiedSuperclassName(target)) as Class;
                  }
                  catch(e:Error)
                  {
                     defaultStyles  = UIComponent.getStyleDefinition();
                     break;
                  }
                  continue;
               }
            }
            styleToClasses = ބ.styleToClassesHash;
            for(n in defaultStyles )
            {
               if(styleToClasses[n] == null)
               {
                  styleToClasses[n] = new Dictionary(true);
               }
               styleToClasses[n][ݫ] = true;
            }
            ބ.ջ[ݫ] = defaultStyles ;
            if(ބ.classToStylesDict[ݫ] == null)
            {
               ބ.classToStylesDict[ݫ] = {};
            }
         }
         ބ.classToInstancesDict[ݫ][instance] = true;
         setSharedStyles(instance);
      }
      
      private static function setSharedStyles(param1:UIComponent) : void
      {
         var _loc5_:* = null;
         var _loc2_:StyleManager = ս();
         var _loc3_:Class = ք(param1);
         var _loc4_:Object = _loc2_.ջ[_loc3_];
         for(_loc5_ in _loc4_)
         {
            param1.ю(_loc5_,getSharedStyle(param1,_loc5_));
         }
      }
      
      private static function getSharedStyle(param1:UIComponent, param2:String) : Object
      {
         var _loc3_:Class = ք(param1);
         var _loc4_:StyleManager = ս();
         var _loc5_:Object = _loc4_.classToStylesDict[_loc3_][param2];
         if(_loc5_ != null)
         {
            return _loc5_;
         }
         _loc5_ = _loc4_.globalStyles[param2];
         if(_loc5_ != null)
         {
            return _loc5_;
         }
         return _loc4_.ջ[_loc3_][param2];
      }
      
      public static function ց(param1:Object, param2:String) : Object
      {
         var _loc3_:Class = ք(param1);
         var _loc4_:Object = ս().classToStylesDict[_loc3_];
         return _loc4_ == null?null:_loc4_[param2];
      }
      
      public static function ւ(param1:Object, param2:String) : void
      {
         var _loc3_:Class = ք(param1);
         var _loc4_:Object = ս().classToStylesDict[_loc3_];
         if(_loc4_ != null && _loc4_[param2] != null)
         {
            delete _loc4_[param2];
            ֆ(_loc3_,param2);
         }
      }
      
      public static function փ(param1:Object, param2:String, param3:Object) : void
      {
         var _loc4_:Class = ք(param1);
         var _loc5_:Object = ս().classToStylesDict[_loc4_];
         if(_loc5_ == null)
         {
            _loc5_ = ս().classToStylesDict[_loc4_] = {};
         }
         if(_loc5_ == param3)
         {
            return;
         }
         _loc5_[param2] = param3;
         ֆ(_loc4_,param2);
      }
      
      private static function ք(param1:Object) : Class
      {
         var ކ:Object = param1;
         if(ކ is Class)
         {
            return ކ as Class;
         }
         try
         {
            return getDefinitionByName(getQualifiedClassName(ކ)) as Class;
         }
         catch(e:Error)
         {
            if(ކ is UIComponent)
            {
               try
               {
                  return ކ.loaderInfo.applicationDomain.getDefinition(getQualifiedClassName(ކ)) as Class;
               }
               catch(e:Error)
               {
               }
            }
         }
         return null;
      }
      
      private static function օ(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:Dictionary = ս().styleToClassesHash[param1];
         if(_loc2_ == null)
         {
            return;
         }
         for(_loc3_ in _loc2_)
         {
            ֆ(Class(_loc3_),param1);
         }
      }
      
      private static function ֆ(param1:Class, param2:String) : void
      {
         var _loc4_:* = null;
         var _loc5_:UIComponent = null;
         var _loc3_:Dictionary = ս().classToInstancesDict[param1];
         if(_loc3_ == null)
         {
            return;
         }
         for(_loc4_ in _loc3_)
         {
            _loc5_ = _loc4_ as UIComponent;
            if(_loc5_ != null)
            {
               _loc5_.ю(param2,getSharedStyle(_loc5_,param2));
            }
         }
      }
      
      public static function ц(param1:String, param2:Object) : void
      {
         var _loc3_:Object = ս().globalStyles;
         if(_loc3_[param1] === param2 && !(param2 is TextFormat))
         {
            return;
         }
         _loc3_[param1] = param2;
         օ(param1);
      }
      
      public static function ч(param1:String) : void
      {
         ц(param1,null);
      }
      
      public static function ш(param1:String) : Object
      {
         return ս().globalStyles[param1];
      }
   }
}
