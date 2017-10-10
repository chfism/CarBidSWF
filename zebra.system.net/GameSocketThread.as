package zebra.system.net
{
	//Humphrey Different than the original version
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import zebra.directEvent.DirectEventParameter;
   import zebra.Game;
   
   public class GameSocketThread
   {
      
      public static var uuid:int = 0;
      
      public static var serverType:uint;
       
      
      public var ConnectSuccess:String = "GameSocketThreadConnect_Success";
      
      public var Close:String = "GameSocketThread_Close";
      
      public var IOerror:String = "GameSocketThread_ioerror";
      
      public var Securityerror:String = "GameSocketThread_securityerror";
      
      private var _socketManager:GameSocketManager;
      
      public var §͐§:Function;
      
      private var _autoConnectionTime:uint = 3000;
      
      private var _isAutoConnection:Boolean;
      
      private var channel:String = "GameSocketThreadchannel";
      
      public var connectHandler:Function;
      
      public var ioErrorHandler:Function;
      
      public var securityErrorHandler:Function;
      
      public var closeHandler:Function;
      
      public function GameSocketThread()
      {
         super();
         uuid++;
         this.channel = "GameSocketThreadchannel" + uuid;
         this.ConnectSuccess = "GameSocketThreadConnect_Success" + uuid;
         this.Close = "GameSocketThread_Close" + uuid;
         this.IOerror = "GameSocketThread_ioerror" + uuid;
         this.Securityerror = "GameSocketThread_securityerror" + uuid;
         this._socketManager = new GameSocketManager(this);
         this._socketManager.connectHandler = this._connectHandler;
         this._socketManager.ioErrorHandler = this._ioErrorHandler;
         this._socketManager.securityErrorHandler = this._securityErrorHandler;
         this._socketManager.closeHandler = this._closeHandler;
      }
      
      public function setSendBytesByConnect(param1:Function) : void
      {
         this._socketManager.sendBytesByConnect = param1;
      }
      /**
		 * 接受buffer缓冲的数据
		 * @param	command
		 * @param	action
		 */
      public function receive(command:String, action:*):void
		{
			Game.DirectEvent.receive(command, action, channel);
		}
		
      
      public function destroy(param1:String, param2:*) : void
      {
         Game.DirectEvent.destroy(param1,param2,this.channel);
      }
      /**
		 * 向服务器端发送协议数据
		 * @param	command
		 * @param	data
		 */
      public function send(command:String, data:ByteArray) : void
      {
    	  _socketManager.sendCommand(command, data);
      }
      
      private function _closeHandler() : void
      {
         if(this.closeHandler != null)
         {
            this.closeHandler(this);
         }
         Game.DirectEvent.send(this.Close,new DirectEventParameter(),this.channel);
         if(this._isAutoConnection)
         {
            setTimeout(function():void
            {
               Game.SocketThread.connect(_socketManager.ip,_socketManager.port,serverType);
            },this._autoConnectionTime);
         }
      }
      
      private function _ioErrorHandler() : void
      {
         if(this.ioErrorHandler != null)
         {
            this.ioErrorHandler(this);
         }
         Game.DirectEvent.send(this.IOerror,new DirectEventParameter(),this.channel);
         if(this._isAutoConnection)
         {
            setTimeout(function():void
            {
               Game.SocketThread.connect(_socketManager.ip,_socketManager.port,serverType);
            },this._autoConnectionTime);
         }
      }
      
      private function _securityErrorHandler() : void
      {
         if(this.securityErrorHandler != null)
         {
            this.securityErrorHandler(this);
         }
         Game.DirectEvent.send(this.Securityerror,new DirectEventParameter(),this.channel);
      }
      
      private function _connectHandler() : void
      {
         if(this.connectHandler != null)
         {
            this.connectHandler(this);
         }
         Game.DirectEvent.send(this.ConnectSuccess,new DirectEventParameter(),this.channel);
      }
      
      public function connect(param1:String, param2:int, param3:uint = 0) : void
      {
         this._socketManager.connect(param1,param2);
         param3 = param3;
      }
      /**
		 * 设置自动联机
		 */
      public function setAutoConnect(param1:uint = 3000) : void
      {
         this._autoConnectionTime = param1;
         this._isAutoConnection = true;
      }
      //取消设置的自动联机
      public function unsetAutoConnect() : void
      {
         this._isAutoConnection = false;
      }
      
      public function close() : void
      {
         this._socketManager.close();
      }
      
      public function get channel() : String
      {
         return this.channel;
      }
      
      public function get isConnected() : Boolean
      {
         return this._socketManager.isConnected;
      }
   }
}
