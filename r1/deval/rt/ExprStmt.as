package r1.deval.rt
{
   public class ExprStmt extends EmptyStmt
   {
       
      
      var _expr:IExpr;
      
      public function ExprStmt(expr:IExpr, lineno:int)
      {
         super(lineno);
         this._expr = expr;
      }
      
      override public function exec() : void
      {
         Env.setReturnValue(_expr.getAny());
      }
      
      public function get expr() : IExpr
      {
         return this._expr;
      }
      
      public function toString() : String
      {
         return String(_expr);
      }
   }
}
