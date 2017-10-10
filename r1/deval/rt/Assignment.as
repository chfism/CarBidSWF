package r1.deval.rt
{
   import r1.deval.parser.ParserConsts;
   
   class Assignment extends ObjectExprBase implements IStmt
   {
       
      
      protected var op:int;
      
      protected var left:ISettable;
      
      private var _next:IStmt;
      
      private var _lineno:int;
      
      protected var right:IExpr;
      
      function Assignment(left:ISettable, right:IExpr, op:int, lineno:int)
      {
         super();
         this.left = left;
         this.right = right;
         this.op = op;
         this._lineno = lineno;
      }
      
      public function set next(stmt:IStmt) : void
      {
         _next = stmt;
      }
      
      public function exec() : void
      {
         Env.setReturnValue(getAny());
      }
      
      public function get lineno() : int
      {
         return _lineno;
      }
      
      override public function getAny() : Object
      {
         var val:Object = null;
         var r:Object = null;
         var b1:Boolean = false;
         var b2:Boolean = false;
         switch(op)
         {
            case ParserConsts.ASSIGN:
               val = right.getAny();
               left.setValue(val);
               return val;
            case ParserConsts.ASSIGN_ADD:
               val = left.getAny();
               r = right.getAny();
               if((val is XML || val is XMLList) && (r is XML || r is XMLList))
               {
                  if(val is XML)
                  {
                     val = new XMLList("") + val;
                  }
                  val = val + r;
               }
               else if(val is String || r is String)
               {
                  val = val.toString() + r.toString();
               }
               else
               {
                  val = Number(val) + Number(r);
               }
               left.setValue(val);
               return val;
            case ParserConsts.ASSIGN_AND:
            case ParserConsts.ASSIGN_OR:
               b1 = left.getBoolean();
               b2 = right.getBoolean();
               if(op == ParserConsts.ASSIGN_AND)
               {
                  b1 = b1 && b2;
               }
               else
               {
                  b1 = b1 || b2;
               }
               left.setValue(b1);
               return b1;
            default:
               var n1:Number = left.getNumber();
               var n2:Number = right.getNumber();
               switch(op)
               {
                  case ParserConsts.ASSIGN_BITOR:
                     n1 = n1 | n2;
                     break;
                  case ParserConsts.ASSIGN_BITXOR:
                     n1 = n1 ^ n2;
                     break;
                  case ParserConsts.ASSIGN_BITAND:
                     n1 = n1 & n2;
                     break;
                  case ParserConsts.ASSIGN_LSH:
                     n1 = n1 << n2;
                     break;
                  case ParserConsts.ASSIGN_RSH:
                     n1 = n1 >> n2;
                     break;
                  case ParserConsts.ASSIGN_URSH:
                     n1 = n1 >>> n2;
                     break;
                  case ParserConsts.ASSIGN_ADD:
                     n1 = n1 + n2;
                     break;
                  case ParserConsts.ASSIGN_SUB:
                     n1 = n1 - n2;
                     break;
                  case ParserConsts.ASSIGN_MUL:
                     n1 = n1 * n2;
                     break;
                  case ParserConsts.ASSIGN_DIV:
                     n1 = n1 / n2;
                     break;
                  case ParserConsts.ASSIGN_MOD:
                     n1 = n1 % n2;
               }
               left.setValue(n1);
               return n1;
         }
      }
      
      public function get next() : IStmt
      {
         return _next;
      }
   }
}
