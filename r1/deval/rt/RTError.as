package r1.deval.rt
{
   import r1.deval.parser.ParseError;
   
   public class RTError extends Error
   {
       
      
      private var _param1:String;
      
      private var _param2:String;
      
      private var _lineno:int;
      
      public function RTError(msgId:String, p1:String = null, p2:String = null)
      {
         super(ParseError.processMessage(msgId));
         _param1 = p1;
         _param2 = p2;
      }
      
      public function set lineno(num:int) : void
      {
         _lineno = num;
      }
      
      public function get lineno() : int
      {
         return _lineno;
      }
      
      public function toString() : String
      {
         var str:String = "Runtime Error: " + super.message;
         if(_lineno > 0)
         {
            str = str + (" [line:" + _lineno + "]");
         }
         return str;
      }
   }
}
