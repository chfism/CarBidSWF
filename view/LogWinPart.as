package view
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.setTimeout;
   import model.WebParamModel;
   import zebra.Game;
   import ws.LogWin;
   import zebra.system.net.GameSocketThread;
   import zebra.system.collections.GUID;
   
   public class LogWinPart extends LogWin
   {
       
      
      private var _socketLog:GameSocketThread;
      
      private var logText:String = "";
      
      public function LogWinPart()
      {
         super();
         Game.Content.addView(this);
         closeBut.addEventListener(MouseEvent.CLICK,this.closeHandler);
         localSaveBut.addEventListener(MouseEvent.CLICK,this.saveToLoaclHandler);
         sentLogDataBut.addEventListener(MouseEvent.CLICK,this.sentLogHandler);
         this.hide();
      }
      
      private function registered3to2() : void
      {
         this._socketLog = BidStageView(Game.Content.getView(BidStageView)).socketControl.socket;
         this._socketLog.receive("3-2",this.setTimeoutForSentLog);
      }
      
      private function saveToLoaclHandler(param1:MouseEvent) : void
      {
         var fileRef:FileReference = new FileReference();
      	fileRef.save(log.text);
      }
      
      private function closeHandler(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function sentLogHandler(param1:MouseEvent) : void
      {
         var loader:URLLoader = null;
      	//trace("将日志上传到服务器");
         var e:MouseEvent = param1;
         var _WebParamModel:WebParamModel = WebParamModel(Game.Content.getModel(WebParamModel));
         var uri:String = "http://" + _WebParamModel.logIP + "/lc/LogCollect.svc/WebCmd?p=" + Math.random();
         var uniqueid:String = GUID.create().toLowerCase();
         loader = new URLLoader();
         var temp:String = this.logText;
         temp = temp.split("\"").join("\\\"").split("\\n").join("+");
         var request:URLRequest = new URLRequest(uri);
         request.method = URLRequestMethod.POST;
         var test:String = escape(temp);
         // trace(temp.length);
         //trace(test.length);
         request.data = "{\"cmd\":\"" + escape(temp) + "\"}";
         request.contentType = "application/json";
         loader.addEventListener(Event.COMPLETE,function getHttpContentHandler(event:Event):void
         {
            var jsonstr:String = String(loader.data);
         //trace(("加载得到结果:" + jsonstr));
         });
         loader.load(request);
      }
      
      private function setTimeoutForSentLog() : void
      {
         var sentLog7Second:* = setTimeout(this.sentLogHandlerBy3to2,7 * 1000);
      }
      
      private function sentLogHandlerBy3to2(param1:*) : void
      {
         var loader:URLLoader = null;
      //trace("将日志上传到服务器");
         var e:* = param1;
         var _WebParamModel:WebParamModel = WebParamModel(Game.Content.getModel(WebParamModel));
         var uri:String = "http://" + _WebParamModel.logIP + "/lc/LogCollect.svc/WebCmd?p=" + Math.random();
         var uniqueid:String = GUID.create().toLowerCase();
         loader = new URLLoader();
         var temp:String = this.logText;
         temp = temp.split("\"").join("\\\"").split("\\n").join("+");
         var request:URLRequest = new URLRequest(uri);
         request.method = URLRequestMethod.POST;
         var test:String = escape(temp);
         request.data = "{\"cmd\":\"" + escape(temp) + "\"}";
         request.contentType = "application/json";
         loader.addEventListener(Event.COMPLETE,function getHttpContentHandler(event:Event):void
         {
            var jsonstr:String = String(loader.data);
         // trace(("加载得到结果:" + jsonstr));
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
         this.logText = this.logText + (param1 + "\n");
         log.text = this.logText;
      }
   }
}
