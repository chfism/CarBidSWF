package view
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import model.WebParamModel;
   import model.LogApplication;
   import model.UserQueue;
   import zebra.Game;
   import ws.UnderProcess;
   import control.PriceParseControl;
   
   public class PriceWaitPart extends UnderProcess
   {
      
      public static var IsOverPrice:Boolean = false;
       
      
      private var loader2:URLLoader;
      
      public var _timeoutid:uint;
      
      public var logappliction:LogApplication;
      
      private var _val:int = 0;
      
      private var ϼ:int = 0;
      
      public function PriceWaitPart()
      {
         this.loader2 = new URLLoader();
         this.logappliction = new LogApplication();
         super();
         Game.Content.addUpdateView(this);
         this.loader.gotoAndStop(1);
         retryBut.visible = false;
         BidStageView(Game.Content.getView(BidStageView)).socketControl.socket.receive("2-3",this.EndHandler);
         this.visible = !PriceWaitPart.IsOverPrice;
      }
      
      private function closeHandler(param1:MouseEvent) : void
      {
         this.parent.removeChild(this);
      }
      
      private function EndHandler(param1:*) : void
      {
         this.End();
      }
      
      public function End() : void
      {
         clearTimeout(this._timeoutid);
         this.logappliction.WriteLogWithWarn2("行情板块","2-3http请求","100%倒计时结束");
      }
      
      public function setLoaderPos(val:int) : void
      {
         var userQueue:UserQueue = null;
      // trace(("进度条" + val));
         if(val > this.ϼ)
         {
            this._val = val;
            this.ϼ = val;
            userQueue = UserQueue(Game.Content.getModel(UserQueue));
            //trace((val + "%"));
            if(this._val == 100)
            {
               this._val = 99;
            }
            this.loader.gotoAndStop(this._val);
            this.myPriceResult.text = this._val + "%";
            if(val == 100)
            {
               if(!IsOverPrice)
               {
                  this._timeoutid = setTimeout(this.httpGet2to3,7 * 1000);
                  this.logappliction.WriteLogWithWarn2("行情板块","2-3http请求","100%倒计时开始");
               }
            }
         }
      }
      
      private function httpGet2to3() : void
      {
         var requestid:String = BidStageView(Game.Content.getView(BidStageView)).requestid;
         var webParamModel:WebParamModel = WebParamModel(Game.Content.getModel(WebParamModel));
         var httpUrl:String = "http://" + webParamModel.httpIP + "/bid/query.ashx?bidnumber=" + webParamModel.uid + "&requestid=" + requestid;
         //http://paimai2.alltobid.com:80/bid/query.ashx?bidnumber=80658434&requestid=80658434.e201710231400
       //返回内容 {"response":{"responsecode":5000,"responsemsg":"投标卡不存在","data":null},"requestid":null,"servertime":"20171023134212"}
      this.logappliction.WriteLogWithWarnWithURL("投标板块","100%后7秒后请求出价情况",httpUrl);
         var request:URLRequest = new URLRequest(httpUrl);
      request.method = URLRequestMethod.GET;
      request.contentType = "application/json";
         this.loader2.load(request);
         this.loader2.addEventListener(Event.COMPLETE,this.getHttpContentHandler);
      }
      
      private function getHttpContentHandler(param1:*) : void
      {
         var jsonstr:String = String(this.loader2.data);
   // case 3: httpState2_3(jsonstr);
         PriceParseControl.parse(jsonstr,3);
         IsOverPrice = true;
      }
   }
}
