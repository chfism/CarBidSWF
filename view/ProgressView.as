package view
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import model.Auction;
   import model.LogApplication;
   import model.SequenceNumber;
   import zebra.Game;
   import ws.UnderProcess;
   import Controller.StageControl;
   
   public class ProgressView extends UnderProcess
   {
      
      public static var _completed:Boolean = false;
       
      
      private var _urlloader:URLLoader;
      
      public var _timeoutid:uint;
      
      public var logappliction:LogApplication;
      
      private var _progress:int = 0;
      
      private var ϼ:int = 0;
      
      public function ProgressView()
      {
         this._urlloader = new URLLoader();
         this.logappliction = new LogApplication();
         super();
         Game.Content.addUpdateView(this);
         this.loader.gotoAndStop(1);
         retryBut.visible = false;
         RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket.receive("2-3",this.EndHandler);
         this.visible = !ProgressView._completed;
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
         this.logappliction.WriteLog2("行情板块","2-3http请求","100%倒计时结束");
      }
      
      public function SetMyProgress(progress:int) : void
      {
         var _loc2_:SequenceNumber = null;
         if(progress > this.ϼ)
         {
            this._progress = progress;
            this.ϼ = progress;
            _loc2_ = SequenceNumber(Game.Content.getModel(SequenceNumber));
            if(this._progress == 100)
            {
               this._progress = 99;
            }
            this.loader.gotoAndStop(this._progress);
            this.myPriceResult.text = this._progress + "%";
            if(progress == 100)
            {
               if(!_completed)
               {
                  this._timeoutid = setTimeout(this.BidQueryRequest,7 * 1000);
                  this.logappliction.WriteLog2("行情板块","2-3http请求","100%倒计时开始");
               }
            }
         }
      }
      
      private function BidQueryRequest() : void
      {
         var _loc1_:String = RightContainerView(Game.Content.getView(RightContainerView)).requestid;
         var _loc2_:Auction = Auction(Game.Content.getModel(Auction));
         var _loc3_:String = "http://" + _loc2_.webserverstr + "/bid/query.ashx?bidnumber=" + _loc2_.uid + "&requestid=" + _loc1_;
         //http://paimai2.alltobid.com:80/bid/query.ashx?bidnumber=80658434&requestid=80658434.e201710231400
       //返回内容 {"response":{"responsecode":5000,"responsemsg":"投标卡不存在","data":null},"requestid":null,"servertime":"20171023134212"}
      this.logappliction.WriteLogWithURL("投标板块","100%后7秒后请求出价情况",_loc3_);
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         _loc4_.method = URLRequestMethod.GET;
         _loc4_.contentType = "application/json";
         this._urlloader.load(_loc4_);
         this._urlloader.addEventListener(Event.COMPLETE,this.getHttpContentHandler);
      }
      
      private function getHttpContentHandler(param1:*) : void
      {
         var _loc2_:String = String(this._urlloader.data);
   // case 3: stage2-3latest(rawdata);
         StageControl.parse(_loc2_,3);
         _completed = true;
      }
   }
}
