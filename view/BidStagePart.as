package view
{
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import model.LogApplication;
   import zebra.Game;
   import ws.BidStage;
   import Event.InfoTagEvent;
   import auctionmodel.BidStageUserModel;
   
   public class BidStagePart extends Sprite
   {
       
      
      public var bidstage:BidStage;
      
      public var bidcode:Number;
      
      private var lowestValue:int = 0;
      
      private var flag:String = "";
      
      public var canClick:Boolean = true;
      
      public var canClick:Boolean = true;
      
      public var logappliction:LogApplication;
      
      public function BidStagePart()
      {
         this.logappliction = new LogApplication();
         super();
         Game.Content.addUpdateView(this);
         this.x = 403.45;
         this.bidstage = new BidStage();
         this.bidstage.price2.visible = false;
         this.bidstage.price1.visible = false;
         this.bidstage.Bidinfo.visible = false;
         this.bidstage.ver.text = Main.clientui_version;
         if(Game.Hack.debug)
         {
            this.bidstage.ver.addEventListener(MouseEvent.CLICK,this.OpenLog);
         }
         this.bidstage.addEventListener(KeyboardEvent.KEY_DOWN,this.PressTabHandler);
         addChild(this.bidstage);
         Game.DirectEvent.receive(InfoTagEvent.name,function(e:InfoTagEvent):void
         {
            var e:BidStageUserModel = null;
         //第二阶段
            if(e._type == "B")
            {
               _loc2_ = BidStageUserModel(e.value);
               bidstage.price1.visible = true;
               lowestValue = e.basePrice;
               bidstage.price1.priceInfoTxt.text = "目前最低可成交价 : " + e.basePrice + "元";
               bidstage.price2.visible = false;
               bidstage.Bidinfo.visible = false;
               bidstage.price2.priceInputTxt1.text = "";
               bidstage.price2.priceInputTxt2.text = "";
               bidcode = 2;
            }
            //第一阶段
            else if(e._type == "A")
            {
               bidstage.price2.visible = true;
               bidstage.price1.visible = false;
               bidstage.Bidinfo.visible = false;
               bidcode = 1;
            }
//            ///"拍卖会已终止！"
            else if(e._type == "E")
            {
               bidstage.price2.visible = true;
               bidstage.price1.visible = false;
               bidstage.Bidinfo.visible = false;
               bidcode = 5;
            }
            //"拍卖会已结束！"
            else if(e._type == "D")
            {
               bidstage.price2.visible = false;
               bidstage.price1.visible = false;
               bidstage.Bidinfo.visible = true;
               bidcode = 4;
            }
            else if(e._type == "G")
            {
               bidstage.price2.visible = false;
               bidstage.price1.visible = false;
               bidstage.Bidinfo.visible = true;
               bidcode = 4;
            }
            //"拍卖会已暂停！"
            else if(e._type == "H")
            {
               bidstage.price2.visible = true;
               bidstage.price1.visible = false;
               bidstage.Bidinfo.visible = false;
               bidcode = 6;
            }
            //"没有正在举行的拍卖会，请注意拍卖公告！"
            else if(e._type == "C" || e._type == "F")
            {
               bidstage.price2.visible = true;
               bidstage.price1.visible = false;
               bidstage.Bidinfo.visible = false;
               bidcode = 3;
            }
            if(e._type == "A")
            {
               bidstage.price1.priceInfoTxt.visible = false;
            }
            else
            {
               bidstage.price1.priceInfoTxt.visible = true;
            }
         });
         this.bidstage.price1.i100.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.price1.i200.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.price1.i300.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.price1.s100.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.price1.s200.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.price1.s300.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.price1.priceBut.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.price1.ipriceButOK.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.price1.priceInputTxt.restrict = "0-9";
         this.bidstage.price1.ipriceInputTxt.restrict = "0-9";
         this.bidstage.price2.priceInputTxt1.restrict = "0-9";
         this.bidstage.price2.priceInputTxt2.restrict = "0-9";
         this.bidstage.price2.priceInputTxt1.tabIndex = 1;
         this.bidstage.price2.priceInputTxt2.tabIndex = 2;
         this.bidstage.price2.priceBut2.addEventListener(MouseEvent.CLICK,this._butHandler);
         this.bidstage.queryInfoBut.addEventListener(MouseEvent.CLICK,this.getSelfPriceInfoHandler);
      }
      
      private function PressTabHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 9)
         {
            stage.stageFocusRect = false;
            this.bidstage.focusRect = false;
            stage.focus = this.bidstage.info;
         }
      }
      
      public function ϊ() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = Math.round(Math.random());
         if(_loc3_ == 0)
         {
            _loc1_ = int((Math.random() * 18.15 + 298.8) * 100) / 100;
            _loc2_ = int(Math.random() * 95.2 * 100) / 100;
         }
         else
         {
            _loc1_ = int((Math.random() * 325.25 - 7.3) * 100) / 100;
            _loc2_ = int((Math.random() * 7.15 + 134.2) * 100) / 100;
         }
         this.bidstage.price2.priceBut2.x = _loc1_;
         this.bidstage.price2.priceBut2.y = _loc2_;
      }
      
      public function ϋ() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = Math.round(Math.random());
         if(_loc3_ == 0)
         {
            _loc1_ = int((Math.random() * 35 + 294.2) * 100) / 100;
            _loc2_ = 136.6;
         }
         else
         {
            _loc1_ = int((Math.random() * 225.95 + 103.25) * 100) / 100;
            _loc2_ = 181;
         }
         this.bidstage.price1.priceBut.x = _loc1_;
         this.bidstage.price1.priceBut.y = _loc2_;
      }
      
      public function OpenLog(param1:MouseEvent) : void
      {
         LogWinPart(Game.Content.getView(LogWinPart)).show();
      }
      
      public function getSelfPriceInfoHandler(e:MouseEvent) : void
      {
         var win:SelfTopPriceWindowPart = null;
         if(this.canClick)
         {
            setTimeout(this.clickCount,1000 * 6);
            win = new SelfTopPriceWindowPart();
            BidInitView.setWin(win);
            this.canClick = false;
         }
         else
         {
            BidInitView.setWin(new WarnInfoPart(9));
         }
      }
      
      private function clickCount() : void
      {
         this.canClick = true;
      }
      
      public function _butHandler(e:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:WarnInfoPart = null;
         switch(e.target.name)
         {
            case "s300":
               if(this.lowestValue - 300 < 100)
               {
                  this.bidstage.price1.priceInputTxt.text = "100";
                  break;
               }
               this.bidstage.price1.priceInputTxt.text = String(this.lowestValue - 300);
               break;
            case "s200":
               if(this.lowestValue - 200 < 100)
               {
                  this.bidstage.price1.priceInputTxt.text = "100";
                  break;
               }
               this.bidstage.price1.priceInputTxt.text = String(this.lowestValue - 200);
               break;
            case "s100":
               if(this.lowestValue - 100 < 100)
               {
                  this.bidstage.price1.priceInputTxt.text = "100";
                  break;
               }
               this.bidstage.price1.priceInputTxt.text = String(this.lowestValue - 100);
               break;
            case "i300":
               this.bidstage.price1.priceInputTxt.text = String(this.lowestValue + 300);
               break;
            case "i200":
               this.bidstage.price1.priceInputTxt.text = String(this.lowestValue + 200);
               break;
            case "i100":
               this.bidstage.price1.priceInputTxt.text = String(this.lowestValue + 100);
               break;
            case "ipriceButOK":
               _loc2_ = int(this.bidstage.price1.ipriceInputTxt.text);
               if(_loc2_ % 100 != 0)
               {
                  _loc3_ = new WarnInfoPart(13);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               this.bidstage.price1.priceInputTxt.text = String(this.lowestValue + _loc2_);
               break;
            case "priceBut":
               if(this.bidcode == 3)
               {
            	   //"没有正在举行的拍卖会，请注意拍卖公告！"
                  _loc3_ = new WarnInfoPart(7);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidcode == 4)
               {
            	   //"拍卖会已结束！"
                  _loc3_ = new WarnInfoPart(10);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidcode == 5)
               {
            	   //"拍卖会已终止！"
                  _loc3_ = new WarnInfoPart(11);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidcode == 6)
               {
            	   //"拍卖会已暂停！"
                  _loc3_ = new WarnInfoPart(12);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidstage.price1.priceInputTxt.text.length == 0)
               {
            	   //"输入价格不能为空"
                  _loc3_ = new WarnInfoPart(1);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(int(this.bidstage.price1.priceInputTxt.text) <= 0 || int(this.bidstage.price1.priceInputTxt.text) % 100 != 0)
               {
            	   //"出价金额必须为100元的正整数倍"
                  _loc3_ = new WarnInfoPart(2);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.canClick)
               {
                  setTimeout(this.TooFastHandler,1000 * 6);
                  BidInitView.setWin(new PriceInfoWindowPart(int(this.bidstage.price1.priceInputTxt.text)));
                  this.canClick = false;
                  break;
               }
//               /"你的操作过于频繁，请稍后再尝试"
               BidInitView.setWin(new WarnInfoPart(9));
               break;
            case "priceBut2":
               if(this.bidcode == 3)
               {
            	   //"没有正在举行的拍卖会，请注意拍卖公告！"
                  _loc3_ = new WarnInfoPart(7);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidcode == 4)
               {
            	   //"拍卖会已结束！"
                  _loc3_ = new WarnInfoPart(10);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidcode == 5)
               {
            	   //"拍卖会已终止！"
                  _loc3_ = new WarnInfoPart(11);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidcode == 6)
               {
            	   //拍卖会已暂停！"
                  _loc3_ = new WarnInfoPart(12);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidstage.price2.priceInputTxt1.text.length == 0 || this.bidstage.price2.priceInputTxt2.text.length == 0)
               {
            	   //"输入价格不能为空"
                  _loc3_ = new WarnInfoPart(1);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(int(this.bidstage.price2.priceInputTxt1.text) <= 0 || int(this.bidstage.price2.priceInputTxt1.text) % 100 != 0 || int(this.bidstage.price2.priceInputTxt2.text) % 100 != 0)
               {
            	   //"出价金额必须为100元的正整数倍"
                  _loc3_ = new WarnInfoPart(2);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.bidstage.price2.priceInputTxt1.text != this.bidstage.price2.priceInputTxt2.text)
               {
            	   //"两次输入的出价金额不一致"
                  _loc3_ = new WarnInfoPart(3);
                  BidInitView.setWin(_loc3_);
                  break;
               }
               if(this.canClick)
               {
                  setTimeout(this.TooFastHandler,1000 * 6);
                  BidInitView.setWin(new PriceInfoWindowPart(int(this.bidstage.price2.priceInputTxt1.text)));
                  this.canClick = false;
                  break;
               }
               //"你的操作过于频繁，请稍后再尝试"
               BidInitView.setWin(new WarnInfoPart(9));
               break;
         }
      }
      
      private function TooFastHandler() : void
      {
         this.canClick = true;
      }
      
      public function setPriceInfo(val:String) : void
      {
         this.bidstage.info.htmlText = "<font color=\'#FF0000\'>" + val + "</font>";
      }
   }
}
