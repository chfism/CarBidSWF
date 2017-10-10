package zebra.system.reflection
{
   public class StaticMethod extends ReflectionMember
   {
       
      
      private var _staticMethodInfo:Vector.<StaticMethodInfo>;
      
      public function StaticMethod(param1:*, param2:XML)
      {
         var _loc3_:XML = null;
         var _loc4_:StaticMethodInfo = null;
         var _loc5_:XML = null;
         var _loc6_:StaticMethodParameterInfo = null;
         super(param1,param2);
         this._staticMethodInfo = new Vector.<StaticMethodInfo>();
         for each(_loc3_ in _classXML.method)
         {
            _loc4_ = new StaticMethodInfo();
            _loc4_.key = _loc3_.@name.toString();
            _loc4_.declaredBy = _loc3_.@declaredBy.toString();
            _loc4_.returnType = _loc3_.@returnType.toString();
            for each(_loc5_ in _loc3_.parameter)
            {
               _loc6_ = new StaticMethodParameterInfo();
               _loc6_.index = int(_loc5_.@index);
               _loc6_.type = _loc5_.@type.toString();
               _loc6_.optional = Boolean(_loc5_.@optional);
               _loc4_.parameterInfo.push(_loc6_);
            }
            this._staticMethodInfo.push(_loc4_);
            _names.push(_loc4_.key);
         }
      }
      
      public function executeMethod(param1:String, param2:Array = null) : void
      {
         var _loc3_:StaticMethodInfo = null;
         for each(_loc3_ in this._staticMethodInfo)
         {
            if(_loc3_.key == param1)
            {
               if(_loc3_.parameterInfo.length == 0)
               {
                  this._class[_loc3_.key]();
                  break;
               }
               this._class[_loc3_.key](param2);
               break;
            }
         }
      }
      
      public function get ݞ() : Vector.<StaticMethodInfo>
      {
         return this._staticMethodInfo;
      }
   }
}
