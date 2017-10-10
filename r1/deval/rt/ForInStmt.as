package r1.deval.rt
{
   class ForInStmt extends EmptyStmt
   {
       
      
      private var init:IStmt;
      
      private var isForEach:Boolean;
      
      private var stmt:IStmt;
      
      private var collection:IExpr;
      
      function ForInStmt(init:IStmt, collection:IExpr, body:IStmt, isForEach:Boolean, lineno:int)
      {
         super(lineno);
         this.init = init;
         this.collection = collection;
         this.stmt = body;
         this.isForEach = isForEach;
      }
   }
}
