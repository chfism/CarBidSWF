package r1.deval.parser
{
   import r1.deval.rt.Util;
   
   public class ParseError extends Error
   {
      
      public static const codeBugMessage:String = "PARSING CODE ERROR";
       
      
      private var _lineno:int;
      
      private var _id:String;
      
      public function ParseError(msg:String, id:String, lineno:int = 0)
      {
         super(processMessage(msg));
         this._id = id;
         this._lineno = lineno;
      }
      
      public static function processMessage(msg:String) : String
      {
         if(!msg)
         {
            return codeBugMessage;
         }
         if(!Util.beginsWith(msg,"msg."))
         {
         }
         return msg;
      }
      
      public function get lineno() : int
      {
         return _lineno;
      }
      
      public function get id() : String
      {
         return Boolean(_id)?_id:"";
      }
      
      public function toString() : String
      {
         var str:String = "Parse Error: " + super.message;
         if(_lineno <= 0 && !_id)
         {
            return str;
         }
         if(_lineno > 0)
         {
            str = str + (" [line:" + _lineno);
         }
         if(id)
         {
            str = str + ("/" + id);
         }
         return str + "]";
      }
   }
}
