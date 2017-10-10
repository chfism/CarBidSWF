package model
{
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import zebra.Game;
   import view.RightContainerView;
   import view.ConnectionStatus;
   import view.Container;
   
   public class Server
   {
       
      
      public var _str:String;
      
      public var iplist:Array;
      
      public var port:int = 0;
      
      public var changeCount:int = 0;
      
      private var serverindex:int = 0;
      
      private var _needreset:Boolean = false;
      
      private var logapplication:LogApplication;
      
      public function Server()
      {
         this.iplist = ["114.80.106.55"];
         this.logapplication = new LogApplication();
         super();
      }
      
      public function ˣ() : void
      {
         this._needreset = true;
      }
      
      public function resetAllowChangeCount() : void
      {
         this._needreset = false;
         this.changeCount = 0;
      }
      
      public function get ip() : String
      {
         return this.iplist[this.serverindex];
      }
      
      public function switchIP() : void
      {
         var _connectionstatus:ConnectionStatus = null;
         this.logapplication.WriteLog2("Main.isReconnectBy31",String(Main.isReconnectBy31),"");
         this.logapplication.WriteLog2("changeCount",String(this.changeCount),"");
         if(Main.isReconnectBy31)
         {
            if(this.changeCount > 9)
            {
               Main.isReconnectBy31 = false;
               ExternalInterface.call("clearbidcookies");
               Main._disconnected = true;
               RightContainerView(Game.Content.getView(RightContainerView)).socketControl.close();
               // "您与服务器的连接已经断开，请重新登录";
               _connectionstatus = new ConnectionStatus(2);
               Container.DisplayCurrentObject(_connectionstatus);
            }
            else
            {
               this.serverindex++;
               if(this.serverindex >= this.iplist.length)
               {
                  this.serverindex = 0;
               }
               §§push(this.changeCount + 1);
               if(!new MovieClip()["@doswf__stage"])
               {
                  return;
               }
               _loc2_.changeCount = §§pop();
            }
         }
         else
         {
            this.serverindex++;
            if(this.serverindex >= this.iplist.length)
            {
               this.serverindex = 0;
            }
         }
      }
   }
}
