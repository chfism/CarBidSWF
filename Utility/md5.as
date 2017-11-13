package Utility
{
	//http://bbs.blueidea.com/thread-2770961-1-1.html
   import flash.utils.ByteArray;
   
   public class md5
   {
       
      
      public function md5()
      {
         super();
      }
      
      public static function core_md5(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 1732584193;
         var _loc3_:int = -271733879;
         var _loc4_:int = -1732584194;
         var _loc5_:int = 271733878;
         var _loc10_:Array = γ(δ(param1));
         var length:int = _loc10_.length;
         var i:int = 0;
         while(i < length)
         {
            _loc6_ = _loc2_;
            _loc7_ = _loc3_;
            _loc8_ = _loc4_;
            _loc9_ = _loc5_;
            _loc2_ = md5_ff(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 0],7,-680876936);
            _loc5_ = md5_ff(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 1],12,-389564586);
            _loc4_ = md5_ff(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 2],17,606105819);
            _loc3_ = md5_ff(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 3],22,-1044525330);
            _loc2_ = md5_ff(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 4],7,-176418897);
            _loc5_ = md5_ff(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 5],12,1200080426);
            _loc4_ = md5_ff(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 6],17,-1473231341);
            _loc3_ = md5_ff(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 7],22,-45705983);
            _loc2_ = md5_ff(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 8],7,1770035416);
            _loc5_ = md5_ff(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 9],12,-1958414417);
            _loc4_ = md5_ff(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 10],17,-42063);
            _loc3_ = md5_ff(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 11],22,-1990404162);
            _loc2_ = md5_ff(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 12],7,1804603682);
            _loc5_ = md5_ff(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 13],12,-40341101);
            _loc4_ = md5_ff(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 14],17,-1502002290);
            _loc3_ = md5_ff(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 15],22,1236535329);
            _loc2_ = md5_gg(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 1],5,-165796510);
            _loc5_ = md5_gg(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 6],9,-1069501632);
            _loc4_ = md5_gg(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 11],14,643717713);
            _loc3_ = md5_gg(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 0],20,-373897302);
            _loc2_ = md5_gg(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 5],5,-701558691);
            _loc5_ = md5_gg(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 10],9,38016083);
            _loc4_ = md5_gg(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 15],14,-660478335);
            _loc3_ = md5_gg(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 4],20,-405537848);
            _loc2_ = md5_gg(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 9],5,568446438);
            _loc5_ = md5_gg(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 14],9,-1019803690);
            _loc4_ = md5_gg(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 3],14,-187363961);
            _loc3_ = md5_gg(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 8],20,1163531501);
            _loc2_ = md5_gg(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 13],5,-1444681467);
            _loc5_ = md5_gg(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 2],9,-51403784);
            _loc4_ = md5_gg(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 7],14,1735328473);
            _loc3_ = md5_gg(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 12],20,-1926607734);
            _loc2_ = md5_hh(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 5],4,-378558);
            _loc5_ = md5_hh(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 8],11,-2022574463);
            _loc4_ = md5_hh(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 11],16,1839030562);
            _loc3_ = md5_hh(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 14],23,-35309556);
            _loc2_ = md5_hh(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 1],4,-1530992060);
            _loc5_ = md5_hh(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 4],11,1272893353);
            _loc4_ = md5_hh(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 7],16,-155497632);
            _loc3_ = md5_hh(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 10],23,-1094730640);
            _loc2_ = md5_hh(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 13],4,681279174);
            _loc5_ = md5_hh(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 0],11,-358537222);
            _loc4_ = md5_hh(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 3],16,-722521979);
            _loc3_ = md5_hh(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 6],23,76029189);
            _loc2_ = md5_hh(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 9],4,-640364487);
            _loc5_ = md5_hh(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 12],11,-421815835);
            _loc4_ = md5_hh(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 15],16,530742520);
            _loc3_ = md5_hh(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 2],23,-995338651);
            _loc2_ = md5_ii(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 0],6,-198630844);
            _loc5_ = md5_ii(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 7],10,1126891415);
            _loc4_ = md5_ii(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 14],15,-1416354905);
            _loc3_ = md5_ii(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 5],21,-57434055);
            _loc2_ = md5_ii(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 12],6,1700485571);
            _loc5_ = md5_ii(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 3],10,-1894986606);
            _loc4_ = md5_ii(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 10],15,-1051523);
            _loc3_ = md5_ii(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 1],21,-2054922799);
            _loc2_ = md5_ii(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 8],6,1873313359);
            _loc5_ = md5_ii(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 15],10,-30611744);
            _loc4_ = md5_ii(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 6],15,-1560198380);
            _loc3_ = md5_ii(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 13],21,1309151649);
            _loc2_ = md5_ii(_loc2_,_loc3_,_loc4_,_loc5_,_loc10_[i + 4],6,-145523070);
            _loc5_ = md5_ii(_loc5_,_loc2_,_loc3_,_loc4_,_loc10_[i + 11],10,-1120210379);
            _loc4_ = md5_ii(_loc4_,_loc5_,_loc2_,_loc3_,_loc10_[i + 2],15,718787259);
            _loc3_ = md5_ii(_loc3_,_loc4_,_loc5_,_loc2_,_loc10_[i + 9],21,-343485551);
            _loc2_ = _loc2_ + _loc6_;
            _loc3_ = _loc3_ + _loc7_;
            _loc4_ = _loc4_ + _loc8_;
            _loc5_ = _loc5_ + _loc9_;
            i = i + 16;
         }
         return hex.binl2hex(_loc2_) + hex.binl2hex(_loc3_) + hex.binl2hex(_loc4_) + hex.binl2hex(_loc5_);
      }
      
      private static function f(param1:int, param2:int, param3:int) : int
      {
         return param1 & param2 | ~param1 & param3;
      }
      
      private static function g(param1:int, param2:int, param3:int) : int
      {
         return param1 & param3 | param2 & ~param3;
      }
      
      private static function h(param1:int, param2:int, param3:int) : int
      {
         return param1 ^ param2 ^ param3;
      }
      
      private static function i(param1:int, param2:int, param3:int) : int
      {
         return param2 ^ (param1 | ~param3);
      }
      
      private static function ΰ(param1:Function, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : int
      {
         var _loc9_:int = param2 + int(param1(param3,param4,param5)) + param6 + param8;
         return hex.rol(_loc9_,param7) + param3;
      }
      
      private static function md5_ff(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return ΰ(f,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function md5_gg(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return ΰ(g,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function md5_hh(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return ΰ(h,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function md5_ii(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return ΰ(i,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function γ(param1:String) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = param1.length * 8;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_[_loc5_ >> 5] = _loc2_[_loc5_ >> 5] | (param1.charCodeAt(_loc5_ / 8) & 255) << _loc5_ % 32;
            _loc5_ = _loc5_ + 8;
         }
         _loc2_[_loc3_ >> 5] = _loc2_[_loc3_ >> 5] | 128 << _loc3_ % 32;
         _loc2_[(_loc3_ + 64 >>> 9 << 4) + 14] = _loc3_;
         return _loc2_;
      }
      
      private static function changeUTF2ASCII(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(param1.length > 65535)
         {
            throw new Error("In Utility:changeUTF2 s.length must less than 65536");
         }
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTF(param1);
         _loc2_.position = 2;
         var _loc3_:String = "";
         var _loc4_:int = 0;
         var _loc5_:int = _loc2_.bytesAvailable;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc2_.readUnsignedByte();
            _loc7_ = String.fromCharCode(_loc6_);
            _loc3_ = _loc3_ + _loc7_;
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function δ(param1:String) : String
      {
         var _loc3_:int = Math.ceil(param1.length / 65530);
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            if(_loc6_ == _loc3_ - 1)
            {
               _loc4_ = param1.substr(_loc6_ * 65530);
            }
            else
            {
               _loc4_ = param1.substr(_loc6_ * 65530,65530);
            }
            _loc5_ = _loc5_ + changeUTF2ASCII(_loc4_);
            _loc6_++;
         }
         return _loc5_;
      }
   }
}
