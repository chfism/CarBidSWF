package r1.deval.parser
{
   import ʊ.ʖ;
   
   public class ʛ extends Error
   {
      
      public static const ک:String = "PARSING CODE ERROR";
       
      
      private var ڣ:int;
      
      private var ڨ:String;
      
      public function ʛ(param1:String, param2:String, param3:int = 0)
      {
         super(ڪ(param1));
         this.ڨ = param2;
         this.ڣ = param3;
      }
      
      public static function ڪ(param1:String) : String
      {
         if(!param1)
         {
            return ک;
         }
         if(!ʖ.ڤ(param1,"msg."))
         {
         }
         return param1;
      }
      
      public function get ڠ() : int
      {
         return ڣ;
      }
      
      public function get id() : String
      {
         return !!ڨ?ڨ:"";
      }
      
      public function toString() : String
      {
         var _loc1_:String = "Parse Error: " + super.message;
         if(ڣ <= 0 && !ڨ)
         {
            return _loc1_;
         }
         if(ڣ > 0)
         {
            _loc1_ = _loc1_ + (" [line:" + ڣ);
         }
         if(id)
         {
            _loc1_ = _loc1_ + ("/" + id);
         }
         return _loc1_ + "]";
      }
   }
}
