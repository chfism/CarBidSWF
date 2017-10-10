package r1.deval.rt
{
   class VarExpr extends ObjectExprBase
   {
       
      
      var init:IExpr;
      
      var name:String;
      
      function VarExpr(name:String, init:IExpr = null)
      {
         super();
         this.name = name;
         this.init = init;
      }
      
      override public function getAny() : Object
      {
         var val:Object = init == null?null:init.getAny();
         Env.setProperty(name,val);
         return val;
      }
   }
}
