package view
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.setTimeout;
   import model.Auction;
   import zebra.Game;
   import ws.SentLogWindow;
   import zebra.system.net.GameSocketThread;
   import zebra.system.collections.GUID;
   
   public class SentLogView extends SentLogWindow
   {
       
      
      private var _gamesocketthread:GameSocketThread;
      
      private var txt:String = "";
      
      public function SentLogView()
      {
         super();
         Game.Content.addView(this);
         closeBut.addEventListener(MouseEvent.CLICK,this.closeHandler);
         localSaveBut.addEventListener(MouseEvent.CLICK,this.SaveLogToLocal);
         sentLogDataBut.addEventListener(MouseEvent.CLICK,this.SentLogToLocalServer2);
         this.hide();
      }
      
      //hum not used function
      private function §ͅ§() : void
      {
         this._gamesocketthread = RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket;
         this._gamesocketthread.receive("3-2",this.settimeout);
      }
      
      private function SaveLogToLocal(param1:MouseEvent) : void
      {
         var _loc2_:FileReference = new FileReference();
         _loc2_.save(log.text);
      }
      
      private function closeHandler(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function SentLogToLocalServer2(param1:MouseEvent) : void
      {
         var loader:URLLoader = null;
         var e:MouseEvent = param1;
         var _auction:Auction = Auction(Game.Content.getModel(Auction));
         var uri:String = "http://" + _auction.lcserverstr + "/lc/LogCollect.svc/WebCmd?p=" + Math.random();
         var ݥ:String = GUID.create().toLowerCase();
         loader = new URLLoader();
         var ݦ:String = this.txt;
         ݦ = ݦ.split("\"").join("\\\"").split("\\n").join("+");
         var request:URLRequest = new URLRequest(uri);
         request.method = URLRequestMethod.POST;
         var ݧ:String = escape(ݦ);
         request.data = "{\"cmd\":\"" + escape(ݦ) + "\"}";
         request.contentType = "application/json";
         loader.addEventListener(Event.COMPLETE,function getHttpContentHandler(param1:Event):void
         {
            var _loc2_:String = String(loader.data);
         });
         loader.load(request);
      }
      
      private function settimeout() : void
      {
         var _loc1_:* = setTimeout(this.SentLogToLocalServer,7 * 1000);
      }
      
      private function SentLogToLocalServer(param1:*) : void
      {
         var loader:URLLoader = null;
         var e:* = param1;
         var _auction:Auction = Auction(Game.Content.getModel(Auction));
         var uri:String = "http://" + _auction.lcserverstr + "/lc/LogCollect.svc/WebCmd?p=" + Math.random();
         var ݥ:String = GUID.create().toLowerCase();
         loader = new URLLoader();
         var ݦ:String = this.txt;
         ݦ = ݦ.split("\"").join("\\\"").split("\\n").join("+");
         var request:URLRequest = new URLRequest(uri);
         request.method = URLRequestMethod.POST;
         var ݧ:String = escape(ݦ);
         request.data = "{\"cmd\":\"" + escape(ݦ) + "\"}";
         request.contentType = "application/json";
         loader.addEventListener(Event.COMPLETE,function getHttpContentHandler(param1:Event):void
         {
            var _loc2_:String = String(loader.data);
         });
         loader.load(request);
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      public function info(param1:String) : void
      {
         this.txt = this.txt + (param1 + "\n");
         log.text = this.txt;
      }
   }
}
