package view
{

   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getTimer;
   import model.BidInfoServerModel;
   import model.LogApplication;
   import model.XxteaEncodeAndDecode;
   import model.UserQueue;
   import model.BidInfoUserModel;
   import zebra.Game;
   import zebra.system.net.GameSocketThread;
   import zebra.system.net.SocketThreadParam;
   import zebra.system.collections.FlashBytesReader;
   import Utility.BidinfoParse;
   import Controller.SocketControl;
   import task.BidInfoWebDataAction;
   import Event.InfoTagEvent;
   import WebParamModelmodel.BasicTradeInfo;
   import WebParamModelmodel.ITradeInfo;
   import WebParamModelmodel.NormalBidStageUserModel;
   import WebParamModelmodel.TypeDInfo;
   
   public class BidInfoView extends Sprite
   {
       
      
      public var bidinfo:BidInfoPart;
      
      public var socketControl:SocketControl;
      
      public var logappliction:LogApplication;
      
      public var xxtea:XxteaEncodeAndDecode;
      
      public function BidInfoView()
      {
         this.bidinfo = new bidinfo();
         this.logappliction = new LogApplication();
         this.xxtea = new XxteaEncodeAndDecode(Main.keystr);
         super();
         Game.Content.addUpdateView(this);
         this.bidinfo.adBtn.enabled = false;
         this.bidinfo.adBtn.visible = false;
         var bidInfoUserModel:BidInfoUserModel = BidInfoUserModel(Game.Content.getModel(BidInfoUserModel));
         var infoModel:BidInfoServerModel = BidInfoServerModel(Game.Content.getModel(BidInfoServerModel));
         var bidInitView:BidInitView = BidInitView(Game.Content.getView(BidInitView));
         var _socket:GameSocketThread = BidStageView(Game.Content.getView(BidStageView)).socketControl.socket;
         _socket.receive("3-1",this.Reader3to1Handler); //结束后的显示信息
         this.bidinfo.setLightState(2);
         addChild(this.bidinfo);
         Game.TimeUpdate.addTaskAction(new BidInfoWebDataAction(),1000);
      }
      
      private function Test(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = new URLRequest("https://www.baidu.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      /* 反编译出来的版本没有这个函数，Reader3to1Handler里多了很多逻辑
      private function Reader1to1Handler(data:SocketThreadParam):void
      {
          trace("========左边=======1-1==================");
          var bytesReader:FlashBytesReader = data.bytesReader.clone();
          var receiveData1to1:String = bytesReader.readString();
          var sourceStr1to1:String = this.xxtea.XxteaDecode(receiveData1to1);
          var serverJSON:String = sourceStr1to1;
          this.bidinfo.info.htmlText = BidInfoParse.info(serverJSON);
          var heart:BidInfoHeartAction = new BidInfoHeartAction();
          heart.execute();
          Game.Hack.keepframe();
      }
      */
      
      private function Reader3to1Handler(socketthreadparam:SocketThreadParam) : void
      {
    	  // trace("接收到3-1");
         var _loc10_:InfoTagEvent = null;
         var _htmltext:String = null;
         var _loc12_:String = null;
         var _loc13_:ITradeInfo = null;
         var _loc14_:String = null;
         var _loc15_:NormalBidStageUserModel = null;
         var _loc16_:Date = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         if(Game.Hack.debug)
         {
            BidStagePart(Game.Content.getView(BidStagePart)).bidstage.ver.text = Main.clientui_version + " 帧频：" + String(stage.frameRate);
         }
         Main.isReconnectBy31 = false;
         BidInfoWebDataAction.Reader3to1Timer = getTimer();
         this.bidinfo.setLightState(2);
         var bytesReader:FlashBytesReader = socketthreadparam.bytesReader.clone();
         var receiveData3to1:String = bytesReader.readString();
         var _loc6_:String = this.xxtea.§̝§(receiveData3to1);
         var _loc7_:String = _loc6_;
         var _basictradeinfo:BasicTradeInfo = BidinfoParse.GetTradeInfo(_loc7_);
         if(_basictradeinfo != null)
         {
            _InfoTagEvent = new InfoTagEvent();
            _InfoTagEvent._type = _basictradeinfo.type;
            _InfoTagEvent.value = _basictradeinfo;
            
            Game.DirectEvent.send(InfoTagEvent.name,_InfoTagEvent);
            _htmltext = BidinfoParse.info(_basictradeinfo);
            if(_basictradeinfo.type == "D" && TypeDInfo(_basictradeinfo).content.indexOf("拍卖成交的买受人") != -1)
            {
               _loc14_ = "拍卖成交的买受人";
               if(_htmltext.indexOf("请拍卖成交的买受人") != -1)
               {
                  _loc14_ = "请拍卖成交的买受人";
               }
               _loc12_ = _htmltext.substring(0,_htmltext.indexOf(_loc14_));
               _htmltext = _htmltext.substring(_htmltext.indexOf(_loc14_));
            }
            else if(_basictradeinfo.type == "G")
            {
               _loc12_ = "请等待拍卖信息发布";
            }
            else
            {
               _loc12_ = "";
            }
            _loc13_ = _basictradeinfo as ITradeInfo;
            if(_loc13_ != null)
            {
               BidinfoParse.userUpdatePos = _loc13_.tradeSn;
               if(Game.Hack.debug)
               {
            	   _htmltext = _htmltext + ("当前处理位置:" + _loc13_.tradeSn);
               }
            }
            this.bidinfo.info.htmlText = _htmltext;
            BidStagePart(Game.Content.getView(BidStagePart)).bidstage.bidinfo.htmlText = _loc12_;
            if(_basictradeinfo.type == "A" || _basictradeinfo.type == "B")
            {
               _loc15_ = NormalBidStageUserModel(_basictradeinfo);
               _loc16_ = new Date();
               _loc17_ = String(_loc16_.getMinutes()) + "." + String(_loc16_.getSeconds());
               _loc18_ = String(_loc15_.systemTime.getMinutes()) + "." + String(_loc15_.systemTime.getSeconds());
               LogWinPart(Game.Content.getView(LogWinPart)).info(_loc17_ + "-" + _loc18_);
            }
            if(_basictradeinfo.type == "D" || _basictradeinfo.type == "G")
            {
               this.bidinfo.adBtn.visible = true;
            }
            else
            {
               this.bidinfo.adBtn.visible = false;
            }
         }
         var userQueue:UserQueue = UserQueue(Game.Content.getModel(UserQueue));
         if(userQueue != null)
         {
            if(PriceWaitPart(Game.Content.getView(PriceWaitPart)))
            {
               PriceWaitPart(Game.Content.getView(PriceWaitPart)).setLoaderPos(userQueue.getPos());
            }
         }
      }
   }
}
