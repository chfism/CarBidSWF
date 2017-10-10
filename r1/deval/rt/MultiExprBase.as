package r1.deval.rt
{
   class MultiExprBase implements IExpr
   {
       
      
      var first:IExpr;
      
      var rest:Array;
      
      function MultiExprBase(first:IExpr, rest:*)
      {
         super();
         this.first = first;
         this.rest = rest is Array?rest as Array:[rest];
      }
      
      public function getNumber() : Number
      {
         throw new Error("UNIMPLEMENTED");
      }
      
      public function getString() : String
      {
         throw new Error("UNIMPLEMENTED");
      }
      
      public function addOperand(more:*, extra:* = null) : void
      {
         var x:IExpr = null;
         if(more is IExpr)
         {
            rest.push(more);
         }
         else if(more is Array)
         {
            for each(x in more as Array)
            {
               rest.push(x);
            }
         }
      }
      
      public function getBoolean() : Boolean
      {
         throw new Error("UNIMPLEMENTED");
      }
      
      public function getAny() : Object
      {
         throw new Error("UNIMPLEMENTED");
      }
   }
}
