package model
{ //HUM http://www.voidcn.com/article/p-sepvrhcx-wt.html
   import flash.display.MovieClip;
   import flash.utils.ByteArray;
   import Utility.XXTEA;
   import Utility.Base64;
   
   public class EncodeAndDecode
   {
       
      
      private var _notusedkey:String = "gfheru3";
      
      private var key:ByteArray;
      
      private var §̚§:String = "abcd";
      
      var encode:Object;
      
      var decode:Object;
      
      var a:Array;
      
      var input:String = "This is a regular string";
      
      var _str:String;
      
      public function EncodeAndDecode(param1:String)
      {
    	  //http://www.cnblogs.com/shinings/archive/2010/05/05/1728138.html
         this.key = new ByteArray();
         this.encode = new Object();
         this.decode = new Object();
         this.a = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".split("");
         
         this._str = this.encodeString(this.input);
         super();
         this.key.writeMultiByte(param1.substr(2,5),"utf-8");
      }
      
      public function Base64Encrypted(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeMultiByte(Base64.encode(param1),"utf-8");
         var _loc3_:ByteArray = XXTEA.encrypt(_loc2_,this.key);
         var _loc4_:String = Base64.encodeByteArray(_loc3_);
         return _loc4_;
      }
      
      public function Base64Decrypted(param1:String) : String
      {
         var _loc2_:ByteArray = Base64.decodeToByteArray(param1);
         var _loc3_:ByteArray = XXTEA.decrypt(_loc2_,this.key);
         var _loc4_:String = _loc3_.toString();
         var _loc5_:String = Base64.decode(_loc4_);
         return _loc5_;
      }
      
      public function §̝§(param1:String) : String
      {
         var _length:Number = NaN;
         var _loc5_:Number = NaN;
         var _index:Number = NaN;
         var _index2:Number = NaN;
         var _loc8_:Number = NaN;
         var _array:Array = param1.split("");
         _length = _array.length;
         if((_loc5_ = _length % 7) != 0)
         {
            _length = _length + 7 - _loc5_;
         }
         
         §§push(_loc4_);
         if(!new MovieClip()["@doswf__stage"])
         {
            return;
         }
         var _loc9_:Array = new §§pop().Array(§§pop());
         _loc8_ = _length / 7;
         _index = 0;
         while(_index < 7)
         {
        	 _index2 = 0;
            while(_index2 < _loc8_)
            {
               if(_index * _loc8_ + _index2 < _array.length)
               {
                  _loc9_[_index + _index2 * 7] = _array[_index * _loc8_ + _index2];
               }
               else
               {
                  _loc9_[_index + 7 * _index2] = " ";
               }
               _index2++;
            }
            _index++;
         }
         while(_loc9_[_length - 1] == " ")
         {
            _length--;
         }
         var _resultstr:String = "";
         _index = 0;
         while(_index < _length)
         {
        	 _resultstr = _resultstr + _loc9_[_index];
        	 _index++;
         }
         return _resultstr;
      }
      
      function encodeString(str:String) : String
      {
         return this.map(str,this.encode);
      }
      
      function decodeString(str:String) : String
      {
         return this.map(str,this.decode);
      }
      
      function map(inputstr:String, obj:Object) : String
      {
         var singlestr:String = null;
         var value:String = null;
         var result:String = "";
         var i:int = 0;
         while(i < inputstr.length)
         {
        	 singlestr = inputstr.charAt(i);
        	 value = obj[singlestr];
            if(value)
            {
            	result = result + value;
            }
            else
            {
            	result = result + singlestr;
            }
            i++;
         }
         return result;
      }
   }
}
