package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import model.BidStageServerModel;
   import model.WebParamModel;
   import model.BidInfoServerModel;
   import model.LogApplication;
   import model.BidStageUserModel;
   import model.XxteaEncodeAndDecode;
   import zebra.Game;
   import view.BrowserPart;
   
   public class Main extends Sprite
   {
      
      public static var isKickOut:Boolean = false;
      
      public static var isReconnectBy31:Boolean = false;
      
      public static var clientui_version:String = "版本 : 7.7.7.27";
      
      public static var BidStageHeartAction:Number = 0;
      
      public static var passCheck:Boolean = true;
      
      public static var uid:String = "";
      
      public static var keystr:String = "ji!@p!a";
       
      
      public var logapplication:LogApplication;
      
      public var xxtea:XxteaEncodeAndDecode;
      
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
         this.xxtea = new XxteaEncodeAndDecode(keystr);
         super();
         var _isLocal:String = "!local";
         if(loaderInfo["@doswf__url"].indexOf("file:///") != -1)
         {
            _isLocal = "local";
         }
         new Game(stage);
         Game.Hack.keepframe();
         if(Game.Hack.debug)
         {
            Main.clientui_version = "D" + Main.clientui_version;
         }
         var webParamMode:WebParamModel = new WebParamModel();
         if(_isLocal != "local")
         {
        	 //uid=54297820
            _uid = stage.loaderInfo.parameters["uid"];
            webParamMode.uid = _uid;
            //uname=冯XX
            _uname = stage.loaderInfo.parameters["uname"];
            webParamMode.uname = _uname;
            //clientId=27d8ead720994414bb4931ef3b2bafeb
            _clientId = stage.loaderInfo.parameters["clientId"];
            webParamMode.clientid = _clientId;
            //left_socketIPList=
            _BidInfoServerModelstr = stage.loaderInfo.parameters["left_socketIPList"];
            webParamMode.left_socketIPList = _BidInfoServerModelstr;
            //right_socketIPList=180.153.24.227:8300,180.153.29.213:8300,180.153.15.118:8300,180.153.38.219:8300
            _BidStageServerModelstr = stage.loaderInfo.parameters["right_socketIPList"];
            webParamMode.right_socketIPList = _BidStageServerModelstr;
            //httpIP=paimai2.alltobid.com:80
            _httpIP = stage.loaderInfo.parameters["httpIP"];
            webParamMode.httpIP = _httpIP.split(",")[0];
            //logIP=
            _logIP = stage.loaderInfo.parameters["logIP"];
            webParamMode.logIP = _logIP;
            //auctype=0
            _auctype = stage.loaderInfo.parameters["auctype"];
            webParamMode.auctype = _auctype;
            //pwd=898eda2554b845a5842a7375ae109085
            _pwd = stage.loaderInfo.parameters["pwd"];
            webParamMode.pwd = _pwd;          
         }
         else
         {
        	 webParamMode.clientid = "226f331f58a941ff9b9219b8a294a281";
        	 webParamMode.uid = "99851739";
        	 webParamMode.right_socketIPList = "114.80.106.55";
        	 webParamMode.httpIP = "114.80.106.55".split(",")[0];
        	 webParamMode.auctype = "0";
         }
         uid = webParamMode.uid;
       
         var userModel:BidStageUserModel = new BidStageUserModel();
         userModel.bidnumber = WebParamModel.uid;
         userModel.clientId = WebParamModel.clientid;
      // trace("BidStageUserModel初始化");

         var bidStageServerModel:BidStageServerModel = new BidStageServerModel();
         if(_isLocal != "local")
         {
        	 bidStageServerModel.iplist = this.parseIpList(webParamMode.right_socketIPList);
         }
         var bidInfoModel:BidInfoServerModel = new BidInfoServerModel();
         if(_isLocal != "local")
         {
        	 bidInfoModel.iplist = this.parseIpList(WebParamModel.left_socketIPList);
            this.flashcallingcheck = ExternalInterface.call("flashCallingCheck");
         }
         if(this.flashcallingcheck)
         {
            addChild(new BrowserPart());
         }
      }
      
      private function parseIpList(param1:String) : Array
      {
         var arr:Array = param1.split(",");
         var _serverlist:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < arr.length)
         {
            _loc3_.push(arr[_loc4_].split(":")[0]);
            _loc4_++;
         }
         return _serverlist;
      }
   }
}
