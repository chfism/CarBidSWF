package zebra.system.net
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import zebra.Game;
   import zebra.system.collections.FlashBytesReader;
   import zebra.system.util.SocketPackUtil;
   import zebra.events.GameSocketEvent;
   
   class GameSocketManager extends EventDispatcher implements IGameSocket
   {
       
      
      private var _socket:Socket;
      
      private var _buffer:ByteArray;
      
      private var _ip:String;
      
      private var _port:int;
      
      private var _settingPackLength:uint = 4;
      
      private var _socketBufferAction:SocketBufferAction;
      
      private var _bufferList:Vector.<FlashBytesReader>;
      
      public var ioErrorHandler:Function;
      
      public var securityErrorHandler:Function;
      
      public var connectHandler:Function;
      
      public var closeHandler:Function;
      
      public var sendBytesByConnect:Function;
      
      private var channel:String;
      
      private var _socketThread:GameSocketThread;
      
      function GameSocketManager(param1:GameSocketThread)
      {
         super();
         this._socketThread = param1;
         this._bufferList = new Vector.<FlashBytesReader>();
         this._socket = new Socket();
         this._buffer = new ByteArray();
         this._socketBufferAction = new SocketBufferAction(this._bufferList,this._socketThread);
         Game.TimeUpdate.addTaskAction(this._socketBufferAction);
      }
      
      public function connect(ip:String, port:int) : void
      {
         this._ip = ip;
         this._port = port;
         this._socket.addEventListener(Event.CONNECT,this.onConnect);
         this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.getSocketData);
         this._socket.addEventListener(Event.CLOSE,this.onClose);
         this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._socket.connect(param1,param2);
         this._socket.timeout = 5000;
      }
      
      public function close() : void
      {
         try
         {
            this._socket.close();
            return;
         }
         catch(e:*)
         {
            return;
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         if(this.ioErrorHandler != null)
         {
            this.ioErrorHandler();
         }
         dispatchEvent(new GameSocketEvent(GameSocketEvent.IOERROR));
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         if(this.securityErrorHandler != null)
         {
            this.securityErrorHandler();
         }
         dispatchEvent(new GameSocketEvent(GameSocketEvent.SECURITYERROR));
      }
      
      private function onConnect(param1:Event) : void
      {
         if(this.sendBytesByConnect != null)
         {
            this.sendBytesByConnect();
         }
         if(this.connectHandler != null)
         {
            this.connectHandler();
         }
         dispatchEvent(new GameSocketEvent(GameSocketEvent.CONNECTSUCCESS));
         //Hum the orignal version has this method
         //sendFlashPlayerHeader();
      }
      
      private function sendFlashPlayerHeader() : void
      {
    	  this._socket.writeMultiByte("<swf-connect-request/>\n","utf-8");
          this._socket.flush();
      }
      
      private function onClose(param1:Event) : void
      {
         if(this.closeHandler != null)
         {
            this.closeHandler();
         }
         dispatchEvent(new GameSocketEvent(GameSocketEvent.CLOSE));
      }
      
      protected function parseNetStream() : void
      {
    	  if (_buffer.length >= 4)
			{
				_buffer.position = 0;
				var packLen:uint = _buffer.readUnsignedInt();
				if (_buffer.length >= packLen)
				{
					var bytesReader:ByteArray = new ByteArray();
						bytesReader.writeBytes(_buffer, 0, packLen);
					
			 
					//服务器数据放入bufferList
					var reader:FlashBytesReader = new FlashBytesReader(bytesReader);
					_bufferList.push(reader);
					//_bufferList.push(reader.clone());
					//trace("接收到:" + reader.mainId + "--" + reader.childId);
					//var event:GameSocketEvent = new GameSocketEvent(GameSocketEvent.COMMANDREADER);
					//event.bytesReader = reader;
					//dispatchEvent(event);
					 
					
					//剩余包数据处理
					var surplusBytes:ByteArray = new ByteArray();
						surplusBytes.writeBytes(_buffer, packLen);
					_buffer.clear();
					_buffer = surplusBytes;
					parseNetStream();
				}
			}
      }
      
      protected function getSocketData(e:ProgressEvent) : void
      {
    	  if (_socket.bytesAvailable > 0)
			{
				_buffer.position = _buffer.length;
				var currentData:ByteArray = new ByteArray();
				_socket.readBytes(currentData);
				_buffer.writeBytes(currentData);
				parseNetStream();
			}
      }
      
      public function send(byteArray:ByteArray):void
		{
			if (_socket.connected)
			{
				_socket.writeBytes(byteArray);
				_socket.flush();
			}
		}
      
      public function sendCommand(param1:String, param2:ByteArray) : void
      {
         this.send(SocketPackUtil.setPackHeader(param1,param2));
      }
      
      public function get bufferList() : Vector.<FlashBytesReader>
      {
         return this._bufferList;
      }
      
      public function get ip() : String
      {
         return this._ip;
      }
      
      public function get port() : int
      {
         return this._port;
      }
      
      public function get isConnected() : Boolean
      {
         return this._socket.connected;
      }
   }
}
