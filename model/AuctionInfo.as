package model
{
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import zebra.core.GameModel;
   import zebra.Game;
   import zebra.system.collections.ByteArrayCollection;
   import zebra.system.collections.GUID;
   import Utility.md5;
   
   public class AuctionInfo extends GameModel
   {
       
      
      public var _requestid:String;
      
      public var _timediffstr = "0";
      
      public var _time1;
      
      public var _time2;
      
      public var bidnumber:String = "70000004";
      
      public var clientId:String = "4d3d87126d5446248c44ff0f33cc75b3";
      
      public var checkcode:String = "";
      
      public var version:String = "1.0";
      
      public var _notusedkey:String = "shcarbid";
      
      public var key:ByteArray;
      
      public var xxtea:EncodeAndDecode;
      
      public var logappliction:LogApplication;
      
      public var currenttime:String = "";
      
      public function AuctionInfo()
      {
         this.key = new ByteArray();
         §§push(this);
         //Hum Main.keystr="ji!@p!a"
         §§push(Main.keystr);
         if(!new MovieClip()["@doswf__stage"])
         {
            return;
         }
         §§pop().xxtea = new §§pop().EncodeAndDecode(§§pop());
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
         return this.bidnumber + ".f" + this.currenttime;
      }
      
      public function GetCurrentTime() : String
      {
         var _currentdate:Date = new Date();
         this.currenttime = String(_currentdate.getHours()) + String(_currentdate.getMinutes()) + String(_currentdate.getSeconds()) + String(_currentdate.getMilliseconds());
         return this.currenttime;
      }
      
      public function data() : String
      {
         return "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\"}";
      }
      
      public function get GoOnlineRequest() : ByteArrayCollection
      {
         this.GetCurrentTime();
         this.checkcode = md5.core_md5(this.clientId + this.bidnumber + this.version + this.requestid + this.version + this.currenttime).toLowerCase();
         var _bytearraycollection:ByteArrayCollection = new §§pop().ByteArrayCollection();
         var _rawdata:* = "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\"}";
         var _encryptedstr:String = this.xxtea.Base64Encrypted(_rawdata);
         var _decryptedstr:String = this.xxtea.Base64Decrypted(_loc3_);
         _bytearraycollection.toStr(_encryptedstr);
         this.logappliction.WriteLogWithRequestID("投标板块","上线1-1",this.requestid);
         return _bytearraycollection;
      }
      
      public function get CurrentTimeRequest() : ByteArrayCollection
      {
         this.GetCurrentTime();
         var _loc1_:ByteArrayCollection = new ByteArrayCollection();
         var _loc2_:* = "{ts:\"" + this.currenttime + "\"}";
         var _loc3_:String = this.xxtea.Base64Encrypted(_loc2_);
         _loc1_.toStr(_loc3_);
         return _loc1_;
      }
      
      public function VerificationCodeRequest(price:String) : ByteArrayCollection
      {
         this.GetCurrentTime();
         var _bytearraycollection:ByteArrayCollection = new ByteArrayCollection();
         §§push(price);
         var _price:* = §§pop();
         this.checkcode = md5.core_md5(this.clientId + _price + this.currenttime + this.bidnumber + this.bidnumber + this.version);
         var _rawdata:* = "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\",request:{bidamount:" + _price + "}}";
         var _encryptedstr:String = this.xxtea.Base64Encrypted(_rawdata);
         _bytearraycollection.toStr(_encryptedstr);
         this.logappliction.WriteLogWithRequestID("投标板块","请求校验码2-1",this.requestid);
         return _bytearraycollection;
      }
      
      public function EncryptPriceAndCodeRequest(price:String, yzcode:String, priceCode:String = "") : ByteArrayCollection
      {
         this.GetCurrentTime();
         var _result:ByteArrayCollection = new ByteArrayCollection();
         var _price:String = price;
         var _yzcode:String = yzcode;
         if(priceCode == "")
         {
        	 yzcode = md5.core_md5(_yzcode + this.bidnumber + _price + this.version + this.bidnumber + this.clientId + this.currenttime);
         }
         else
         {
        	 yzcode = md5.core_md5(this.version + this.clientId + this.requestid + this.bidnumber + _yzcode + _price + priceCode + this.currenttime);
         }
         this._requestid = this.requestid;
         var _loc7_:* = "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + yzcode + "\",version:\"" + this.version + "\",request:{bidamount:\"" + _price + "\",imagenumber:\"" + _yzcode + "\"}}";
         var _loc8_:String = this.xxtea.Base64Encrypted(_loc7_);
         _result.toStr(_loc8_);
         this.logappliction.WriteLogWithRequestID("投标板块","请求进入队列2-2",this.requestid);
         return _result;
      }
      
      public function ImageCodeRequest(param1:* = null) : *
      {
         this.GetCurrentTime();
         var _loc2_:String = GUID.create().toLowerCase();
         if(param1 != null)
         {
            _loc2_ = param1.toLowerCase();
         }
         var _loc3_:String = this.uid + "." + this.currenttime;
         var _loc4_:String = md5.core_md5(_loc3_ + this.currenttime + _loc2_ + this.version).toLowerCase();
         var _loc5_:* = "{requestid:\"" + _loc3_ + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + _loc4_ + "\",version:\"" + this.version + "\",request:{}}";
         var _loc6_:String = _loc5_;
         var _loc7_:* = "{\"method\":\"getimagecode\",\"cmd\":\"" + escape(_loc6_) + "\"}";
         return _loc7_;
      }
      
      public function GetImageCode() : *
      {
         this.GetCurrentTime();
         var _loc1_:String = this.uid + "." + this.currenttime; //80658434.20171023140000
         var _loc2_:String = md5.core_md5(_loc1_ + this.currenttime + this.version).toLowerCase();
         var _loc3_:* = "{requestid:\"" + _loc1_ + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + _loc2_ + "\",version:\"" + this.version + "\"}";
         var _loc4_:String = _loc3_;
         var _loc5_:* = "{\"method\":\"getimagecode\",\"cmd\":\"" + escape(_loc4_) + "\"}";
         return _loc5_;
      }
      
      public function BidCheckRequest(param1:String, param2:*) : String
      {
         this.GetCurrentTime();
         var _loc3_:String = this.uid + "." + this.currenttime;
         var _loc4_:String = param1;
         param1 = md5.core_md5(this.bidnumber + this.clientId + _loc4_ + _loc3_ + this.currenttime + param2 + this.version).toLowerCase();
         var _loc5_:* = "{requestid:\"" + _loc3_ + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + param1 + "\",version:\"" + this.version + "\",request:{uniqueid:\"" + param2 + "\",bidnumber:\"" + this.bidnumber + "\",imagenumber:\"" + _loc4_ + "\"}}";
         var _loc6_:String = _loc5_;
         var _loc7_:* = "{\"method\":\"bidcheck\",\"cmd\":\"" + escape(_loc6_) + "\"}";
         return _loc7_;
      }
      
      public function §̕§(param1:*) : *
      {
         var _loc2_:String = param1;
         var _loc3_:* = "{\"cmd\":\"" + param1 + "\"}";
         return _loc3_;
      }
   }
}
