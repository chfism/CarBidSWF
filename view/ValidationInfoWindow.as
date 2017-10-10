package view
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.utils.setTimeout;
   import model.Auction;
   import model.LogApplication;
   import model.AuctionInfo;
   import model.EncodeAndDecode;
   import zebra.Game;
   import ws.PriceInfoWindow;
   import zebra.system.net.GameSocketThread;
   import zebra.system.net.SocketThreadParam;
   import zebra.content.GameAsset;
   import zebra.system.collections.ByteArrayCollection;
   import zebra.system.collections.FlashBytesReader;
   import Utility.md5;
   import Controller.StageControl;
   import zebra.loaders.IAssetLoader;
   import r1.deval.parser.D;
   
   public class ValidationInfoWindow extends PriceInfoWindow
   {
       
      
      public var ԡ:Boolean = false;
      
      private var _price:int = 0;
      
      private var ԣ:String;
      
      public var otTimer:uint;
      
      public var priceCode:String;
      
      private var Ԥ:URLLoader;
      
      public var xxtea:EncodeAndDecode;
      
      public var logappliction:LogApplication;
      
      private var c:DisplayObject;
      
      private var thisWinClose:Boolean = false;
      
      public var uid:String;
      
      private var imageurl:String;
      
      public function ValidationInfoWindow(price:int)
      {
         this.urlloader= new URLLoader();
         this.xxtea = new EncodeAndDecode(Main.keystr);
         this.logappliction = new LogApplication();
         this.uid = md5.core_md5(Main.uid);
         super();
         this.imageurl = "";
         this.thisWinClose = false;
         yzcode.restrict = "0-9";
         this._price = price;
         this.mypricetxt.text = "您的出价为: " + price + "元";
         cancelBut.addEventListener(MouseEvent.CLICK,this.closeHandler);
         okBut.addEventListener(MouseEvent.CLICK,this.submitHandler);
         setTimeout(this.RefreshCode,1000 * 3);
         addEventListener(Event.ADDED_TO_STAGE,this.AddedToStagehandler);
         addEventListener(IOErrorEvent.IO_ERROR,this.ioerrorhandler);
         RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket.receive("2-2",this.EndHandler);
      }
      
      private function ioerrorhandler(param1:IOErrorEvent) : void
      {
      }
      
      private function RefreshCode() : void
      {
         var ݸ_sprite:Sprite = null;
         var _indexݹ:int = 0;
         if(this.imageurl != null)
         {
            ݸݸ_sprite = this.RefreshCodeSprite();
            addChild(ݸݸ_sprite);
            ݹ_indexݹ = this.numChildren - 3;
            this.setChildIndex(ݸ_spriteݸ,_indexݹݹ);
            ݸݸ_sprite.buttonMode = true;
            ݸݸ_sprite.addEventListener(MouseEvent.CLICK,this.GetValidationCode);
         }
         else
         {
            setTimeout(function():*
            {
               if(!thisWinClose)
               {
                  Container.removechildren();
               }
            },1000 * 7);
         }
      }
      
      private function RefreshCodeSprite() : Sprite
      {
         var MouseOnݻ:Function = null;
         var MouseAutoݼ:Function = null;
         ݻMouseOnݻ = function(param1:MouseEvent):*
         {
            Mouse.cursor = "button";
         };
         ݼMouseAuto ݼ= function(param1:MouseEvent):*
         {
            Mouse.cursor = "auto";
         };
         var ݺ:Sprite = new Sprite();
         var background:Shape = this.DrawRectangle(2589655);
         var ѵ:TextField = new TextField();
         ѵ.text = "刷新校验码";
         ѵ.x = 96;
         ѵ.y = 249;
         ѵ.textColor = 16777215;
         var format:TextFormat = new TextFormat();
         format.size = 23;
         ѵ.defaultTextFormat = format;
         ѵ.height = 20;
         ѵ.width = 67;
         ѵ.selectable = false;
         ѵ.addEventListener(MouseEvent.MOUSE_OVER,ݻMouseOn);
         ѵ.addEventListener(MouseEvent.MOUSE_OUT,ݼMouseAutoݼ);
         ݺ.addChild(background);
         ݺ.addChild(ѵ);
         return ݺ;
      }
      
      private function DrawRectangle(param1:uint) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(1,2779313);
         _loc2_.graphics.beginFill(param1);
         _loc2_.graphics.drawRoundRect(72,247,110,25,7);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      private function GetValidationCode(param1:MouseEvent) : void
      {
         var _url:* = undefined;
         var _txtfield:TextField = null;
         if(this.imageurl != null)
         {
        	 _url = this.imageurl + "&random=" + Math.random();
            _txtfield = new TextField();
            _txtfield.htmlText = " <img src=\'" + _url + "\' id=\'image\'>";
            addChild(_txtfield);
            this.c = _txtfield.getImageReference("image");
            this.c.x = 70;
            this.c.y = 243;
            addChild(this.c);
         }
      }
      
      private function §ԩ§() : void
      {
         var _loc1_:Number = int((Math.random() * 39 + 293) * 100) / 100;
         cancelBut.y = _loc1_;
         okBut.y = _loc1_;
      }
      
      private function EndHandler(param1:*) : void
      {
         this.End();
      }
      
      private function submitHandler(param1:MouseEvent) : void
      {
         var _loc2_:AuctionInfo = null;
         this.thisWinClose = true;
         if(param1.target.name == "okBut")
         {
            ProgressView._completed = false;
            if(yzcode.text.length == 0)
            {
               Container.DisplayCurrentObject(new PopMessageView(4));
            }
            else if(yzcode.text == " ")
            {
               Container.DisplayCurrentObject(new PopMessageView(4));
            }
            else
            {
               Container.DisplayCurrentObject(new PopMessageView(6,false)); 
               _auctioninfo = AuctionInfo(Game.Content.getModel(AuctionInfo));
               RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket.send("2-2",_auctioninfo.EncryptPriceAndCodeRequest(String(this._price),yzcode.text,this.priceCode));
            }
         }
         this.closeHandler(param1);
      }
      
      private function §Ԭ§() : void
      {
         var _loc1_:String = AuctionInfo(Game.Content.getView(AuctionInfo))._requestid;
         var _loc2_:Auction = Auction(Game.Content.getModel(Auction));
         var _loc3_:String = "http://" + _loc2_.webserverstr + "/bid/query.ashx?bidnumber=" + _loc2_.uid + "&requestid=" + _loc1_;
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         _loc4_.method = URLRequestMethod.GET;
         _loc4_.contentType = "application/json";
         this.Ԥ.load(_loc4_);
         this.logappliction.WriteLogWithURL("投标板块","2-2发出15秒后请求出价情况",_loc3_);
         this.Ԥ.addEventListener(Event.COMPLETE,this.getHttpContentHandler);
      }
      
      private function getHttpContentHandler(param1:*) : void
      {
         var _loc2_:String = String(this.Ԥ.data);
      // case 3: stage2-3latest(rawdata);
         StageControl.parse(_loc2_,3);
      }
      
      public function End() : void
      {
      }
      
      private function AddedToStagehandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.AddedToStagehandler);
         var _bytearraycollection:ByteArrayCollection = new ByteArrayCollection();
         var _auctioninfo:AuctionInfo = AuctionInfo(Game.Content.getModel(AuctionInfo));
         var _gamesocketthread:GameSocketThread = RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket;
         _gamesocketthread.receive("2-1",this.§Ԯ§);
         _gamesocketthread.send("2-1",_auctioninfo.VerificationCodeRequest(String(this._price)));
         this["@doswf__stage"].focus = yzcode;
      }
      
      private function §Ԯ§(param1:SocketThreadParam) : void
      {
         var _imageurl:String = null;
         var _loc14_:* = undefined;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _requestid:String = null;
         var _txtfield:TextField = null;
         var _index:int = 0;
         var _loc22_:String = null;
         var _loc23_:PopMessageView = null;
         var _auction:Auction = Auction(Game.Content.getModel(Auction));
         var _currentdate:Date = new Date();
         var _currentdatestr:String = String(_currentdate.getHours()) + ":" + String(_currentdate.getMinutes()) + ":" + String(_currentdate.getSeconds()) + "." + String(_currentdate.getMilliseconds());
         var _loc6_:FlashBytesReader = param1.bytesReader.clone();
         var _loc7_:String = _loc6_.readString();
         var _loc8_:String = this.xxtea.Base64Decrypted(_loc7_);
         var _responseobject:Object = JSON.parse(_loc8_);
         var _responsecode:String = _responseobject.response.responsecode;
         var _servertime:String = _responseobject.servertime;
         if(_responsecode == "0")
         {
            _imageurl = _responseobject.response.data.imageurl;
            _loc14_ = _imageurl.split("?")[0];
            _i = this.parsestring("i",_imageurl);
            _id = this.parsestring("id",_imageurl);
            //TODO: _ep是否是验证码？
            _ep = this.parsestring("ep",_imageurl);
            this.imageurl = _loc14_ + "?i=" + _i;
            if(_id != "")
            {
               this.imageurl = this.imageurl + ("&id=" + _id);
            }
            if(_ep != "")
            {
               this.logappliction.WriteLog2("投标板块","得到的数据","type:" + _responseobject.response.data.type + ",字符串" + _ep);
               if(_responseobject.response.data.type == 1)
               {
                  this.logappliction.WriteLog2("投标板块","eval计算结果",String(D.eval(_ep)));
                  this.priceCode = String(D.eval(_ep));
               }
               else
               {
                  this.priceCode = _ep;
               }
               this.logappliction.WriteLog2("投标板块","priceCode",this.priceCode);
            }
            else
            {
               this.priceCode = "";
            }
            _prompt = _responseobject.response.data.prompt;
            this.yzmsg.text = _prompt;
            _requestid = _responseobject.requestid;
            this.logappliction.WriteLog("投标板块","接收校验码2-1","requestid:" + _requestid + ",server time:" + _servertime);
            this.logappliction.WriteLogWithURL("投标板块","接收校验码2-1",this.imageurl);
            _txtfield = new TextField();
            this.imageurl = this.imageurl + "&b=" + _auction.pwd;
            _txtfield.htmlText = " <img src=\'" + this.imageurl + "\' id=\'image\' />";
            addChild(_txtfield);
            this.c = _txtfield.getImageReference("image");
            this.c.x = 70;
            this.c.y = 243;
            addChild(this.c);
            _index = this.numChildren - 1;
            this.setChildIndex(this.c,_index);
         }
         else
         {
            _loc22_ = _loc9_.response.responsemsg;
            _loc23_ = new PopMessageView(_loc22_);
            Container.DisplayCurrentObject(_loc23_);
            this.logappliction.WriteLog("投标板块","系统提示2-1",_loc22_);
         }
         var _loc12_:GameSocketThread = RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket;
         _loc12_.destroy("2-1",this.§Ԯ§);
      }
      
      private function completeHandler(param1:*) : void
      {
         var _loc2_:Loader = Loader(param1.target.loader);
         var _loc3_:Bitmap = Bitmap(_loc2_.content);
         _loc3_.x = 309;
         _loc3_.y = 218;
         addChild(_loc3_);
         this.logappliction.WriteLog2("投标板块","出价校验码","校验码加载完成");
      }
      
      private function §ԯ§(param1:IAssetLoader) : void
      {
         param1.content.x = 309;
         param1.content.y = 218;
         addChild(param1.content);
         this.logappliction.WriteLog2("投标板块","出价校验码","校验码加载完成");
         GameAsset.destroy(param1.key,this.§ԯ§);
      }
      
      private function closeHandler(param1:MouseEvent) : void
      {
         this.thisWinClose = true;
         try
         {
            this.imageurl = "";
            this.parent.removeChild(this);
            return;
         }
         catch(e:*)
         {
            return;
         }
      }
      
      public function parsestring(word:String, str:String) : String
      {
         var _loc6_:String = null;
         var _s:* = word + "=";
         var _result:String = "";
         var _startindex:int = str.indexOf(_s);
         if(_startindex != -1)
         {
            _loc6_ = str.substring(_startindex,str.length);
            if(_loc6_.indexOf("&") != -1)
            {
            	_result = _loc6_.substring(_s.length,_loc6_.indexOf("&"));
            }
            else
            {
            	_result = _loc6_.substring(_s.length,_loc6_.length);
            }
         }
         return _result;
      }
   }
}
