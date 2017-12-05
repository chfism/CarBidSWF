package model
{
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import zebra.Game;
   import view.BidStageView;
   import view.KickOutPart;
   import view.BidInitView;
   
   public class ServerModel 
   {
       
      
      public var bootIP:String;
      
      public var iplist:Array;
      
      public var port:int = 0;
      
      public var changeCount:int = 0;
      
      private var _ipCurrentIndex:int = 0;
      
      private var _allowChangeCount:Boolean = false;
      
      private var logapplication:LogApplication;
      
      public function ServerModel ()
      {
         this.iplist = ["114.80.106.55"];
         this.logapplication = new LogApplication();
         super();
      }
      
      public function setAllowChangeCount() : void
      {
         this._allowChangeCount = true;
      }
      
      public function resetAllowChangeCount() : void
      {
         this._allowChangeCount = false;
         this.changeCount = 0;
      }
      
      public function get ip() : String
      {
         return this.iplist[this._ipCurrentIndex];
      }
      
      public function changeIP() : void
      {
         var kickoutpart10:KickOutPart = null;
         this.logapplication.WriteLogWithWarn2("Main.isReconnectBy31",String(Main.isReconnectBy31),"");
         this.logapplication.WriteLogWithWarn2("changeCount",String(this.changeCount),"");
         if(Main.isReconnectBy31)
         {
            if(this.changeCount > 9)
            {
               Main.isReconnectBy31 = false;
               ExternalInterface.call("clearbidcookies");
               Main.isKickOut = true;
               BidStageView(Game.Content.getView(BidStageView)).socketControl.close();
               // "您与服务器的连接已经断开，请重新登录";
               _KickOutPart = new KickOutPart(2);
               BidInitView.setWin(kickoutpart10);
            }
            else
            {
               this._ipCurrentIndex++;
               if(this._ipCurrentIndex >= this.iplist.length)
               {
                  this._ipCurrentIndex = 0;
               }
               if(this._allowChangeCount)
               {
            	   this.changeCount++;
               }
               //trace(("changeCount is:" + this.changeCount));
            }
         }
         else
         {
            this._ipCurrentIndex++;
            if(this._ipCurrentIndex >= this.iplist.length)
            {
               this._ipCurrentIndex = 0;
            }
         }
      }
   }
}
