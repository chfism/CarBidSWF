package model
{
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import zebra.core.GameModel;
   import zebra.Game;
   import zebra.system.collections.ByteArrayCollection;
   import zebra.system.collections.GUID;
   import Utility.MD5;
   
   public class BidStageUserModel extends GameModel
   {
       
      
      public var requestid2to2:String;
      
      public var timespan = "0";
      
      public var sendTimespan;
      
      public var getTimespan;
      
      public var bidnumber:String = "70000004";
      
      public var clientId:String = "4d3d87126d5446248c44ff0f33cc75b3";
      
      public var checkcode:String = "";
      
      public var version:String = "1.0";
      
      public var keyStr:String = "shcarbid";
      
      public var key:ByteArray;
      
      public var xxtea:XxteaEncodeAndDecode;
      
      public var logappliction:LogApplication;
      
      public var timestamp:String = "";
      
      public function BidStageUserModel()
      {
         this.key = new ByteArray();
         this.xxtea = new XxteaEncodeAndDecode();
         this.logappliction = new LogApplication();
         super();
         Game.Content.addUpdateView(this);
      }
      
      public function get uid() : String
      {
         return this.bidnumber;
      }
      
      public function get requestid() : String
      {
         return this.bidnumber + "." + this.timestamp;
      }
      
      public function createTimestamp() : String
      {
         var now:Date = new Date();
         this.timestamp = String(now.getHours()) + String(now.getMinutes()) + String(now.getSeconds()) + String(now.getMilliseconds());
         return this.timestamp;
      }
      
      public function data() : String
      {
         return "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.timestamp + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\"}";
      }
      
      public function get bytes1_1() : ByteArrayCollection
      {
         this.createTimestamp();
         this.checkcode = MD5.startMd(this.clientId + this.bidnumber + this.version + this.requestid + this.version + this.timestamp).toLowerCase();
         var _byteArray3:ByteArrayCollection = new ByteArrayCollection();
         var dataString1_1:* = "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.timestamp + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\"}";
         var content1_1:String = this.xxtea.XxteaEncode(dataString1_1);
         var testxxtea:String = this.xxtea.XxteaDecode(content1_1);
         _byteArray3.toStr(content1_1);
         this.logappliction.WriteLogWithWarn1("投标板块","上线1-1",this.requestid);
         return _byteArray3;
      }
      
      public function get bytes0_0() : ByteArrayCollection
      {
         this.createTimestamp();
         var _loc1_:ByteArrayCollection = new ByteArrayCollection();
         var _loc2_:* = "{ts:\"" + this.timestamp + "\"}";
         var _loc3_:String = this.xxtea.XxteaEncode(_loc2_);
         _loc1_.toStr(_loc3_);
         return _loc1_;
      }
      
      public function bytes2_1(price:String) : ByteArrayCollection
      {
         this.createTimestamp();
         var _byteArray2to1:ByteArrayCollection = new ByteArrayCollection();
         var _price:* = price;
         this.checkcode = MD5.startMd(this.clientId + _price + this.timestamp + this.bidnumber + this.bidnumber + this.version);
         var _jsonstr:* = "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.timestamp + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\",request:{bidamount:" + _price + "}}";
         var _encryptedstr:String = this.xxtea.XxteaEncode(_jsonstr);
         _byteArray2to1.toStr(_encryptedstr);
         this.logappliction.WriteLogWithWarn1("投标板块","请求校验码2-1",this.requestid);
         return _byteArray2to1;
      }
      
      public function bytes2_2(price:String, yzcode:String, priceCode:String = "") : ByteArrayCollection
      {
         this.createTimestamp();
         var _result:ByteArrayCollection = new ByteArrayCollection();
         var _price:String = price;
         var _yzcode:String = yzcode;
         if(priceCode == "")
         {
        	 yzcode = MD5.startMd(_yzcode + this.bidnumber + _price + this.version + this.bidnumber + this.clientId + this.timestamp);
         }
         else
         {
        	 yzcode = MD5.startMd(this.version + this.clientId + this.requestid + this.bidnumber + _yzcode + _price + priceCode + this.timestamp);
         }
         this.requestid2to2 = this.requestid;
         var _loc7_:* = "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.timestamp + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + yzcode + "\",version:\"" + this.version + "\",request:{bidamount:\"" + _price + "\",imagenumber:\"" + _yzcode + "\"}}";
         var _loc8_:String = this.xxtea.XxteaEncode(_loc7_);
         _result.toStr(_loc8_);
         this.logappliction.WriteLogWithWarn1("投标板块","请求进入队列2-2",this.requestid);
         return _result;
      }
      
      public function selfPriceInfo(_uniqueid:*=null)
      {
          this.createTimestamp();
          var uniqueid:String = GUID.create().toLowerCase();
          if (_uniqueid != null)
          {
              uniqueid = _uniqueid.toLowerCase();
          };
          var requestid:String = ((this.uid + ".") + this.timestamp);
          var checkcode:String = MD5.startMd((((requestid + this.timestamp) + uniqueid) + this.version)).toLowerCase();
          var jsondata:String = (((((((((('{requestid:"' + requestid) + '",timestamp:"') + this.timestamp) + '",bidnumber:"') + this.uid) + '",checkcode:"') + checkcode) + '",version:"') + this.version) + '",request:{}}');
          var sentdata:String = jsondata;
          var data:String = (('{"method":"getimagecode","cmd":"' + escape(sentdata)) + '"}');
          return (data);
      }

      public function selfPriceInfowithoutUniqueid()
      {
          this.createTimestamp();
          var requestid:String = ((this.uid + ".") + this.timestamp);
          var checkcode:String = MD5.startMd(((requestid + this.timestamp) + this.version)).toLowerCase();
          var jsondata:String = (((((((((('{requestid:"' + requestid) + '",timestamp:"') + this.timestamp) + '",bidnumber:"') + this.uid) + '",checkcode:"') + checkcode) + '",version:"') + this.version) + '"}');
          var sentdata:String = jsondata;
          var data:String = (('{"method":"getimagecode","cmd":"' + escape(sentdata)) + '"}');
          return (data);
      }
      
      public function sendPriceInfo(checkcode:String, uniqueid:*):String
      {
          this.createTimestamp();
          var requestid:String = ((this.uid + ".") + this.timestamp);
          var imagenumber:String = checkcode;
          checkcode = MD5.startMd(((((((this.bidnumber + this.clientId) + imagenumber) + requestid) + this.timestamp) + uniqueid) + this.version)).toLowerCase();
          var jsondataForInfo:String = (((((((((((((((('{requestid:"' + requestid) + '",timestamp:"') + this.timestamp) + '",bidnumber:"') + this.bidnumber) + '",checkcode:"') + checkcode) + '",version:"') + this.version) + '",request:{uniqueid:"') + uniqueid) + '",bidnumber:"') + this.bidnumber) + '",imagenumber:"') + imagenumber) + '"}}');
          var sentdataForInfo:String = jsondataForInfo;
          var data:String = (('{"method":"bidcheck","cmd":"' + escape(sentdataForInfo)) + '"}');
          return (data);
      }

      public function sentLogData(log:*)
      {
          var logdata:String = log;
          trace(log);
          var data:String = (('{"cmd":"' + log) + '"}');
          return (data);
      }
   }
}
