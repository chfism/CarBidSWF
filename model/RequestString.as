package model
{
   import flash.utils.ByteArray;
   import zebra.core.GameModel;
   import zebra.system.collections.ByteArrayCollection;
   import zebra.system.collections.GUID;
   import Utility.md5;
   
   public class RequestString extends GameModel
   {
       
      
      public var xxtea:EncodeAndDecode;
      
      public var _timediffstr = "0";
      
      public var _time1;
      
      public var _time2;
      
      public var bidnumber:String = "";
      
      public var clientId:String = "";
      
      public var checkcode:String = "";
      
      public var version:String = "";
      
      public var _keystr:String = "shcarbid";
      
      public var _bytearray:ByteArray;
      
      public var currenttime:String = "";
      
      public function RequestString()
      {
         this.xxtea = new EncodeAndDecode(Main.keystr);
         this._bytearray = new ByteArray();
         super();
      }
      
      public function get uid() : String
      {
         return this.bidnumber;
      }
      
      public function get requestid() : String
      {
         return this.bidnumber + ".e" + this.currenttime;
      }
      
      public function GetCurrentTime() : void
      {
         var _loc1_:Date = new Date();
         this.currenttime = String(_loc1_.getHours()) + String(_loc1_.getMinutes()) + String(_loc1_.getSeconds()) + String(_loc1_.getMilliseconds());
      }
      
      public function data() : String
      {
         return "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\"}";
      }
      
      public function get GoOnlineRequest() : ByteArrayCollection
      {
         this.GetCurrentTime();
         this.checkcode = md5.core_md5(this.bidnumber + this.clientId + this.requestid + this.currenttime + this.version).toLowerCase();
         var _loc1_:ByteArrayCollection = new ByteArrayCollection();
         var _loc2_:* = "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\"}";
         var _loc3_:String = this.xxtea.Base64Encrypted(_loc2_);
         _loc1_.toStr(_loc3_);
         return _loc1_;
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
      
      public function VerificationCodeRequest(param1:String) : ByteArrayCollection
      {
         this.GetCurrentTime();
         var _loc2_:ByteArrayCollection = new ByteArrayCollection();
         var _loc3_:String = param1;
         this.checkcode = md5.core_md5(_loc3_ + this.bidnumber + this.clientId + this.requestid + this.currenttime + this.version);
         _loc2_.toStr("{requestid:" + this.requestid + ",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\",request:{bidamount:" + _loc3_ + "}}");
         return _loc2_;
      }
      
      public function EncryptPriceAndCodeRequest(param1:String, param2:String) : ByteArrayCollection
      {
         this.GetCurrentTime();
         var _loc3_:ByteArrayCollection = new ByteArrayCollection();
         var _loc4_:String = param1;
         var _loc5_:String = param2;
         param2 = md5.core_md5(_loc4_ + this.bidnumber + this.clientId + _loc5_ + this.requestid + this.currenttime + this.version);
         _loc3_.toStr("{requestid:" + this.requestid + ",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + param2 + "\",version:\"" + this.version + "\",request:{bidamount:\"" + _loc4_ + "\",imagenumber:\"" + _loc5_ + "\"}}");
         return _loc3_;
      }
      
      public function ImageCodeRequest() : *
      {
         this.GetCurrentTime();
         var _loc1_:String = GUID.create().toLowerCase();
         var _loc2_:String = this.uid + "." + this.currenttime;
         var _loc3_:String = md5.core_md5(_loc2_ + this.currenttime + _loc1_ + this.version).toLowerCase();
         var _loc4_:* = "{requestid:\"" + _loc2_ + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + _loc3_ + "\",version:\"" + this.version + "\",request:{uniqueid:\"" + _loc1_ + "\"}}";
         var _loc5_:* = "{\"method\":\"getimagecode\",\"cmd\":\"" + escape(_loc4_) + "\"}";
         return _loc5_;
      }
      
      public function BidCheckRequest(param1:String) : String
      {
         this.GetCurrentTime();
         var _loc2_:String = GUID.create().toLowerCase();
         var _loc3_:String = this.uid + "." + this.currenttime;
         var _loc4_:String = param1;
         param1 = md5.core_md5(this.bidnumber + this.clientId + _loc4_ + _loc3_ + this.currenttime + _loc2_ + this.version).toLowerCase();
         var _loc5_:* = "{requestid:\"" + _loc3_ + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + param1 + "\",version:\"" + this.version + "\",request:{uniqueid:\"" + _loc2_ + "\",bidnumber:\"" + this.bidnumber + "\",imagenumber:\"" + _loc4_ + "\"}}";
         var _loc6_:* = "{\"method\":\"bidcheck\",\"cmd\":\"" + escape(_loc5_) + "\"}";
         return _loc6_;
      }
   }
}
