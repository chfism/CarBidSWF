package r1.deval.parser
{
   import ʊ.ʋ;
   import ʊ.ʌ;
   import ʊ.ʍ;
   import ʊ.ʗ;
   import ʊ.ʣ;
   import ʊ.ʤ;
   import ʊ.ʥ;
   import ʊ.ʦ;
   import ʊ.ʧ;
   
   public class ʐ extends ʏ
   {
      
      public static var ڎ:Boolean = false;
       
      
      private var §٥§:Array;
      
      private var §٦§:ʗ = null;
      
      private var §٭§:ʍ;
      
      private var ٮ:Array;
      
      private var ٵ:int = 0;
      
      private var ٶ:int = 0;
      
      private var ٿ:int = 0;
      
      private var ڀ:int = 0;
      
      private var ڃ:int = 0;
      
      private var څ:Array;
      
      private var ڊ:Array;
      
      public function ʐ()
      {
         ڊ = [];
         super();
      }
      
      private static function ڌ(param1:String, param2:ʍ, param3:Array) : void
      {
         var _loc5_:ʌ = null;
         trace(param1);
         var _loc4_:Object = {};
         for each(_loc5_ in param3)
         {
            _loc5_.§׳§(_loc4_);
         }
         param2.§׳§(_loc4_);
      }
      
      private static function ڍ(param1:int) : String
      {
         switch(param1)
         {
            case CLASS:
               return "class";
            case TRY:
               return "try";
            case CATCH:
               return "catch";
            case FINALLY:
               return "finally";
            default:
               return "";
         }
      }
      
      public function §׸§(param1:*, param2:int) : void
      {
         if(§٭§.§׾§)
         {
            §׫§("msg.unreachable.code","K51");
         }
         §٭§.§׸§(param1,param2);
      }
      
      protected function §٣§(param1:String = null, param2:Boolean = false) : Array
      {
         var _loc3_:ʍ = new ʍ(param1);
         ٸ(_loc3_);
         ڇ(null,param2);
         var _loc4_:Array = [_loc3_,§٭§];
         ٱ();
         return _loc4_;
      }
      
      private function §٤§() : Object
      {
         return ٮ[ٮ.length - 1];
      }
      
      protected function §٧§() : ʋ
      {
         ي(LP,"msg.no.paren.cond","k51");
         var _loc1_:ʋ = §ٓ§();
         ي(RP,"msg.no.paren.after.cond","k52");
         return _loc1_;
      }
      
      protected function §٨§(param1:ʢ, param2:ʍ, param3:ʍ, param4:String = null) : ʢ
      {
         if(param1 == null)
         {
            param1 = ٽ(param4);
         }
         param1.block = param2;
         param1.§۸§ = param3 == null?param2:param3;
         ډ(param1);
         return param1;
      }
      
      public function §׾§(param1:ʍ) : Boolean
      {
         return param1 != null && param1.§׾§;
      }
      
      private function §٩§() : ʢ
      {
         return څ.pop() as ʢ;
      }
      
      private function §٪§(param1:int, param2:ʢ) : void
      {
         var _loc4_:String = null;
         var _loc5_:ʋ = null;
         var _loc3_:Boolean = false;
         if(§٠§(NAME))
         {
            if(§١§.§׮§() == "each")
            {
               _loc3_ = true;
            }
            else
            {
               §׫§("msg.no.paren.for","K55");
            }
         }
         ي(LP,"msg.no.paren.for","k54");
         var _loc6_:int = §ً§();
         if(_loc6_ != SEMI)
         {
            if(_loc6_ == VAR)
            {
               §ِ§();
               ي(NAME,"msg.bad.var","k55");
               _loc4_ = §١§.§׮§();
               if(§ً§() == IN)
               {
                  §ِ§();
                  ه.§ۢ§(_loc4_);
               }
               else
               {
                  ڋ(_loc4_);
                  _loc4_ = null;
               }
            }
            else if(§ً§() == NAME)
            {
               _loc4_ = §١§.§׮§();
               §ِ§();
               if(§ً§() == IN)
               {
                  §ِ§();
               }
               else
               {
                  غ();
                  _loc4_ = null;
                  ڇ(null,true);
               }
            }
            else
            {
               ڇ(null,true);
            }
         }
         var _loc7_:ʍ = null;
         if(_loc4_)
         {
            _loc5_ = §ٓ§();
         }
         else
         {
            ي(SEMI,"msg.no.semi.for","k56");
            _loc5_ = §ً§() == SEMI?null:§ٓ§();
            ي(SEMI,"msg.no.semi.for.cond","k57");
            if(§ً§() != RP)
            {
               _loc7_ = §٣§(null,true)[0] as ʍ;
            }
         }
         ي(RP,"msg.no.paren.for.ctrl","k58");
         var _loc8_:String = (!!_loc3_?"@for_each_":!!_loc4_?"@for_in_":"@for_") + ٵ++;
         if(_loc4_ == null)
         {
            ٴ(param1,param2,_loc8_,_loc5_,":for-body:",_loc7_);
         }
         else
         {
            ٳ(param1,param2,_loc8_,_loc4_,_loc5_,_loc3_,_loc7_);
         }
      }
      
      private function §٫§(param1:ʢ) : void
      {
         var label:ʢ = null;
         var ސ:ʍ = null;
         var ޒ:ʢ = param1;
         var ޏ:Array = §٣§(":do-while-body");
         var ޑ:ʍ = ޏ[0] as ʍ;
         §٭§.§׻§ = ޑ;
         if(!§׾§((ޏ[1] as ʍ).§׻§))
         {
            (ޏ[1] as ʍ).§׻§ = ޑ;
         }
         try
         {
            label = §٨§(ޒ,ޑ,null,"@do_while_");
            ޑ.name = label.name;
            ي(WHILE,"msg.no.while.do","k53");
            ޑ.§؁§(§٧§(),§١§.ڹ());
            ސ = new ʍ();
            if(!§׾§((ޏ[1] as ʍ).§׻§))
            {
               (ޏ[1] as ʍ).§؃§ = ސ;
            }
            ٱ();
            ٸ(ސ);
            return;
         }
         finally
         {
            ځ();
         }
      }
      
      override protected function §ٔ§(param1:Boolean = false) : ʌ
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(!param1)
         {
            _loc2_ = §٬§(NAME,"msg.missing.function.name","Kf1");
         }
         §٬§(LP,"msg.no.paren.parms","Kf2");
         var _loc4_:Array = [];
         loop0:
         while(true)
         {
            _loc3_ = §ً§();
            if(_loc3_ == RP)
            {
               break;
            }
            if(_loc3_ == NAME)
            {
               _loc4_.push(§١§.§׮§());
               §ِ§();
               loop1:
               while(true)
               {
                  switch(§ً§())
                  {
                     case COLON:
                     case DOT:
                     case NAME:
                        §ِ§();
                        continue;
                     case COMMA:
                        break loop1;
                     case RP:
                        addr53:
                        continue loop0;
                     default:
                        §׫§("msg.no.paren.after.parms","Kf3");
                        continue;
                  }
               }
               §ِ§();
               §§goto(addr53);
            }
            else
            {
               continue;
            }
         }
         §ِ§();
         loop2:
         while(true)
         {
            switch(§ً§())
            {
               case COLON:
               case DOT:
               case NAME:
                  §ِ§();
                  continue;
               case LC:
                  break loop2;
               default:
                  §׫§("msg.no.brace.body","Kf4");
                  continue;
            }
         }
         §ِ§();
         var _loc5_:ʍ = ٸ();
         var _loc6_:ʗ = §٦§ = new ʗ("[/" + _loc2_ + "]");
         while(§٦§ != null)
         {
            ڇ();
         }
         var _loc7_:ʍ = ټ(_loc5_);
         if(_loc7_.§؈§() > 0)
         {
            if(_loc7_.§׻§ == null)
            {
               _loc7_.§׻§ = _loc6_;
            }
            if(_loc7_.§؃§ == null)
            {
               _loc7_.§؃§ = _loc6_;
            }
         }
         return new ʌ(_loc2_,_loc4_,_loc5_,_loc6_);
      }
      
      private function §٬§(param1:int, param2:String, param3:String) : String
      {
         if(§ً§() != param1)
         {
            §׫§(param2,param3);
         }
         var _loc4_:String = §١§.§׮§();
         §ِ§();
         return _loc4_;
      }
      
      private function get ٯ() : Boolean
      {
         return ٮ.length > 0;
      }
      
      private function §ٰ§(param1:ʢ, param2:ʋ, param3:int) : void
      {
         §٬§(LC,"msg.no.brace.switch","Ksw5");
         var _loc4_:String = "_switch_" + ڄ;
         §׸§(ه.§ۢ§(_loc4_,param2),0);
         var _loc5_:ʍ = §٭§;
         _loc5_.§׻§ = ٸ();
         if(param1 == null)
         {
            param1 = ٽ();
         }
         param1.§۹§ = true;
         param1.block = new ʍ();
         ډ(param1);
         var _loc6_:Object = {
            "switchVar":ه.ۥ(null,_loc4_),
            "type":0,
            "branchHead":§٭§,
            "branchCondition":_loc5_,
            "label":param1
         };
         var _loc7_:int = ڄ;
         ٮ.push(_loc6_);
         do
         {
            ڇ();
         }
         while(ڄ > _loc7_);
         
      }
      
      protected function ٱ() : ʍ
      {
         var _loc1_:ʍ = ڊ.pop() as ʍ;
         §٭§ = ڊ[ڊ.length - 1] as ʍ;
         return _loc1_;
      }
      
      private function ٲ(param1:String) : ʢ
      {
         var _loc2_:ʢ = څ[param1] as ʢ;
         if(_loc2_ == null)
         {
            §׫§("msg.undef.label","K53");
         }
         return _loc2_;
      }
      
      private function ٳ(param1:int, param2:ʢ, param3:String, param4:String, param5:ʋ, param6:Boolean, param7:ʍ = null) : void
      {
         var ޓ:Array = null;
         var ޚ:ʍ = null;
         var ڠ:int = param1;
         var ޒ:ʢ = param2;
         var ޖ:String = param3;
         var ޙ:String = param4;
         var ޘ:ʋ = param5;
         var ޗ:Boolean = param6;
         var ޛ:ʍ = param7;
         var ސ:ʍ = new ʍ();
         var ޔ:int = ڀ++;
         var ޕ:ʧ = new ʧ(ޔ,ޙ,ޘ,ޗ,ڠ);
         §׸§(ޕ,ڠ);
         var ޑ:ʍ = new ʍ();
         §٭§.§׻§ = ޑ;
         ޑ.§؃§ = ސ;
         var label:ʢ = §٨§(ޒ,ޑ,ޛ,ޖ);
         ޑ.name = label.name;
         try
         {
            ޓ = §٣§(":for-body:");
            ޚ = ޓ[0] as ʍ;
            if(ޛ != null)
            {
               ޛ.§׻§ = ޚ.§׻§;
               ޚ.§׻§ = ޛ;
            }
            ޑ.§؁§(new ʣ(ޕ));
            ޑ.§׻§ = ޚ;
            ޑ.§؃§ = ސ;
            (ޓ[1] as ʍ).§׻§ = ޑ;
            ٱ();
            ٸ(ސ);
            return;
         }
         finally
         {
            ځ();
         }
      }
      
      private function ٴ(param1:int, param2:ʢ, param3:String, param4:ʋ, param5:String = ":while_body:", param6:ʍ = null) : void
      {
         var ޓ:Array = null;
         var ޝ:ʍ = null;
         var ڠ:int = param1;
         var ޒ:ʢ = param2;
         var ޖ:String = param3;
         var cond:ʋ = param4;
         var ޜ:String = param5;
         var ޛ:ʍ = param6;
         var ސ:ʍ = new ʍ();
         var ޑ:ʍ = new ʍ();
         §٭§.§׻§ = ޑ;
         ޑ.§؁§(cond,ڠ);
         ޑ.§؃§ = ސ;
         var label:ʢ = §٨§(ޒ,ޑ,ޛ,ޖ);
         ޑ.name = label.name;
         try
         {
            ޓ = §٣§(ޜ);
            ޝ = ޓ[1] as ʍ;
            if(ޛ != null && !ޝ.§׾§)
            {
               ޛ.§׻§ = ޝ.§׻§;
               ޝ.§׻§ = ޛ;
               ޝ = ޛ;
            }
            ޑ.§׻§ = ޓ[0] as ʍ;
            if(!ޝ.§׾§)
            {
               ޝ.§׻§ = ޑ;
            }
            ٱ();
            ٸ(ސ);
            return;
         }
         finally
         {
            ځ();
         }
      }
      
      private function ٷ() : ʢ
      {
         if(§َ§() != NAME)
         {
            return null;
         }
         §ِ§();
         return ٲ(§١§.§׮§());
      }
      
      protected function ٸ(param1:* = null) : ʍ
      {
         if(param1 == null)
         {
            param1 = new ʍ();
         }
         else if(param1 is String)
         {
            param1 = new ʍ(String(param1));
         }
         ڊ.push(§٭§ = param1 as ʍ);
         return §٭§;
      }
      
      override protected function ك(param1:String) : void
      {
         super.ك(param1);
         څ = [];
         ٮ = [];
         §٥§ = [];
      }
      
      private function ٹ(param1:Boolean) : void
      {
         §٭§.§׾§ = true;
         var _loc2_:ʢ = ٷ();
         if(_loc2_ == null)
         {
            _loc2_ = پ();
         }
         if(_loc2_.§۹§)
         {
            if(!param1)
            {
               §׫§("msg.bad.continue","Ksw");
            }
            §٭§.§׻§ = _loc2_.block;
         }
         else
         {
            §٭§.§׻§ = !!param1?_loc2_.block.§؃§:_loc2_.§۸§;
         }
      }
      
      public function §ֳ§(param1:String) : Object
      {
         var _loc3_:ʌ = null;
         ك(param1);
         ٸ(":Main:");
         var _loc2_:ʍ = §٭§;
         while(§ً§() != EOF)
         {
            ڇ();
         }
         if(§٭§.§׻§ == null)
         {
            §٭§.§׻§ = ʗ.ڦ;
         }
         ٱ();
         if(ڎ)
         {
            ڌ("===== Pre-optimization =====",_loc2_,§٥§);
         }
         _loc2_.װ();
         for each(_loc3_ in §٥§)
         {
            _loc3_.װ();
         }
         if(ڎ)
         {
            ڌ("\n===== Post-optimization =====",_loc2_,§٥§);
         }
         if(§٥§.length == 0)
         {
            return _loc2_;
         }
         return [_loc2_,§٥§];
      }
      
      private function ٺ(param1:int, param2:ʋ) : void
      {
         §٭§.§؁§(param2,param1);
         var _loc3_:ʍ = new ʍ();
         var _loc4_:Array = §٣§(":if-part:");
         §٭§.§׻§ = _loc4_[0] as ʍ;
         var _loc5_:ʍ = _loc4_[1] as ʍ;
         if(!_loc5_.§׾§)
         {
            _loc5_.§׻§ = _loc3_;
         }
         if(§٠§(ELSE))
         {
            §ِ§();
            _loc4_ = §٣§(":else-part:");
            §٭§.§؃§ = _loc4_[0] as ʍ;
            _loc5_ = _loc4_[1] as ʍ;
            if(!_loc5_.§׾§)
            {
               _loc5_.§׻§ = _loc3_;
            }
         }
         else
         {
            §٭§.§؃§ = _loc3_;
         }
         ٱ();
         ٸ(_loc3_);
      }
      
      private function ٻ(param1:int, param2:ʋ = null) : void
      {
         var _loc9_:ʢ = null;
         var _loc3_:int = §١§.ڹ();
         var _loc4_:Object = §٤§();
         var _loc5_:ʍ = _loc4_.branchCondition as ʍ;
         var _loc6_:ʍ = _loc4_.branchHead as ʍ;
         var _loc7_:int = _loc4_.type as int;
         _loc4_.type = param1;
         if(param2 != null)
         {
            param2 = ه.ۦ(_loc4_.switchVar as ʋ,param2,EQ);
         }
         if(_loc7_ == 0)
         {
            if(!_loc6_.§׹§())
            {
               §׫§("msg.unreachable.stmts.in.switch","Ksw6");
            }
            if(param1 == CASE)
            {
               _loc5_.§؁§(param2,_loc3_);
            }
            else
            {
               _loc4_.defaultBlockHead = _loc6_;
            }
            return;
         }
         var _loc8_:ʍ = ټ(_loc6_);
         if(_loc7_ == DEFAULT)
         {
            _loc4_.defaultBlockTail = _loc8_;
         }
         if(param1 == RC)
         {
            _loc9_ = §٩§();
            if(!_loc8_.§׾§)
            {
               _loc8_.§׻§ = _loc9_.block;
            }
            _loc6_ = _loc4_.defaultBlockHead as ʍ;
            if(_loc6_ != null)
            {
               _loc8_ = _loc4_.defaultBlockTail as ʍ;
               _loc5_.§؃§ = _loc6_;
            }
            ٮ.pop();
            ٸ(_loc9_.block);
            return;
         }
         _loc4_.branchHead = ٸ();
         if(!_loc8_.§׾§)
         {
            _loc8_.§׻§ = §٭§;
         }
         if(param1 == DEFAULT)
         {
            _loc4_.defaultBlockHead = §٭§;
         }
         else if(param1 == CASE)
         {
            if(_loc5_.§׽§() != null)
            {
               _loc5_.§؃§ = new ʍ();
               _loc5_ = _loc5_.§؃§;
               _loc5_.§؃§ = پ().block;
               _loc4_.branchCondition = _loc5_;
            }
            _loc5_.§؁§(param2,_loc3_);
            _loc5_.§׻§ = §٭§;
         }
      }
      
      protected function ټ(param1:ʍ) : ʍ
      {
         var _loc2_:ʍ = ٱ();
         var _loc3_:int = ڊ.indexOf(param1);
         if(_loc3_ >= 0)
         {
            ڊ.length = _loc3_;
         }
         §٭§ = ڊ[ڊ.length - 1] as ʍ;
         return _loc2_;
      }
      
      private function ٽ(param1:String = null) : ʢ
      {
         if(param1 == null)
         {
            param1 = "@_";
         }
         return new ʢ(param1 + ڃ++);
      }
      
      private function پ() : ʢ
      {
         if(څ.length == 0)
         {
            §׫§("msg.bad.break.continue","K56");
         }
         return څ[څ.length - 1] as ʢ;
      }
      
      protected function ځ() : void
      {
         §٩§();
      }
      
      private function ڂ() : void
      {
         var _loc1_:int = 0;
         while((_loc1_ = §ً§()) != EOF && _loc1_ != RC)
         {
            ڇ();
         }
      }
      
      private function get ڄ() : int
      {
         return ٮ.length;
      }
      
      private function چ(param1:int) : void
      {
         if(!(§٠§(NAME) && §١§.§׮§() == "xml"))
         {
            §׫§("msg.bad.namespace","K57");
         }
         if(!(§٠§(NAME) && §١§.§׮§() == "namespace"))
         {
            §׫§("msg.bad.namespace","K58");
         }
         if(!§٠§(ASSIGN))
         {
            §׫§("msg.bad.namespace","K59");
         }
         §׸§(new ʦ(DEFAULT_NS,§ٓ§(),param1),param1);
      }
      
      private function ڇ(param1:ʢ = null, param2:Boolean = false) : void
      {
         var _loc4_:ʋ = null;
         var _loc9_:String = null;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc7_:int = §١§.ڹ();
         var _loc8_:int = §ً§();
         switch(_loc8_)
         {
            case IF:
               §ِ§();
               ٺ(_loc7_,§٧§());
               return;
            case SWITCH:
               §ِ§();
               §ٰ§(param1,§٧§(),_loc7_);
               break;
            case CASE:
               §ِ§();
               if(!ٯ)
               {
                  §׫§("msg.misplaced.case","Ksw1");
               }
               _loc4_ = §ٓ§();
               §٬§(COLON,"msg.case.no.colon","Ksw2");
               ٻ(CASE,_loc4_);
               return;
            case DEFAULT:
               §ِ§();
               if(§ً§() == COLON)
               {
                  §٬§(COLON,"msg.case.no.colon","Ksw3");
                  ٻ(DEFAULT);
                  return;
               }
               چ(_loc7_);
               break;
            case RC:
               if(!ٯ && §٦§ == null)
               {
                  §׫§("msg.misplaced.right.brace","Krc");
               }
               §ِ§();
               if(ٯ)
               {
                  ٻ(RC);
               }
               else
               {
                  §٦§ = null;
               }
               return;
            case BREAK:
            case CONTINUE:
               §ِ§();
               ٹ(_loc8_ == BREAK);
               break;
            case THROW:
               §ِ§();
               §٭§.§׾§ = true;
               §׸§(new ʦ(THROW,§ٓ§(),_loc7_),_loc7_);
               break;
            case WHILE:
               §ِ§();
               _loc4_ = §٧§();
               ٴ(_loc7_,param1,"@while_" + ٿ++,_loc4_);
               return;
            case DO:
               §ِ§();
               §٫§(param1);
               return;
            case FOR:
               §ِ§();
               §٪§(§١§.ڹ(),param1);
               return;
            case VAR:
               §ِ§();
               ڋ();
               break;
            case RETURN:
               §ِ§();
               switch(§َ§())
               {
                  case SEMI:
                     §ِ§();
                  case RC:
                  case EOF:
                  case EOL:
                  case ERROR:
                     break;
                  default:
                     §׸§(§ٓ§(),_loc7_);
               }
               §٭§.§׻§ = §٦§ != null?§٦§:ʗ.ڦ;
               §٭§.§׾§ = true;
               break;
            case LC:
               §ِ§();
               ڂ();
               ي(RC,"msg.no.brace.block","k65");
               return;
            case ERROR:
            case SEMI:
               §ِ§();
               break;
            case IMPORT:
               §ِ§();
               ڈ(_loc7_);
               break;
            case NAME:
               _loc9_ = §١§.§׮§();
               م();
               _loc4_ = §ٓ§();
               if(_loc4_ is ʢ)
               {
                  if(param1 == null)
                  {
                     _loc10_ = true;
                     param1 = _loc4_ as ʢ;
                  }
                  else
                  {
                     _loc10_ = false;
                  }
                  ڇ(param1);
                  break;
               }
               §׸§(_loc4_,_loc7_);
               break;
            case FUNCTION:
               §ِ§();
               §٥§.push(§ٔ§());
               break;
            case CLASS:
               §׫§("msg.class.not.supported","K64");
               break;
            case TRY:
            case CATCH:
            case FINALLY:
               §׫§("msg.reserved.id","K54",ڍ(_loc8_));
               break;
            default:
               §׸§(§ٓ§(),§١§.ڹ());
         }
         if(!param2)
         {
            _loc11_ = §ٟ§();
            switch(_loc11_ & CLEAR_TI_MASK)
            {
               case SEMI:
                  §ِ§();
               case ERROR:
               case EOF:
               case RC:
                  break;
               default:
                  if((_loc11_ & TI_AFTER_EOL) == 0)
                  {
                     §׫§("msg.no.semi.stmt","K65");
                     break;
                  }
            }
         }
      }
      
      private function ڈ(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         loop0:
         while(true)
         {
            _loc4_ = §ٟ§();
            switch(_loc4_ & CLEAR_TI_MASK)
            {
               case NAME:
                  if(!_loc3_)
                  {
                     _loc3_ = §١§.§׮§();
                  }
                  else
                  {
                     _loc3_ = _loc3_ + ("." + §١§.§׮§());
                  }
                  §ِ§();
                  continue;
               case DOT:
                  §ِ§();
                  continue;
               case COMMA:
                  _loc2_.push(_loc3_);
                  _loc3_ = null;
                  §ِ§();
                  continue;
               case SEMI:
                  §ِ§();
               case ERROR:
               case EOF:
               case RC:
                  addr107:
                  _loc2_.push(_loc3_);
                  §׸§(new ʤ(_loc2_,param1),param1);
                  return;
               default:
                  break loop0;
            }
         }
         if((_loc4_ & TI_AFTER_EOL) == 0)
         {
            §׫§("msg.no.semi.stmt","K66");
         }
         §§goto(addr107);
      }
      
      private function ډ(param1:ʢ) : void
      {
         if(څ[param1.name] != null)
         {
            §׫§("msg.dup.label","K61");
         }
         څ.push(param1);
         څ[param1.name] = param1;
      }
      
      private function ڋ(param1:String = null) : void
      {
         var _loc2_:ʋ = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc3_:int = §١§.ڹ();
         do
         {
            if(param1 != null)
            {
               _loc4_ = param1;
            }
            else
            {
               ي(NAME,"msg.bad.var","k66");
               _loc4_ = §١§.§׮§();
            }
            if(§ً§() == COLON)
            {
               §ِ§();
               ي(NAME,"msg.bad.var","k67");
               §ِ§();
            }
            _loc5_ = null;
            if(§٠§(ASSIGN))
            {
               _loc5_ = ؼ();
            }
            _loc2_ = ه.§ۢ§(_loc4_,_loc5_,_loc2_);
         }
         while(§٠§(COMMA));
         
         if(_loc2_ is ʥ)
         {
            _loc2_ = (_loc2_ as ʥ).ۼ();
         }
         §׸§(_loc2_,_loc3_);
      }
   }
}
