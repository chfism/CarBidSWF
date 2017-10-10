package zebra.system.net
{
   import zebra.Game;
   import zebra.system.collections.FlashBytesReader;
   import zebra.thread.task.TaskAction;
   
   //Humphrey Different with the original version
   /**
	 * 定时发送Buffer数据
	 */
   
   class SocketBufferAction extends TaskAction
   {
       
      
      private var _bufferList:Vector.<FlashBytesReader>;
      
      private var _socketThread:GameSocketThread;
      
      private var _concurrent:int = 2;
      
      function SocketBufferAction(param1:Vector.<FlashBytesReader>, param2:GameSocketThread)
      {
         super();
         this._bufferList = param1;
         this._socketThread = param2;
      }
      
      override public function execute() : void
      {
         var _loc3_:FlashBytesReader = null;
         var _loc1_:int = 0;
         if(this._bufferList.length >= this._concurrent)
         {
            _loc1_ = this._concurrent;
         }
         else
         {
            _loc1_ = this._bufferList.length;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._bufferList.shift();
            Game.DirectEvent.send(_loc3_.mainId + "-" + _loc3_.childId,new SocketThreadParam(_loc3_,this._socketThread),this._socketThread.channel);
            _loc2_++;
         }
      }
   }
}
