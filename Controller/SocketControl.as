package Controller
{
   import flash.utils.setTimeout;
   import model.ServerModel ;
   import model.LogApplication;
   import zebra.Game;
   import view.LogWinPart;
   import zebra.system.net.GameSocketThread;
   
   public class SocketControl
   {
       
      
      private var _model;
      
      private var _tagName:String;
      
      public var socket:GameSocketThread;
      
      public var logappliction:LogApplication;
      
      public var successHandler:Function;
      
      public var closeHandler:Function;
      
      public var ioErrorHandler:Function;
      
      public var securityErrorHandler:Function;
      
      public function SocketControl(tagName:String, model:*)
      {
         this.logappliction = new LogApplication();
         super();
         this._tagName = tagName;
         this._model = model;
         Game.Content.removeObject("socketControl");
         Game.Content.addObject("socketControl",this);
         this.createSocket();
      }
      
      //TODO:Connect to the Socket ServerModel 
      private function createSocket() : void
      {
         this.socket = new GameSocketThread();
         this.socket.connect(this._model.ip,this._model.port);
         var _ip:String = this._model.ip;
         var _port:String = this._model.port;
         var _currentdate:Date = new Date();
         var _currentdatestr:String = String(_currentdate.getHours()) + ":" + String(_currentdate.getMinutes()) + ":" + String(_currentdate.getSeconds()) + "." + String(_currentdate.getMilliseconds());
         LogWinPart(Game.Content.getView(LogWinPart)).info(_currentdatestr + "," + "建立socket连接" + "," + "socket" + "," + "IP:" + _ip + "port:" + _port);
         this.socket.successHandler = this._connectHandler;
         this.socket.closeHandler = this._closeHandler;
         this.socket.ioErrorHandler = this._ioErrorHandler;
         this.socket.securityErrorHandler = this._securityErrorHandler;
      }
      
      public function reconnect(param1:ServerModel , param2:int = 1000) : void
      {
         var _model:ServerModel  = param1;
         var timer:int = param2;
         setTimeout(function():*
         {
            var _ip:String = null;
            var _port:String = null;
            if(!Main.isKickOut)
            {
               _model.changeIP();
               socket.connect(_model.ip,_model.port);
               _ip = _model.ip;
               _port = String(_model.port);
               logappliction.WriteLogWithWarnWithIpAndPort("投标板块","断线重连",_ip,_port);
            }
         },timer);
      }
      
      private function _securityErrorHandler(param1:GameSocketThread) : void
      {
         if(this.securityErrorHandler != null)
         {
            this.securityErrorHandler();
         }
      }
      
      private function _ioErrorHandler(param1:GameSocketThread) : void
      {
         if(this.ioErrorHandler != null)
         {
            this.ioErrorHandler();
         }
      }
      
      private function _closeHandler(param1:GameSocketThread) : void
      {
    	  //trace((this._tagName + "->断开联机"));
         if(this.closeHandler != null)
         {
            this.closeHandler();
         }
      }
      
      private function _connectHandler(param1:GameSocketThread) : void
      {
    	  //trace((this._tagName + "->联机成功"));
         if(this.successHandler != null)
         {
            this.successHandler();
         }
      }
      
      public function close() : void
      {
         this.socket.close();
      }
   }
}
