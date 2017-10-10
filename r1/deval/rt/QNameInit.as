package r1.deval.rt
{
   class QNameInit extends ObjectExprBase
   {
       
      
      var ns:IExpr;
      
      var name:IExpr;
      
      function QNameInit(ns:IExpr, name:IExpr)
      {
         super();
         this.ns = ns;
         this.name = name;
      }
      
      override public function getAny() : Object
      {
         return new QName(ns.getAny() as Namespace,name.getString());
      }
   }
}
