package zebra.system.reflection
{
   public class StaticMethodInfo
   {
       
      
      public var key:String;
      
      public var returnType:String;
      
      public var declaredBy:String;
      
      public var parameterInfo:Vector.<StaticMethodParameterInfo>;
      
      public function StaticMethodInfo()
      {
         this.parameterInfo = new Vector.<StaticMethodParameterInfo>();
         super();
      }
   }
}
