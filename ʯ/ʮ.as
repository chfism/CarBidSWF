package ʯ
{
   import flash.utils.ByteArray;
   
   public class ʮ
   {
       
      
      private var _bytearray:ByteArray;
      
      public function ʮ(param1:String = null)
      {
         super();
         _bytearray = new ByteArray();
         if(param1 != null)
         {
            ܖ(param1);
         }
      }
      
      public function substr(param1:int = 0, param2:int = 2147483647) : String
      {
         return toString().substr(param1,param2);
      }
      
      public function ܖ(param1:*) : ʮ
      {
         if(param1 != null)
         {
            _bytearray.writeUTFBytes(param1.toString());
         }
         return this;
      }
      
      public function get length() : int
      {
         return _bytearray.length;
      }
      
      public function substring(param1:int = 0, param2:int = 2147483647) : String
      {
         return toString().substring(param1,param2);
      }
      
      public function toString() : String
      {
         _bytearray.position = 0;
         return _bytearray.readUTFBytes(_bytearray.bytesAvailable);
      }
      
      public function clear() : void
      {
         _bytearray.length = 0;
      }
      
      public function ܘ(param1:* = null) : void
      {
         if(param1 != null)
         {
            ܖ(param1);
         }
         ܖ("\n");
      }
   }
}
