package view
{
	//Hum LeftContainer负责联络InformationServer
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getTimer;
   import model.InformationServer;
   import model.LogApplication;
   import model.EncodeAndDecode;
   import model.SequenceNumber;
   import model.RequestString;
   import zebra.Game;
   import zebra.system.net.GameSocketThread;
   import zebra.system.net.SocketThreadParam;
   import zebra.system.collections.FlashBytesReader;
   import Utility.DateAndStrUtil;
   import Controller.SocketControl;
   import task.TimeDelay;
   import Event.AuctionEvent;
   import auctionmodel.BasicTradeInfo;
   import auctionmodel.ITradeInfo;
   import auctionmodel.NormalAuctionInfo;
   import auctionmodel.TypeDInfo;
   
   public class LeftContainerView extends Sprite
   {
       
      
      public var networklightview:NetworkLightView;
      
      public var socketControl:SocketControl;
      
      public var logappliction:LogApplication;
      
      public var xxtea:EncodeAndDecode;
      
      public function LeftContainerView()
      {
         this.networklightview = new NetworkLightView();
         this.logappliction = new LogApplication();
         this.xxtea = new EncodeAndDecode(Main.keystr);
         super();
         Game.Content.addUpdateView(this);
         this.networklightview.adBtn.enabled = false;
         this.networklightview.adBtn.visible = false;
         var _requeststr:RequestString = RequestString(Game.Content.getModel(RequestString));
         var _informationserver:InformationServer = InformationServer(Game.Content.getModel(InformationServer));
         var _container:Container = Container(Game.Content.getView(Container));
         var _gamesocketthread:GameSocketThread = RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket;
         _gamesocketthread.receive("3-1",this.Reader3to1Handler); //结束后的显示信息
         this.networklightview.lightstop(2);
         addChild(this.networklightview);
         Game.TimeUpdate.addTaskAction(new TimeDelay(),1000);
      }
      
      private function Test(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = new URLRequest("https://www.baidu.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      private function Reader3to1Handler(socketthreadparam:SocketThreadParam) : void
      {
         var _loc10_:AuctionEvent = null;
         var _htmltext:String = null;
         var _loc12_:String = null;
         var _loc13_:ITradeInfo = null;
         var _loc14_:String = null;
         var _loc15_:NormalAuctionInfo = null;
         var _loc16_:Date = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         if(Game.Hack.debug)
         {
            SceneView(Game.Content.getView(SceneView)).bidstage.ver.text = Main._version + " 帧频：" + String(this["@doswf__stage"].frameRate);
         }
         Main.isReconnectBy31 = false;
         TimeDelay._time = getTimer();
         this.networklightview.lightstop(2);
         var _flashbytereader:FlashBytesReader = socketthreadparam.bytesReader.clone();
         var _bytereaderstr:String = _flashbytereader.readString();
         var _loc6_:String = this.xxtea.§̝§(_bytereaderstr);
         var _loc7_:String = _loc6_;
         var _basictradeinfo:BasicTradeInfo = DateAndStrUtil.FillAuctionInfoData(_loc7_);
         if(_basictradeinfo != null)
         {
            _auctionevent = new AuctionEvent();
            _auctionevent._type = _basictradeinfo.type;
            _auctionevent.value = _basictradeinfo;
            
            Game.DirectEvent.send(AuctionEvent.name,_auctionevent);
            _htmltext = DateAndStrUtil.info(_basictradeinfo);
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
               DateAndStrUtil.currentSN = _loc13_.tradeSn;
               if(Game.Hack.debug)
               {
            	   _htmltext = _htmltext + ("当前处理位置:" + _loc13_.tradeSn);
               }
            }
            this.networklightview.info.htmlText = _htmltext;
            SceneView(Game.Content.getView(SceneView)).bidstage.networklightview.htmlText = _loc12_;
            if(_basictradeinfo.type == "A" || _basictradeinfo.type == "B")
            {
               _loc15_ = NormalAuctionInfo(_basictradeinfo);
               _loc16_ = new Date();
               _loc17_ = String(_loc16_.getMinutes()) + "." + String(_loc16_.getSeconds());
               _loc18_ = String(_loc15_.systemTime.getMinutes()) + "." + String(_loc15_.systemTime.getSeconds());
               SentLogView(Game.Content.getView(SentLogView)).info(_loc17_ + "-" + _loc18_);
            }
            if(_basictradeinfo.type == "D" || _basictradeinfo.type == "G")
            {
               this.networklightview.adBtn.visible = true;
            }
            else
            {
               this.networklightview.adBtn.visible = false;
            }
         }
         var _sequencenumber:SequenceNumber = SequenceNumber(Game.Content.getModel(SequenceNumber));
         if(_sequencenumber != null)
         {
            if(ProgressView(Game.Content.getView(ProgressView)))
            {
               ProgressView(Game.Content.getView(ProgressView)).SetMyProgress(_sequencenumber.MyBidProgress());
            }
         }
      }
   }
}
