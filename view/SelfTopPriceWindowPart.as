package view
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.TextField;
   import model.WebParamModel;
   import model.LogApplication;
   import model.BidStageUserModel;
   import model.XxteaEncodeAndDecode;
   import zebra.Game;
   import ws.SelfTopPriceWindow;
   import zebra.content.GameAsset;
   import Controller.PriceParseControl;
   import zebra.loaders.IAssetLoader;
   
   public class SelfTopPriceWindowPart extends SelfTopPriceWindow
   {
       
      
      private var imageurl:String;
      
      private var _uniqueid:String;
      
      public var logappliction:LogApplication;
      
      private var xxteaHttp:XxteaEncodeAndDecode;
      
      public function SelfTopPriceWindowPart()
      {
         this.logappliction = new LogApplication();
         this.xxteaHttp = new XxteaEncodeAndDecode(Main.keystr);
         super();
         yzcode.restrict = "0-9";
         cancelBut.addEventListener(MouseEvent.CLICK,this.CloseHandler);
         okBut.addEventListener(MouseEvent.CLICK,this.submitHandler);
         addEventListener(Event.ADDED_TO_STAGE,this.addTostageHandler);
      }
      
      private function addTostageHandler(param1:Event) : void
      {
         var _WebParamModel:WebParamModel = null;
         var uri:String = null;
         var loader:URLLoader = null;
         var request:URLRequest = null;
         var e:Event = param1;
         stage.focus = yzcode;
         this.logappliction.WriteLogWithWarn2("投标板块","http查询最新出价情况","");
         var bidcode:Number = BidStagePart(Game.Content.getView(BidStagePart)).bidcode;
         if(bidcode == 3)
         {
            BidInitView.setWin(new WarnInfoPart(7));
         }
         else if(bidcode == 4)
         {
            BidInitView.setWin(new WarnInfoPart(10));
         }
         else if(bidcode == 5)
         {
            BidInitView.setWin(new WarnInfoPart(11));
         }
         else if(bidcode == 6)
         {
            BidInitView.setWin(new WarnInfoPart(12));
         }
         else
         {
        	 //webserver=paimai2.alltobid.com:80
            _WebParamModel = WebParamModel(Game.Content.getModel(WebParamModel));
            uri = "http://" + _WebParamModel.httpIP + "/webwcf/BidCmd.svc/WebCmd?p=" + Math.random();
            loader = new URLLoader();
            request = new URLRequest(uri);
            request.method = URLRequestMethod.POST;
            request.data = BidStageUserModel(Game.Content.getModel(BidStageUserModel)).selfPriceInfowithoutUniqueid();
            request.contentType = "application/json";
            loader.addEventListener(Event.COMPLETE,function getHttpContentHandler(param1:Event):void
            {
               var startIndex:int = 0;
               var endindex:int = 0;
               var jsonstr:String = String(loader.data);
            //trace(("获取校验码：" + jsonstr));
               if(jsonstr.indexOf("</string") == -1)
               {
                  jsonstr = jsonstr.split("\\\"").join("\"");
                  jsonstr = jsonstr.substr(1,jsonstr.length - 2);
               }
               else
               {
                  startIndex = jsonstr.indexOf("/\">");
                  endindex = jsonstr.indexOf("</string>");
                  jsonstr = jsonstr.substring(startIndex + 3,endindex);
               }
               var selfInfo1:String = jsonstr.split("\\/").join("/");
               var _loc4_:String = selfInfo1;
               var _loc5_:Object = JSON.parse(_loc4_);
               var imageData:String = _loc5_.response.data;
               var imageHttpArr:Array = new Array();
               imageHttpArr = imageData.split(",",imageData.length);
               var imageurl:String = imageHttpArr[1];
               _uniqueid = imageHttpArr[0];
               //trace(("imageurl is:" + imageurl));
               loadimage(imageurl);
               logappliction.WriteLogWithWarnWithURL("投标板块","请求最新出价情况校验码",imageurl);
            });
            loader.load(request);
         }
      }
      
      private function loadimage(url:String) : void
      {
         var tf:TextField = null;
         var c:DisplayObject = null;
         if(param1 != null)
         {
            param1 = " <img src=\'" + url + "\' id=\'image2\'>";
            tf = new TextField();
            tf.htmlText = url;
            addChild(tf);
            c = tf.getImageReference("image2");
            c.x = 310;
            c.y = 200;
            addChild(c);
         }
         else
         {
            this.CloseHandler(null);
         }
      }
      
      private function submitHandler(e:MouseEvent) : void
      {
         var warn:WarnInfoPart = null;
         if(yzcode.text.length == 0)
         {
        	 warn = new WarnInfoPart(4);
            BidInitView.setWin(warn);
         }
         else
         {
            this.sendAndGetPriceInfo();
         }
         this.CloseHandler(e);
      }
      
      private function CloseHandler(param1:MouseEvent) : void
      {
         try
         {
            this.parent.removeChild(this);
            return;
         }
         catch(e:*)
         {
            return;
         }
      }
      
      private function showSelfTopPriceWindow(param1:IAssetLoader) : void
      {
         param1.content.x = 310;
         param1.content.y = 200;
         addChild(param1.content);
         GameAsset.destroy(param1.key,this.showSelfTopPriceWindow);
      }
      
      private function sendAndGetPriceInfo() : void
      {
         var loader:URLLoader = null;
         var _WebParamModel:WebParamModel = WebParamModel(Game.Content.getModel(WebParamModel));
         var uri:String = "http://" + _WebParamModel.httpIP + "/webwcf/BidCmd.svc/WebCmd?p=" + Math.random();
         this.logappliction.WriteLogWithWarnWithURL("投标板块","请求最新出价情况",uri);
         loader = new URLLoader();
         var request:URLRequest = new URLRequest(uri);
         request.method = URLRequestMethod.POST;
         request.data = BidStageUserModel(Game.Content.getModel(BidStageUserModel)).sendPriceInfo(yzcode.text,this._uniqueid);
         request.contentType = "application/json";
         loader.load(request);
         loader.addEventListener(Event.COMPLETE,function getHttpContentHandler(param1:Event):void
         {
            var startIndex:int = 0;
            var endindex:int = 0;
            var jsonstrSelfInfo:String = String(loader.data);
            if(jsonstrSelfInfo.indexOf("</string") == -1)
            {
               jsonstrSelfInfo = jsonstrSelfInfo.split("\\\"").join("\"");
               jsonstrSelfInfo = jsonstrSelfInfo.substr(1,jsonstrSelfInfo.length - 2);
            }
            else
            {
               startIndex = jsonstrSelfInfo.indexOf("/\">");
               endindex = jsonstrSelfInfo.indexOf("</string>");
               jsonstrSelfInfo = jsonstrSelfInfo.substring(startIndex + 3,endindex);
            }
            var selfInfo1:String = jsonstrSelfInfo.split("\\/").join("/");
            var selfInfo:String = selfInfo1;
            logappliction.WriteLogWithWarn("投标板块","接收最新出价情况",selfInfo);
            // case 1: httpState(jsonstr);
            PriceParseControl.parse(selfInfo,1);
         });
      }
   }
}
