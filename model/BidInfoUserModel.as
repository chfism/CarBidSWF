package model
{
   import flash.utils.ByteArray;
   import zebra.core.GameModel;
   import zebra.system.collections.ByteArrayCollection;
   import zebra.system.collections.GUID;
   import Utility.MD5;
   
   public class BidInfoUserModel extends GameModel
   {
       
      
      public var xxtea:XxteaEncodeAndDecode;
      
      public var timespan = "0";
      
      public var sendTimespan;
      
      public var getTimespan;
      
      public var bidnumber:String = "";
      
      public var clientId:String = "";
      
      public var checkcode:String = "";
      
      public var version:String = "";
      
      public var _keystr:String = "shcarbid";
      
      public var key1:ByteArray;
      
      public var currenttime:String = "";
      
      public function BidInfoUserModel()
      {
         this.xxtea = new XxteaEncodeAndDecode(Main.keystr);
         this.key1 = new ByteArray();
         super();
      }
      
      public function get uid() : String
      {
         return this.bidnumber;
      }
      
      public function get requestid() : String
      {
         return this.bidnumber + "." + this.currenttime;
      }
      
      public function createTimestamp() : void
      {
         var now:Date = new Date();
         this.currenttime = String(now.getHours()) + String(now.getMinutes()) + String(now.getSeconds()) + String(now.getMilliseconds());
      }
      
      public function data() : String
      {
         return "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\"}";
      }
      
      public function get bytes1_1() : ByteArrayCollection
      {
         this.createTimestamp();
         this.checkcode = MD5.startMd(this.bidnumber + this.clientId + this.requestid + this.currenttime + this.version).toLowerCase();
         var _byteArray3:ByteArrayCollection = new ByteArrayCollection();
         var dataString1_1:* = "{requestid:\"" + this.requestid + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.uid + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\"}";
         var content1_1:String = this.xxtea.XxteaEncode(dataString1_1);
         _byteArray3.toStr(content1_1);
         return _byteArray3;
      }
      
      public function get bytes0_0() : ByteArrayCollection
      {
         this.createTimestamp();
         var _loc1_:ByteArrayCollection = new ByteArrayCollection();
         var _loc2_:* = "{ts:\"" + this.currenttime + "\"}";
         var _loc3_:String = this.xxtea.XxteaEncode(_loc2_);
         _loc1_.toStr(_loc3_);
         return _loc1_;
      }
      /*
      public function get bytes0_0():ByteArrayCollection
      {
          this.createTimestamp();
          var timespan1:String = "0";
          this.checkcode = MD5.startMd((((((this.bidnumber + this.clientId) + this.requestid) + timespan1) + this.timestamp) + this.version));
          var _byteArray3:ByteArrayCollection = new ByteArrayCollection();
          var _dataString0_0:String = (((((((((((('{requestid:"' + this.requestid) + '",timestamp:"') + this.timestamp) + '",bidnumber:"') + this.uid) + '",checkcode:"') + this.checkcode) + '",version:"') + this.version) + '",request:{timespan:"') + timespan1) + '"}}');
          var content0_0:String = this.xxtea.XxteaEncode(_dataString0_0);
          var testxxtea1:String = this.xxtea.XxteaDecode(content0_0);
          _byteArray3.toStr(content0_0);
          return (_byteArray3);
      }
      */
      public function bytes2_1(param1:String) : ByteArrayCollection
      {
         this.createTimestamp();
         var _byteArray2to1:ByteArrayCollection = new ByteArrayCollection();
         var _loc3_:String = param1;
         this.checkcode = MD5.startMd(_loc3_ + this.bidnumber + this.clientId + this.requestid + this.currenttime + this.version);
         _byteArray2to1.toStr("{requestid:" + this.requestid + ",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + this.checkcode + "\",version:\"" + this.version + "\",request:{bidamount:" + _loc3_ + "}}");
         return _byteArray2to1;
      }
      
      public function bytes2_2(param1:String, checkcode:String) : ByteArrayCollection
      {
         this.createTimestamp();
         var _byteArray2to2:ByteArrayCollection = new ByteArrayCollection();
         var bidamount:String = param1;
         var imagenumber:String = checkcode;
         checkcode = MD5.startMd(bidamount + this.bidnumber + this.clientId + imagenumber + this.requestid + this.currenttime + this.version);
         _byteArray2to2.toStr("{requestid:" + this.requestid + ",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + checkcode + "\",version:\"" + this.version + "\",request:{bidamount:\"" + bidamount + "\",imagenumber:\"" + imagenumber + "\"}}");
         return _byteArray2to2;
      }
      
      public function selfPriceInfo()
      {
          this.createTimestamp();
          var uniqueid:String = GUID.create().toLowerCase();
          var requestid:String = ((this.uid + ".") + this.timestamp);
          var checkcode:String = MD5.startMd((((requestid + this.timestamp) + uniqueid) + this.version)).toLowerCase();
          var jsondata:String = (((((((((((('{requestid:"' + requestid) + '",timestamp:"') + this.timestamp) + '",bidnumber:"') + this.uid) + '",checkcode:"') + checkcode) + '",version:"') + this.version) + '",request:{uniqueid:"') + uniqueid) + '"}}');
          var data:String = (('{"method":"getimagecode","cmd":"' + escape(jsondata)) + '"}');
          return (data);
      }
      
      public function sendPriceInfo(param1:String) : String
      {
         this.createTimestamp();
         var _loc2_:String = GUID.create().toLowerCase();
         var _loc3_:String = this.uid + "." + this.currenttime;
         var _loc4_:String = param1;
         param1 = MD5.startMd(this.bidnumber + this.clientId + _loc4_ + _loc3_ + this.currenttime + _loc2_ + this.version).toLowerCase();
         var _loc5_:* = "{requestid:\"" + _loc3_ + "\",timestamp:\"" + this.currenttime + "\",bidnumber:\"" + this.bidnumber + "\",checkcode:\"" + param1 + "\",version:\"" + this.version + "\",request:{uniqueid:\"" + _loc2_ + "\",bidnumber:\"" + this.bidnumber + "\",imagenumber:\"" + _loc4_ + "\"}}";
         var _loc6_:* = "{\"method\":\"bidcheck\",\"cmd\":\"" + escape(_loc5_) + "\"}";
         return _loc6_;
      }
   }
}
