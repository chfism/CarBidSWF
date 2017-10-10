package zebra.system.reflection
{
   public class MethodInfo
   {
       
      
      public var key:String;
      
      public var returnType:String;
      
      public var declaredBy:String;
      
      public var parameterInfo:Vector.<MethodParameterInfo>;
      
      public function MethodInfo()
      {
         this.parameterInfo = new Vector.<MethodParameterInfo>();
         super();
      }
   }
}
