package view
{
	////Hum RightBidInitView负责联络BidStageServerModel
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.utils.clearTimeout;
   import model.BidStageServerModel;
   import model.LogApplication;
   import model.BidStageUserModel;
   import model.XxteaEncodeAndDecode;
   import model.UserQueue;
   import zebra.Game;
   import zebra.system.net.SocketThreadParam;
   import zebra.system.collections.FlashBytesReader;
   import Utility.BidinfoParse;
   import Controller.PriceParseControl;
   import Controller.SocketControl;
   import task.BidStageHeartAction;
   
   public class BidStageView extends Sprite
   {
      
      public static var bidstageHeart:BidStageHeartAction = new BidStageHeartAction();
             
      public var bidstagePart:BidStagePart;
      
      public var socketControl:SocketControl;
      
      public var requestid:String;
      
      public var xxtea:XxteaEncodeAndDecode;
      
      public var logappliction:LogApplication;
      
      public var serverModel:BidStageServerModel;
      
      private var _timer:uint = 0;
      
      private var _IsGet11 = false;
      
      public var _IsPut11 = false;
      
      public function BidStageView()
      {
         var userModel:BidStageUserModel = null;
         this.bidstagePart = new BidStagePart();
         this.xxtea = new XxteaEncodeAndDecode(Main.keystr);
         this.logappliction = new LogApplication();
         this.serverModel = BidStageServerModel(Game.Content.getModel(BidStageServerModel));
         super();
         Game.Content.addUpdateView(this);
         userModel = BidStageUserModel(Game.Content.getModel(BidStageUserModel));
         this.socketControl = new SocketControl("右边操作出价",this.serverModel);
         this.socketControl.successHandler = function():void
         {
        	 //TODO: reveive data, Reader2to3handler
            socketControl.socket.receive("1-1",Reader1to1Handler); //"成功连接"
            socketControl.socket.send("1-1",userModel.bytes1_1); //上线
            socketControl.socket.receive("2-2",Reader2to2Handler); //接收队列消息
            socketControl.socket.receive("2-3",Reader2to3Handler); //接收出价情况
            socketControl.socket.receive("3-2",Reader3to2Handler); //开标结果
            socketControl.socket.receive("1-2",Reader1to2Handler); //被强制下线"
            var _loc1_:String = new String("this is a new book");
         };
         this.socketControl.ioErrorHandler = function():void
         {
            _IsPut11 = false;
            Game.TimeUpdate.removeTaskAction(BidStageView.bidstageHeart);
            BidInfoView(Game.Content.getView(BidInfoView)).Bidinfo.setLightState(1);
            logappliction.WriteLogWithWarn2("行情板块","ioErrorHandler","亮红灯");
            if(!Main.isKickOut)
            {
               socketControl.reconnect(serverModel);
               BidInitView.clearwin();
            }
         };
         this.socketControl.securityErrorHandler = function():void
         {
            _IsPut11 = false;
            Game.TimeUpdate.removeTaskAction(BidStageView.bidstageHeart);
            BidInfoView(Game.Content.getView(BidInfoView)).Bidinfo.setLightState(1);
            logappliction.WriteLogWithWarn2("行情板块","securityErrorHandler","亮红灯");
            if(!Main.isKickOut)
            {
               socketControl.reconnect(serverModel);
               BidInitView.clearwin();
            }
         };
         this.socketControl.closeHandler = function():void
         {
            _IsPut11 = false;
            Game.TimeUpdate.removeTaskAction(BidStageView.bidstageHeart);
            BidInfoView(Game.Content.getView(BidInfoView)).Bidinfo.setLightState(1);
            logappliction.WriteLogWithWarn2("行情板块","closeHandler","亮红灯");
            if(!Main.isKickOut)
            {
               socketControl.reconnect(serverModel);
               BidInitView.clearwin();
            }
         };
         addChild(this.bidstagePart);
      }
      
      private function Reader3to2Handler(data:SocketThreadParam) : void
      {
         var bytesReader:FlashBytesReader = data.bytesReader.clone();
         var receiveData3to2:String = bytesReader.readString();
         var sourceStr3to2:String = this.xxtea.XxteaDecode(receiveData3to2);
         var serverJSON:String = sourceStr3to2;
      	 //trace(("3-2接收数据" + serverJSON));
         this.logappliction.WriteLogWithWarn("投标板块","开标结果3-2",serverJSON);
         var json:Object = JSON.parse(serverJSON);
         var responsecode:String = json.response.responsecode;
         var msg:String = json.response.data;
         //trace(("3-2msg" + msg));
         BidInitView(Game.Content.getView(BidInitView)).setMessage(msg,true);
      }
      
      private function Reader1to2Handler(data:SocketThreadParam) : void
      {
         this.logappliction.WriteLogWithWarn2("投标板块","1-2","被强制下线");
         //trace("=======右边  1-2  踢下线============");
         Main.isKickOut = true;
         ExternalInterface.call("clearbidcookies");
         navigateToURL(new URLRequest("javascript:clearbidcookies()"),"_self");
         
         var kickoutpart1to2:KickOutPart = new KickOutPart(1);
         BidInitView.setWin(kickoutpart1to2);
      }
      
      private function Reader2to3Handler(data:SocketThreadParam) : void
      {
         PriceWaitPart.IsOverPrice = true;
         var bytesReader:FlashBytesReader = data.bytesReader.clone();
         var receiveData2to3:String = bytesReader.readString();
         var sourceStr2to3:String = this.xxtea.XxteaDecode(receiveData2to3);
         var serverJSON:String = sourceStr2to3;
         this.logappliction.WriteLogWithWarn("投标板块","接收出价情况2-3",serverJSON);
         //trace(("接收到2-3：" + serverJSON));
         PriceParseControl.parse(serverJSON,2);
      }
      
      private function Reader2to2Handler(_sockthreadparam:SocketThreadParam) : void
      {
         var servertime:String = null;
         var responsemsg2to2:String = null;
         var bidcount:String = null;
         var bidamount:String = null;
         var bidnumber:String = null;
         var bidtime:String = null;
         var Arr2to2:Array = null;
         var firstPosition:* = undefined;
         var fitstPositionPercent:String = null;
         var temp:String = null;
         var userQueue:UserQueue = null;
         var _loc3_:String = "this is a new book".concat("a");
         var bytesReader:FlashBytesReader = _sockthreadparam.bytesReader.clone();
         var receiveData2to2:String = bytesReader.readString();
         // trace(("接收2-2：" + receiveData2to2));
         var sourceStr2to2:String = this.xxtea.XxteaDecode(receiveData2to2);
         this.logappliction.WriteLogWithWarn2("投标板块","接收队列消息2-2",sourceStr2to2);
         var serverJSON:String = sourceStr2to2;
         var json:Object = new Object();
         json = JSON.parse(serverJSON);
         var responsecode:String = json.response.responsecode;
         servertime = json.servertime;
         if(responsecode != "0")
         {
            responsemsg2to2 = json.response.responsemsg;
            BidInitView.setWin(new WarnInfoPart(responsemsg2to2,true));
            this.logappliction.WriteLogWithWarn("投标板块","接收系统提示2-2",responsemsg2to2);
            this.logappliction.WriteLogWithWarn("投标板块","接收系统提示2-2","servertime is:" + servertime);
         }
         else
         {
        	 //trace(("是否弹出了出价成功:" + PriceWaitPart.IsOverPrice));
            if(!PriceWaitPart.IsOverPrice)
            {
            	//trace("显示进度条页面:");
               BidInitView.setWin(new PriceWaitPart());
            }
            bidcount = json.response.data.bidcount;
            bidamount = json.response.data.bidamount;
            bidnumber = json.response.data.bidnumber;
            bidtime = json.response.data.bidtime;
            servertime = json.servertime;
            this.requestid = json.response.data.requestid;
            responsemsg2to2 = json.response.data.msg;
            //trace(responsemsg2to2);
            Arr2to2 = responsemsg2to2.split("，");
            if(Arr2to2[1] != null)
            {
               firstPosition = Arr2to2[2];
               fitstPositionPercent = String(Number(Arr2to2[2]) - Number(Arr2to2[3]));
               temp = "我的序号:" + Arr2to2[2] + ",正处理的序号:" + Arr2to2[3];
               this.logappliction.WriteLogWithWarn2("投标板块","接收队列消息2-2",temp + ",server time:" + servertime);
               if(UserQueue(Game.Content.getModel(UserQueue)) == null)
               {
                  userQueue = new UserQueue();
               }
               else
               {
                  userQueue = UserQueue(Game.Content.getModel(UserQueue));
               }
               userQueue.serverTargetPos = Arr2to2[2];
               userQueue.userInitPos = Arr2to2[3];
               userQueue.createWaitCount();
               //trace(("============当前处理位置" + BidinfoParse.userUpdatePos));
               if(Arr2to2[2] > BidinfoParse.userUpdatePos)
               {
                  PriceWaitPart(Game.Content.getView(PriceWaitPart)).setLoaderPos(0);
               }
               this.logappliction.WriteLogWithWarn1("投标板块","接收队列消息2-2",this.requestid);
            }
         }
      }
      
      private function Reader1to1Handler(data:SocketThreadParam) : void
      {
         BidInfoView(Game.Content.getView(BidInfoView)).Bidinfo.setLightState(2);
         this._IsGet11 = true;
         this.ClearTimeOut();
         BidStageServerModel(Game.Content.getModel(BidStageServerModel)).resetAllowChangeCount();
         this.logappliction.WriteLogWithWarn2("投标板块","上线结果1-1","成功连接");
         //trace("========右边=======1-1==================");
         var bytesReader:FlashBytesReader = data.bytesReader.clone();
         var receiveData1to1:String = bytesReader.readString();
         var sourceStr1to1:String = this.xxtea.XxteaDecode(receiveData1to1);
         var serverJSON:String = sourceStr1to1;
         PriceParseControl.parse(serverJSON,0);
         Game.TimeUpdate.addTaskAction(BidStageView.bidstageHeart,10000);
      }
      
      public function reconnect() : void
      {
    	  //trace("reconnect step 2");
         this.socketControl.reconnect(this.serverModel);
      }
      
      public function ClearTimeOut() : *
      {
         clearTimeout(this._timer);
      }
   }
}
