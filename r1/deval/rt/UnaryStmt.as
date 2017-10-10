package r1.deval.rt
{
   import r1.deval.parser.ParserConsts;
   
   public class UnaryStmt extends EmptyStmt
   {
       
      
      private var value:IExpr;
      
      private var type:int;
      
      public function UnaryStmt(type:int, value:*, lineno:int)
      {
         super(lineno);
         this.type = type;
         this.value = value;
      }
      
      override public function exec() : void
      {
         var retVal:Object = null;
         var ns:Namespace = null;
         switch(type)
         {
            case ParserConsts.DEFAULT_NS:
               if(value != null)
               {
                  ns = value.getAny() as Namespace;
                  default xml namespace = ns;
               }
               break;
            case ParserConsts.THROW:
               retVal = value.getAny();
               if(retVal is Error)
               {
                  throw retVal as Error;
               }
               throw new Error(retVal.toString());
         }
      }
   }
}
