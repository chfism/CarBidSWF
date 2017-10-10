package r1.deval.rt
{
   class EmptyStmt implements IStmt
   {
       
      
      protected var _lineno:int;
      
      function EmptyStmt(lineno:int)
      {
         super();
         _lineno = lineno;
      }
      
      public function exec() : void
      {
      }
      
      public function get lineno() : int
      {
         return _lineno;
      }
   }
}
