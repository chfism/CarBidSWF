package r1.deval.rt
{
   import r1.deval.parser.ParserConsts;
   
   class BitExpr extends MultiExprBase
   {
       
      
      var op:int;
      
      function BitExpr(first:IExpr, rest:*, op:int)
      {
         super(first,rest);
         this.op = op;
      }
      
      public function isA(op:int) : Boolean
      {
         return op == this.op;
      }
      
      override public function getBoolean() : Boolean
      {
         return Boolean(getNumber());
      }
      
      override public function getAny() : Object
      {
         return getNumber();
      }
      
      override public function getString() : String
      {
         return getNumber().toString();
      }
      
      override public function getNumber() : Number
      {
         var result:Number = first.getNumber();
         for(var i:int = 0; i < rest.length; i++)
         {
            if(op == ParserConsts.BITAND)
            {
               result = result & rest[i].getNumber();
            }
            else if(op == ParserConsts.BITOR)
            {
               result = result | rest[i].getNumber();
            }
            else
            {
               result = result ^ rest[i].getNumber();
            }
         }
         return result;
      }
   }
}
