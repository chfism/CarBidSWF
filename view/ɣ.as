package view
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.TextField;
   import model.Auction;
   import model.LogApplication;
   import model.AuctionInfo;
   import model.EncodeAndDecode;
   import zebra.Game;
   import ws.querylatestbid;
   import zebra.content.GameAsset;
   import Controller.StageControl;
   import zebra.loaders.IAssetLoader;
   
   public class ɣ extends querylatestbid
   {
       
      
      private var imageurl:String;
      
      private var Ա:String;
      
      public var logappliction:LogApplication;
      
      private var Բ:EncodeAndDecode;
      
      public function ɣ()
      {
         this.logappliction = new LogApplication();
         this.Բ = new EncodeAndDecode(Main.keystr);
         super();
         yzcode.restrict = "0-9";
         cancelBut.addEventListener(MouseEvent.CLICK,this.CloseHandler);
         okBut.addEventListener(MouseEvent.CLICK,this.submitHandler);
         addEventListener(Event.ADDED_TO_STAGE,this.AddedToStagehandler);
      }
      
      private function AddedToStagehandler(param1:Event) : void
      {
         var _auction:Auction = null;
         var uri:String = null;
         var loader:URLLoader = null;
         var request:URLRequest = null;
         var e:Event = param1;
         this["@doswf__stage"].focus = yzcode;
         this.logappliction.WriteLog2("投标板块","http查询最新出价情况","");
         var bidcode:Number = SceneView(Game.Content.getView(SceneView)).bidcode;
         if(bidcode == 3)
         {
            Container.DisplayCurrentObject(new PopMessageView(7));
         }
         else if(bidcode == 4)
         {
            Container.DisplayCurrentObject(new PopMessageView(10));
         }
         else if(bidcode == 5)
         {
            Container.DisplayCurrentObject(new PopMessageView(11));
         }
         else if(bidcode == 6)
         {
            Container.DisplayCurrentObject(new PopMessageView(12));
         }
         else
         {
            _auction = Auction(Game.Content.getModel(Auction));
            uri = "http://" + _auction.webserverstr + "/webwcf/BidCmd.svc/WebCmd?p=" + Math.random();
            loader = new URLLoader();
            request = new URLRequest(uri);
            request.method = URLRequestMethod.POST;
            request.data = AuctionInfo(Game.Content.getModel(AuctionInfo)).§̓§();
            request.contentType = "application/json";
            loader.addEventListener(Event.COMPLETE,function getHttpContentHandler(param1:Event):void
            {
               var _loc9_:int = 0;
               var _loc10_:int = 0;
               var _loc2_:String = String(loader.data);
               if(_loc2_.indexOf("</string") == -1)
               {
                  _loc2_ = _loc2_.split("\\\"").join("\"");
                  _loc2_ = _loc2_.substr(1,_loc2_.length - 2);
               }
               else
               {
                  _loc9_ = _loc2_.indexOf("/\">");
                  _loc10_ = _loc2_.indexOf("</string>");
                  _loc2_ = _loc2_.substring(_loc9_ + 3,_loc10_);
               }
               var _loc3_:String = _loc2_.split("\\/").join("/");
               var _loc4_:String = _loc3_;
               var _loc5_:Object = JSON.parse(_loc4_);
               var _loc6_:String = _loc5_.response.data;
               var _loc7_:Array = new Array();
               _loc7_ = _loc6_.split(",",_loc6_.length);
               var _loc8_:String = _loc7_[1];
               Ա = _loc7_[0];
               Գ(_loc8_);
               logappliction.WriteLogWithURL("投标板块","请求最新出价情况校验码",_loc8_);
            });
            loader.load(request);
         }
      }
      
      private function Գ(param1:String) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:DisplayObject = null;
         if(param1 != null)
         {
            param1 = " <img src=\'" + param1 + "\' id=\'image2\'>";
            _loc2_ = new TextField();
            _loc2_.htmlText = param1;
            addChild(_loc2_);
            _loc3_ = _loc2_.getImageReference("image2");
            _loc3_.x = 310;
            _loc3_.y = 200;
            addChild(_loc3_);
         }
         else
         {
            this.CloseHandler(null);
         }
      }
      
      private function submitHandler(param1:MouseEvent) : void
      {
         var _loc2_:PopMessageView = null;
         if(yzcode.text.length == 0)
         {
            _loc2_ = new PopMessageView(4);
            Container.DisplayCurrentObject(_loc2_);
         }
         else
         {
            this.Զ();
         }
         this.CloseHandler(param1);
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
      
      private function Ե(param1:IAssetLoader) : void
      {
         param1.content.x = 310;
         param1.content.y = 200;
         addChild(param1.content);
         GameAsset.destroy(param1.key,this.Ե);
      }
      
      private function Զ() : void
      {
         var loader:URLLoader = null;
         var _auction:Auction = Auction(Game.Content.getModel(Auction));
         var uri:String = "http://" + _auction.webserverstr + "/webwcf/BidCmd.svc/WebCmd?p=" + Math.random();
         this.logappliction.WriteLogWithURL("投标板块","请求最新出价情况",uri);
         loader = new URLLoader();
         var request:URLRequest = new URLRequest(uri);
         request.method = URLRequestMethod.POST;
         request.data = AuctionInfo(Game.Content.getModel(AuctionInfo)).BidCheckRequest(yzcode.text,this.Ա);
         request.contentType = "application/json";
         loader.load(request);
         loader.addEventListener(Event.COMPLETE,function getHttpContentHandler(param1:Event):void
         {
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc2_:String = String(loader.data);
            if(_loc2_.indexOf("</string") == -1)
            {
               _loc2_ = _loc2_.split("\\\"").join("\"");
               _loc2_ = _loc2_.substr(1,_loc2_.length - 2);
            }
            else
            {
               _loc5_ = _loc2_.indexOf("/\">");
               _loc6_ = _loc2_.indexOf("</string>");
               _loc2_ = _loc2_.substring(_loc5_ + 3,_loc6_);
            }
            var _loc3_:String = _loc2_.split("\\/").join("/");
            var _loc4_:String = _loc3_;
            logappliction.WriteLog("投标板块","接收最新出价情况",_loc4_);
            // case 1: stage1(rawdata);
            StageControl.parse(_loc4_,1);
         });
      }
   }
}
