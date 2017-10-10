package zebra.system.net
{
	//Humphrey different with the original version
   import zebra.directEvent.DirectEventParameter;
   import zebra.system.collections.FlashBytesReader;
   
   public class SocketThreadParam extends DirectEventParameter
   {
       
      
      public var bytesReader:FlashBytesReader;
      
      private var _socketThread:GameSocketThread;
      
      public function SocketThreadParam(param1:FlashBytesReader, param2:GameSocketThread)
      {
         super();
         this.bytesReader = param1;
         this._socketThread = param2;
      }
      
      public function get channel() : String
      {
         return this._socketThread.channel;
      }
      
      public function get socketThread() : GameSocketThread
      {
         return this._socketThread;
      }
   }
}
