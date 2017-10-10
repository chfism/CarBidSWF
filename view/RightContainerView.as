package view
{
	////Hum RightContainer负责联络TradeServer
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.utils.clearTimeout;
   import model.TradeServer;
   import model.LogApplication;
   import model.AuctionInfo;
   import model.EncodeAndDecode;
   import model.SequenceNumber;
   import zebra.Game;
   import zebra.system.net.SocketThreadParam;
   import zebra.system.collections.FlashBytesReader;
   import Utility.DateAndStrUtil;
   import Controller.StageControl;
   import Controller.SocketControl;
   import task.TimeDiff;
   
   public class RightContainerView extends Sprite
   {
      
      public static var _timediff:TimeDiff = new TimeDiff();
             
      public var _sceneview:SceneView;
      
      public var socketControl:SocketControl;
      
      public var requestid:String;
      
      public var xxtea:EncodeAndDecode;
      
      public var logappliction:LogApplication;
      
      public var serverModel:TradeServer;
      
      private var id:uint = 0;
      
      private var _bool = false;
      
      public var _IsPut11 = false;
      
      public function RightContainerView()
      {
         var _auctioninfo:AuctionInfo = null;
         this._sceneview = new SceneView();
         this.xxtea = new EncodeAndDecode(Main.keystr);
         this.logappliction = new LogApplication();
         this.serverModel = TradeServer(Game.Content.getModel(TradeServer));
         super();
         Game.Content.addUpdateView(this);
         _auctioninfo = AuctionInfo(Game.Content.getModel(AuctionInfo));
         this.socketControl = new SocketControl("右边操作出价",this.serverModel);
         this.socketControl.connectHandler = function():void
         {
        	 //TODO: reveive data, Reader2to3handler
            socketControl.socket.receive("1-1",Reader1to1Handler); //"成功连接"
            socketControl.socket.send("1-1",_auctioninfo.GoOnlineRequest); //上线
            socketControl.socket.receive("2-2",Reader2to2Handler); //接收队列消息
            socketControl.socket.receive("2-3",Reader2to3Handler); //接收出价情况
            socketControl.socket.receive("3-2",Reader3to2Handler); //开标结果
            socketControl.socket.receive("1-2",Reader1to2Handler); //被强制下线"
            var _loc1_:String = new String("this is a new book");
         };
         this.socketControl.ioErrorHandler = function():void
         {
            _IsPut11 = false;
            Game.TimeUpdate.removeTaskAction(RightContainerView._timediff);
            LeftContainerView(Game.Content.getView(LeftContainerView)).networklightview.lightstop(1);
            logappliction.WriteLog2("行情板块","ioErrorHandler","亮红灯");
            if(!Main._disconnected)
            {
               socketControl.reconnect(serverModel);
               Container.removechildren();
            }
         };
         this.socketControl.securityErrorHandler = function():void
         {
            _IsPut11 = false;
            Game.TimeUpdate.removeTaskAction(RightContainerView._timediff);
            LeftContainerView(Game.Content.getView(LeftContainerView)).networklightview.lightstop(1);
            logappliction.WriteLog2("行情板块","securityErrorHandler","亮红灯");
            if(!Main._disconnected)
            {
               socketControl.reconnect(serverModel);
               Container.removechildren();
            }
         };
         this.socketControl.closeHandler = function():void
         {
            _IsPut11 = false;
            Game.TimeUpdate.removeTaskAction(RightContainerView._timediff);
            LeftContainerView(Game.Content.getView(LeftContainerView)).networklightview.lightstop(1);
            logappliction.WriteLog2("行情板块","closeHandler","亮红灯");
            if(!Main._disconnected)
            {
               socketControl.reconnect(serverModel);
               Container.removechildren();
            }
         };
         addChild(this._sceneview);
      }
      
      private function Reader3to2Handler(param1:SocketThreadParam) : void
      {
         var _loc2_:FlashBytesReader = param1.bytesReader.clone();
         var _loc3_:String = _loc2_.readString();
         var _loc4_:String = this.xxtea.Base64Decrypted(_loc3_);
         var _loc5_:String = _loc4_;
         this.logappliction.WriteLog("投标板块","开标结果3-2",_loc5_);
         var _loc6_:Object = JSON.parse(_loc5_);
         var _responsecode:String = _loc6_.response.responsecode;
         var _responsedata:String = _loc6_.response.data;
         Container(Game.Content.getView(Container)).PopMessage(_responsedata,true);
      }
      
      private function Reader1to2Handler(param1:SocketThreadParam) : void
      {
         this.logappliction.WriteLog2("投标板块","1-2","被强制下线");
         Main._disconnected = true;
         ExternalInterface.call("clearbidcookies");
         navigateToURL(new URLRequest("javascript:clearbidcookies()"),"_self");
         
         §§push(1);
         if(!new MovieClip()["@doswf__stage"])
         {
            return;
         }
         §§push(new §§pop().ConnectionStatus(§§pop()));
         if(!new MovieClip()["@doswf__stage"])
         {
            return;
         }
         var _loc3_:* = §§pop();
         Container.DisplayCurrentObject(_loc3_);
      }
      
      private function Reader2to3Handler(param1:SocketThreadParam) : void
      {
         ProgressView._completed = true;
         var _loc2_:FlashBytesReader = param1.bytesReader.clone();
         §§push(_loc2_.readString());
         var _loc3_:* = §§pop();
         var _loc4_:String = this.xxtea.Base64Decrypted(_loc3_);
         var _loc5_:String = _loc4_;
         this.logappliction.WriteLog("投标板块","接收出价情况2-3",_loc5_);
         //case 2:stage2-3server(rawdata);
         StageControl.parse(_loc5_,2);
      }
      
      private function Reader2to2Handler(_sockthreadparam:SocketThreadParam) : void
      {
         var _servertime:String = null;
         var responseMessage:String = null;
         var _bidcount:String = null;
         var _bidamount:String = null;
         var _bidnumber:String = null;
         var _bidtime:String = null;
         var _parsedMessage:Array = null;
         var _loc17_:* = undefined;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:SequenceNumber = null;
         var _loc3_:String = "this is a new book".concat("a");
         var _flashbypereader:FlashBytesReader = _sockthreadparam.bytesReader.clone();
         var _loc5_:String = _flashbypereader.readString();
         var _decryptedstr:String = this.xxtea.Base64Decrypted(_loc5_);
         this.logappliction.WriteLog2("投标板块","接收队列消息2-2",_decryptedstr);
         var _loc7_:String = _decryptedstr;
         var _loc8_:Object = new Object();
         _loc8_ = JSON.parse(_loc7_);
         var _responsecode:String = _loc8_.response.responsecode;
         _servertime = _loc8_.servertime;
         if(_responsecode != "0")
         {
            responseMessage = _loc8_.response.responsemsg;
            Container.DisplayCurrentObject(new PopMessageView(responseMessage,true));
            this.logappliction.WriteLog("投标板块","接收系统提示2-2",responseMessage);
            this.logappliction.WriteLog("投标板块","接收系统提示2-2","servertime is:" + _servertime);
         }
         else
         {
            if(!ProgressView._completed)
            {
               Container.DisplayCurrentObject(new ProgressView());
            }
            _bidcount = _loc8_.response.data.bidcount;
            _bidamount = _loc8_.response.data.bidamount;
            _bidnumber = _loc8_.response.data.bidnumber;
            _bidtime = _loc8_.response.data.bidtime;
            _servertime = _loc8_.servertime;
            this.requestid = _loc8_.response.data.requestid;
            responseMessage = _loc8_.response.data.msg;
            _parsedMessage = responseMessage.split("，");
            if(_parsedMessage[1] != null)
            {
               //_loc17_ = _parsedMessage[2];
               _loc18_ = String(Number(_parsedMessage[2]) - Number(_parsedMessage[3]));
               _loc19_ = "我的序号:" + _parsedMessage[2] + ",正处理的序号:" + _parsedMessage[3];
               this.logappliction.WriteLog2("投标板块","接收队列消息2-2",_loc19_ + ",server time:" + _servertime);
               if(SequenceNumber(Game.Content.getModel(SequenceNumber)) == null)
               {
                  _loc20_ = new SequenceNumber();
               }
               else
               {
                  _loc20_ = SequenceNumber(Game.Content.getModel(SequenceNumber));
               }
               _loc20_.mySN = _parsedMessage[2];
               _loc20_.systemSN = _parsedMessage[3];
               _loc20_.SNDiff();
               if(_parsedMessage[2] > DateAndStrUtil.currentSN)
               {
                  ProgressView(Game.Content.getView(ProgressView)).SetMyProgress(0);
               }
               this.logappliction.WriteLogWithRequestID("投标板块","接收队列消息2-2",this.requestid);
            }
         }
      }
      
      private function Reader1to1Handler(_socketthread:SocketThreadParam) : void
      {
         LeftContainerView(Game.Content.getView(LeftContainerView)).networklightview.lightstop(2);
         this._bool = true;
         this.ClearTimeOut();
         TradeServer(Game.Content.getModel(TradeServer)).resetAllowChangeCount();
         this.logappliction.WriteLog2("投标板块","上线结果1-1","成功连接");
         var _flashbytesreader:FlashBytesReader = _socketthread.bytesReader.clone();
         var _loc3_:String = _flashbytesreader.readString();
         var _loc4_:String = this.xxtea.Base64Decrypted(_loc3_);
         var _loc5_:String = _loc4_;
         //case 0: SceneView
         StageControl.parse(_loc5_,0);
         Game.TimeUpdate.addTaskAction(RightContainerView._timediff,10000);
      }
      
      public function reconnect() : void
      {
         this.socketControl.reconnect(this.serverModel);
      }
      
      public function ClearTimeOut() : *
      {
         clearTimeout(this.id);
      }
   }
}
