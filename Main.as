package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import model.TradeServer;
   import model.Auction;
   import model.InformationServer;
   import model.LogApplication;
   import model.AuctionInfo;
   import model.EncodeAndDecode;
   import zebra.Game;
   import view.CheckUUID;
   
   public class Main extends Sprite
   {
      
      public static var _disconnected:Boolean = false;
      
      public static var isReconnectBy31:Boolean = false;
      
      public static var _version:String = "版本 : 7.7.7.27";
      
      public static var timediff:Number = 0;
      
      public static var §˜§:Boolean = true;
      
      public static var uid:String = "";
      
      public static var keystr:String = "ji!@p!a";
       
      
      public var logapplication:LogApplication;
      
      public var xxtea:EncodeAndDecode;
      
      public var flashcallingcheck:Boolean = true;
      
      public function Main()
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         this.logapplication = new LogApplication();
         //hum xxtea="!@p!a"
         this.xxtea = new EncodeAndDecode(keystr);
         super();
         var _isLocal:String = "!local";
         if(loaderInfo["@doswf__url"].indexOf("file:///") != -1)
         {
            _isLocal = "local";
         }
         new Game(this["@doswf__stage"]);
         Game.Hack.keepframe();
         if(Game.Hack.debug)
         {
            Main._version = "D" + Main._version;
         }
         var auction:Auction = new Auction();
         if(_isLocal != "local")
         {
        	 //uid=54297820
            _uid = this["@doswf__stage"].loaderInfo.parameters["uid"];
            auction.uid = _uid;
            //uname=冯莉萍
            _uname = this["@doswf__stage"].loaderInfo.parameters["uname"];
            auction.uname = _uname;
            //clientId=27d8ead720994414bb4931ef3b2bafeb
            _clientId = this["@doswf__stage"].loaderInfo.parameters["clientId"];
            auction.clientid = _clientId;
            //informationserverstr=
            _informationserverstr = this["@doswf__stage"].loaderInfo.parameters["informationserverstr"];
            auction.informationserverstr = _informationserverstr;
            //tradeserverstr=180.153.24.227:8300,180.153.29.213:8300,180.153.15.118:8300,180.153.38.219:8300
            _tradeserverstr = this["@doswf__stage"].loaderInfo.parameters["tradeserverstr"];
            auction.tradeserverstr = _tradeserverstr;
            //webserverstr=paimai2.alltobid.com:80
            _webserverstr = this["@doswf__stage"].loaderInfo.parameters["webserverstr"];
            auction.webserverstr = _webserverstr.split(",")[0];
            //lcserverstr=
            _lcserverstr = this["@doswf__stage"].loaderInfo.parameters["lcserverstr"];
            auction.lcserverstr = _lcserverstr;
            //auctype=0
            _auctype = this["@doswf__stage"].loaderInfo.parameters["auctype"];
            auction.auctype = _auctype;
            //pwd=898eda2554b845a5842a7375ae109085
            _pwd = this["@doswf__stage"].loaderInfo.parameters["pwd"];
            auction.pwd = _pwd;
         }
         else
         {
            auction.clientid = "226f331f58a941ff9b9219b8a294a281";
            auction.uid = "99851739";
            auction.tradeserverstr = "114.80.106.55";
            auction.webserverstr = "114.80.106.55".split(",")[0];
            auction.auctype = "0";
         }
         uid = auction.uid;
         var auctioninfo:AuctionInfo = new AuctionInfo();
         auctioninfo.bidnumber = auction.uid;
         auctioninfo.clientId = auction.clientid;
         
         if(!new MovieClip()["@doswf__stage"])
         {
            return;
         }
         var _tradeserver:TradeServer = new §§pop().TradeServer();
         if(_isLocal != "local")
         {
            _tradeserver.iplist = this.ParseServerList(auction.tradeserverstr);
         }
         var _informationserver:InformationServer = new InformationServer();
         if(_isLocal != "local")
         {
            _informationserver.iplist = this.ParseServerList(auction.informationserverstr);
            this.flashcallingcheck = ExternalInterface.call("flashCallingCheck");
         }
         if(this.flashcallingcheck)
         {
            addChild(new CheckUUID());
         }
      }
      
      private function ParseServerList(param1:String) : Array
      {
         var _loc2_:Array = param1.split(",");
         var _serverlist:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_.push(_loc2_[_loc4_].split(":")[0]);
            _loc4_++;
         }
         return _serverlist;
      }
   }
}
