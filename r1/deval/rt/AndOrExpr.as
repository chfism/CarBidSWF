package r1.deval.rt
{
   class AndOrExpr extends MultiExprBase
   {
       
      
      private var op:Boolean;
      
      private var isNot:Boolean;
      
      private var isXor:Boolean;
      
      function AndOrExpr(first:IExpr, rest:*, op:Boolean, isNot:Boolean, isXor:Boolean)
      {
         super(first,rest);
         this.op = op;
         this.isNot = isNot;
         this.isXor = isXor;
      }
      
      override public function getString() : String
      {
         return getBoolean().toString();
      }
      
      override public function getBoolean() : Boolean
      {
         var i:int = 0;
         var b:Boolean = false;
         var trueCnt:int = 0;
         var falseCnt:int = 0;
         var len:int = rest.length;
         var result:Boolean = first.getBoolean();
         if(isXor)
         {
            trueCnt = !!result?int(1):int(0);
            falseCnt = !!result?int(0):int(1);
            for(i = 0; i < len; i++)
            {
               if(IExpr(rest[i]).getBoolean())
               {
                  trueCnt++;
               }
               else
               {
                  falseCnt++;
               }
            }
            return trueCnt != ++len && falseCnt != len;
         }
         for(i = 0; i < len; i++)
         {
            b = IExpr(rest[i]).getBoolean();
            if(isXor)
            {
               trueCnt = trueCnt + (!!b?1:0);
            }
            else if(op)
            {
               result = result && b;
            }
            else
            {
               result = result || b;
            }
         }
         return !!isNot?Boolean(!result):Boolean(result);
      }
      
      override public function getAny() : Object
      {
         return getBoolean();
      }
      
      public function isA(op:Boolean, isNot:Boolean, isXor:Boolean) : Boolean
      {
         if(isXor)
         {
            return this.isXor;
         }
         return op == this.op && isNot == this.isNot;
      }
      
      override public function getNumber() : Number
      {
         return Number(getBoolean());
      }
   }
}
