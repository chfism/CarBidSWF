package r1.deval.parser
{
   import ʊ.ʉ;
   import ʊ.ʋ;
   import ʊ.ʌ;
   import ʊ.ʝ;
   import ʊ.ʟ;
   import ʊ.ʠ;
   import ʊ.ʡ;
   
   public class ʏ extends ʎ
   {
      
      protected static const §٢§:int = 1 << 17;
      
      protected static const CLEAR_TI_MASK:int = 65535;
      
      protected static const TI_AFTER_EOL:int = 1 << 16;
       
      
      private var ق:int;
      
      protected var ه:ʡ;
      
      protected var §ٌ§:int;
      
      private var §ٖ§:Boolean;
      
      protected var §١§:ʞ;
      
      public function ʏ()
      {
         super();
         this.ه = new ʡ();
      }
      
      protected function ع(param1:ʋ, param2:String, param3:Boolean = false, param4:Boolean = false) : ʋ
      {
         var _loc6_:int = 0;
         var _loc5_:ʋ = null;
         if(§٠§(COLONCOLON))
         {
            _loc5_ = ه.ۥ(null,param2);
            _loc6_ = ؽ();
            switch(_loc6_)
            {
               case NAME:
                  param2 = §١§.§׮§();
                  break;
               case MUL:
                  param2 = "*";
                  break;
               case LB:
                  param1 = ه.ۥ(param1,§ٓ§(),_loc5_,param3,param4);
                  ي(RB,"msg.no.bracket.index","k07");
                  return param1;
               default:
                  §׫§("msg.no.name.after.coloncolon","K08");
                  param2 = "?";
            }
         }
         return ه.ۥ(param1,param2,_loc5_,param3,param4);
      }
      
      protected function غ() : void
      {
         §ٖ§ = true;
         ق = §ٌ§;
         §ٌ§ = NAME;
      }
      
      private function ػ(param1:ʝ) : void
      {
         if(§٠§(RP))
         {
            return;
         }
         do
         {
            param1.ڬ(ؼ());
         }
         while(§٠§(COMMA));
         
         ي(RP,"msg.no.paren.arg","k04");
      }
      
      protected function ؼ() : ʋ
      {
         var _loc1_:ʋ = §ٜ§();
         var _loc2_:int = §ً§();
         if(FIRST_ASSIGN <= _loc2_ && _loc2_ <= LAST_ASSIGN)
         {
            §ِ§();
            §ٙ§(_loc1_);
            _loc1_ = ه.§ۨ§(_loc1_ as ʟ,ؼ(),_loc2_,§١§.ڹ());
         }
         return _loc1_;
      }
      
      protected function ؽ() : int
      {
         var _loc1_:int = §ً§();
         §ِ§();
         return _loc1_;
      }
      
      public function ؾ(param1:String) : void
      {
         throw new ʛ(null,param1,§١§.ڹ());
      }
      
      public function ؿ(param1:String) : ʋ
      {
         ك(param1);
         return §ٓ§();
      }
      
      private function ـ() : ʋ
      {
         var _loc3_:ʋ = null;
         var _loc4_:ʋ = null;
         var _loc1_:ʋ = null;
         var _loc2_:int = §١§.ھ();
         loop0:
         while(true)
         {
            _loc3_ = ه.literal(§١§.§׮§());
            switch(_loc2_)
            {
               case XML:
                  ي(LC,"msg.syntax","k02");
                  _loc1_ = ه.§۱§(_loc1_,_loc3_);
                  if(§ً§() != RC)
                  {
                     _loc4_ = §ٓ§();
                     if(§١§.ڱ())
                     {
                        _loc4_ = ه.§ۣ§(_loc4_);
                     }
                     _loc1_ = ه.§۱§(_loc1_,_loc4_);
                  }
                  ي(RC,"msg.syntax","k03");
                  break;
               case XMLEND:
                  break loop0;
               default:
                  §׫§("msg.syntax","K05");
            }
            _loc2_ = §١§.ڻ();
         }
         return ه.§۶§(_loc1_,_loc3_);
      }
      
      private function ف() : ʋ
      {
         var _loc1_:ʋ = null;
         var _loc2_:int = §ً§();
         switch(_loc2_)
         {
            case VOID:
            case NOT:
            case BITNOT:
            case TYPEOF:
            case SUB:
            case ADD:
            case INC:
            case DEC:
            case DELETE:
               §ِ§();
               _loc1_ = ف();
               if(_loc2_ == INC || _loc2_ == DEC)
               {
                  §ٙ§(_loc1_);
               }
               return ه.§ۧ§(_loc1_,_loc2_);
            case ERROR:
               §ِ§();
               §׫§("msg.syntax","K04");
               return null;
            case LT:
               §ِ§();
               return §ٚ§(true,ـ());
            default:
               _loc1_ = §٘§(true);
               _loc2_ = §َ§();
               while(_loc2_ == INC || _loc2_ == DEC)
               {
                  §ِ§();
                  _loc1_ = ه.§ۧ§(_loc1_,_loc2_ == INC?int(POSTFIX_INC):int(POSTFIX_DEC));
                  _loc2_ = §َ§();
               }
               return _loc1_;
         }
      }
      
      protected function ك(param1:String) : void
      {
         this.§١§ = new ʞ(param1);
         this.§ٌ§ = EOF;
      }
      
      private function ل() : ʋ
      {
         var _loc1_:ʋ = §ٗ§();
         var _loc2_:int = §ً§();
         loop0:
         while(true)
         {
            switch(_loc2_)
            {
               case EQ:
               case NE:
               case SHEQ:
               case SHNE:
                  §ِ§();
                  _loc1_ = ه.ۦ(_loc1_,§ٗ§(),_loc2_);
                  _loc2_ = §ً§();
                  continue;
               default:
                  break loop0;
            }
         }
         return _loc1_;
      }
      
      protected function م() : void
      {
         if((§ٌ§ & CLEAR_TI_MASK) != NAME)
         {
            ؾ("K01");
         }
         §ٌ§ = §ٌ§ | §٢§;
      }
      
      protected function ن() : int
      {
         §ً§();
         var _loc1_:int = §ٌ§;
         §ِ§();
         return _loc1_;
      }
      
      private function و() : ʋ
      {
         var _loc1_:ʋ = §ٛ§();
         var _loc2_:int = §ً§();
         loop0:
         while(true)
         {
            switch(_loc2_)
            {
               case LSH:
               case URSH:
               case RSH:
                  §ِ§();
                  _loc1_ = ه.§۵§(_loc1_,§ٛ§(),_loc2_);
                  _loc2_ = §ً§();
                  continue;
               default:
                  break loop0;
            }
         }
         return _loc1_;
      }
      
      private function ى() : ʋ
      {
         var _loc1_:ʋ = ف();
         var _loc2_:int = §ً§();
         loop0:
         while(true)
         {
            switch(_loc2_)
            {
               case MUL:
               case DIV:
               case MOD:
                  §ِ§();
                  _loc1_ = ه.§۬§(_loc1_,ف(),_loc2_);
                  _loc2_ = §ً§();
                  continue;
               default:
                  break loop0;
            }
         }
         return _loc1_;
      }
      
      protected function ي(param1:int, param2:String, param3:String) : void
      {
         if(!§٠§(param1))
         {
            §׫§(param2,param3);
         }
      }
      
      protected function §ً§() : int
      {
         if(§ٖ§)
         {
            return NAME;
         }
         var _loc1_:* = int(§ٌ§);
         if(_loc1_ == EOF)
         {
            _loc1_ = int(§١§.ہ());
            if(_loc1_ == EOL)
            {
               do
               {
                  _loc1_ = int(§١§.ہ());
               }
               while(_loc1_ == EOL);
               
               _loc1_ = _loc1_ | TI_AFTER_EOL;
            }
            §ٌ§ = _loc1_;
         }
         return _loc1_ & CLEAR_TI_MASK;
      }
      
      private function §ٍ§(param1:ʋ = null, param2:Boolean = false) : ʋ
      {
         var _loc3_:int = ؽ();
         switch(_loc3_)
         {
            case NAME:
               return ع(param1,§١§.§׮§(),true,param2);
            case MUL:
               return ع(param1,"*",true,param2);
            case LB:
               param1 = ه.ۥ(param1,§ٓ§(),null,true,param2);
               ي(RB,"msg.no.bracket.index","k68");
               return param1;
            default:
               §׫§("msg.no.name.after.xmlAttr","K69");
               return null;
         }
      }
      
      protected function §َ§() : int
      {
         var _loc1_:int = §ً§();
         if((§ٌ§ & TI_AFTER_EOL) != 0)
         {
            _loc1_ = EOL;
         }
         return _loc1_;
      }
      
      private function §ُ§() : ʋ
      {
         var _loc1_:ʋ = §ْ§();
         var _loc2_:int = §ً§();
         while(_loc2_ == BITXOR)
         {
            §ِ§();
            _loc1_ = ه.§۫§(_loc1_,§ْ§(),BITXOR);
            _loc2_ = §ً§();
         }
         return _loc1_;
      }
      
      protected function §ِ§() : void
      {
         if(§ٖ§)
         {
            §ٖ§ = false;
            §ٌ§ = ق;
            return;
         }
         §ٌ§ = EOF;
      }
      
      private function §ّ§() : ʋ
      {
         var _loc1_:ʋ = §ُ§();
         var _loc2_:int = §ً§();
         while(_loc2_ == BITOR)
         {
            §ِ§();
            _loc1_ = ه.§۫§(_loc1_,§ُ§(),BITOR);
            _loc2_ = §ً§();
         }
         return _loc1_;
      }
      
      private function §ْ§() : ʋ
      {
         var _loc1_:ʋ = ل();
         var _loc2_:int = §ً§();
         while(_loc2_ == BITAND)
         {
            §ِ§();
            _loc1_ = ه.§۫§(_loc1_,ل(),BITAND);
            _loc2_ = §ً§();
         }
         return _loc1_;
      }
      
      protected function §ٓ§() : ʋ
      {
         var _loc1_:ʋ = ؼ();
         while(§٠§(COMMA))
         {
            _loc1_ = ه.§۷§(_loc1_,ؼ());
         }
         return _loc1_;
      }
      
      protected function §ٔ§(param1:Boolean = false) : ʌ
      {
         §׫§("msg.function.expr.not.supported","K09");
         return null;
      }
      
      private function §ٕ§() : ʋ
      {
         var _loc3_:int = 0;
         var _loc4_:* = false;
         var _loc1_:ʋ = §ّ§();
         var _loc2_:int = §ً§();
         if(_loc2_ == AND || _loc2_ == NAND)
         {
            _loc3_ = _loc2_;
            _loc4_ = _loc2_ == NAND;
            while(_loc2_ == _loc3_)
            {
               §ِ§();
               _loc1_ = ه.§ۤ§(_loc1_,§ٕ§(),true,_loc4_);
               _loc2_ = §ً§();
            }
         }
         return _loc1_;
      }
      
      private function §ٗ§() : ʋ
      {
         var _loc1_:ʋ = و();
         var _loc2_:int = §ً§();
         loop0:
         while(true)
         {
            switch(_loc2_)
            {
               case IS:
               case INSTANCEOF:
               case IN:
               case AS:
                  break loop0;
               case LE:
               case LT:
               case GE:
               case GT:
                  §ِ§();
                  _loc1_ = ه.ۦ(_loc1_,و(),_loc2_);
                  _loc2_ = §ً§();
                  continue;
               default:
                  addr88:
                  return _loc1_;
            }
         }
         §ِ§();
         _loc1_ = ه.ۮ(_loc1_,و(),_loc2_);
         §§goto(addr88);
      }
      
      private function §٘§(param1:Boolean) : ʋ
      {
         var _loc2_:ʋ = null;
         if(§ً§() == NEW)
         {
            §ِ§();
            _loc2_ = ه.§۳§(§٘§(false));
            if(§٠§(LP))
            {
               ػ(_loc2_ as ʝ);
            }
         }
         else
         {
            _loc2_ = §ٞ§();
         }
         return §ٚ§(param1,_loc2_);
      }
      
      private function §ٙ§(param1:*) : void
      {
         if(!(param1 is ʟ))
         {
            §׫§("msg.not.assignable","K03");
         }
      }
      
      public function §׫§(param1:String, param2:String, param3:String = null, param4:String = null, param5:String = null) : void
      {
         throw new ʛ(ʉ.ף(param1,param3,param4,param5),param2,§١§.ڹ());
      }
      
      private function §ٚ§(param1:Boolean, param2:ʋ) : ʋ
      {
         var _loc3_:int = 0;
         var _loc4_:* = false;
         loop0:
         while(true)
         {
            _loc3_ = §ً§();
            switch(_loc3_)
            {
               case DOT:
               case DOTDOT:
                  §ِ§();
                  _loc4_ = _loc3_ == DOTDOT;
                  _loc3_ = ؽ();
                  switch(_loc3_)
                  {
                     case NAME:
                        param2 = ع(param2,§١§.§׮§(),_loc4_);
                        continue;
                     case MUL:
                        param2 = ع(param2,"*",_loc4_);
                        continue;
                     case XMLATTR:
                        param2 = §ٍ§(param2,_loc4_);
                        continue;
                     default:
                        §׫§("msg.no.name.after.dot","K06");
                        continue;
                  }
               case DOTQUERY:
                  §ِ§();
                  param2 = ه.§۩§(param2,§ٓ§());
                  ي(RP,"msg.no.paren","k05");
                  continue;
               case LB:
                  §ِ§();
                  param2 = ه.ۥ(param2,§ٓ§());
                  ي(RB,"msg.no.bracket.index","k06");
                  continue;
               case LP:
                  if(!param1)
                  {
                     addr158:
                     return param2;
                  }
                  §ِ§();
                  param2 = ه.§۰§(param2);
                  ػ(param2 as ʝ);
                  continue;
               default:
                  break loop0;
            }
         }
         §§goto(addr158);
      }
      
      private function §ٛ§() : ʋ
      {
         var _loc1_:ʋ = ى();
         var _loc2_:int = §ً§();
         while(_loc2_ == ADD || _loc2_ == SUB)
         {
            §ِ§();
            _loc1_ = ه.§۱§(_loc1_,ى(),_loc2_ == ADD);
            _loc2_ = §ً§();
         }
         return _loc1_;
      }
      
      private function §ٜ§() : ʋ
      {
         var _loc2_:ʋ = null;
         var _loc1_:ʋ = §ٝ§();
         if(§٠§(HOOK))
         {
            _loc2_ = ؼ();
            ي(COLON,"msg.no.colon.cond","k01");
            _loc1_ = ه.§۴§(_loc1_,_loc2_,ؼ());
         }
         return _loc1_;
      }
      
      private function §ٝ§() : ʋ
      {
         var _loc3_:int = 0;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc1_:ʋ = §ٕ§();
         var _loc2_:int = §ً§();
         if(_loc2_ == OR || _loc2_ == NOR || _loc2_ == XOR)
         {
            _loc3_ = _loc2_;
            _loc4_ = _loc2_ == NOR;
            _loc5_ = _loc2_ == XOR;
            while(_loc2_ == _loc3_)
            {
               §ِ§();
               _loc1_ = ه.§ۤ§(_loc1_,§ٝ§(),false,_loc4_,_loc5_);
               _loc2_ = §ً§();
            }
         }
         return _loc1_;
      }
      
      private function §ٞ§() : ʋ
      {
         var _loc2_:ʋ = null;
         var _loc3_:Array = null;
         var _loc6_:Boolean = false;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:* = undefined;
         var _loc1_:Boolean = true;
         var _loc4_:int = ن();
         var _loc5_:* = _loc4_ & CLEAR_TI_MASK;
         switch(_loc5_)
         {
            case FUNCTION:
               return §ٔ§(true);
            case LB:
               _loc3_ = [];
               _loc6_ = true;
               while(true)
               {
                  _loc5_ = int(§ً§());
                  if(_loc5_ == COMMA)
                  {
                     §ِ§();
                     if(!_loc6_)
                     {
                        _loc6_ = true;
                     }
                     else
                     {
                        _loc3_.push(ʠ.NULL);
                     }
                  }
                  else
                  {
                     if(_loc5_ == RB)
                     {
                        break;
                     }
                     if(!_loc6_)
                     {
                        §׫§("msg.no.bracket.arg","K10");
                     }
                     _loc6_ = false;
                     _loc2_ = ؼ();
                     if(_loc2_ is ʠ)
                     {
                        _loc3_.push((_loc2_ as ʠ).getAny());
                     }
                     else
                     {
                        _loc3_.push(_loc2_);
                        _loc1_ = false;
                     }
                  }
               }
               §ِ§();
               return ه.§۪§(_loc3_,_loc1_);
            case LC:
               _loc7_ = {};
               _loc3_ = [];
               if(!§٠§(LC))
               {
                  loop1:
                  do
                  {
                     _loc5_ = int(§ً§());
                     switch(_loc5_)
                     {
                        case NAME:
                        case STRING:
                           §ِ§();
                           _loc10_ = §١§.§׮§();
                           _loc3_.push(_loc10_);
                           break;
                        case NUMBER:
                           §ِ§();
                           _loc10_ = §١§.getNumber();
                           _loc3_.push(_loc10_);
                           break;
                        case RC:
                           break loop1;
                        default:
                           §׫§("msg.bad.prop","K11");
                           break loop1;
                     }
                     ي(COLON,"msg.no.colon.prop","k08");
                     _loc2_ = ؼ();
                     if(_loc2_ is ʠ)
                     {
                        _loc7_[_loc10_] = (_loc2_ as ʠ).getAny();
                     }
                     else
                     {
                        _loc7_[_loc10_] = _loc2_;
                        _loc1_ = false;
                     }
                  }
                  while(§٠§(COMMA));
                  
                  ي(RC,"msg.no.brace.prop","k09");
               }
               return ه.§۪§(_loc7_,_loc1_,_loc3_);
            case LP:
               _loc2_ = §ٓ§();
               ي(RP,"msg.no.paren","k10");
               return _loc2_;
            case XMLATTR:
               return §ٍ§();
            case NAME:
               _loc8_ = §١§.§׮§();
               if((_loc4_ & §٢§) != 0 && §ً§() == COLON)
               {
                  §ِ§();
                  return new ʢ(_loc8_);
               }
               return ع(null,_loc8_);
            case THIS:
               §ِ§();
               return ه.ۯ();
            case NULL:
               return ه.literal(null);
            case FALSE:
               return ه.literal(false);
            case TRUE:
               return ه.literal(true);
            case NUMBER:
               return ه.literal(§١§.getNumber());
            case STRING:
               return ه.literal(§١§.§׮§());
            case DIV:
            case ASSIGN_DIV:
               §١§.ڸ(_loc5_);
               _loc9_ = §١§.ڷ;
               §١§.ڷ = null;
               return ه.§۲§(§١§.§׮§(),_loc9_);
            case RESERVED:
               §׫§("msg.reserved.id","K12");
               break;
            case EOF:
               §׫§("msg.unexpected.eof","K13");
               break;
            case ERROR:
            default:
               §׫§("msg.syntax","K14");
         }
         return null;
      }
      
      protected function §ٟ§() : int
      {
         §ً§();
         return §ٌ§;
      }
      
      protected function §٠§(param1:int) : Boolean
      {
         var _loc2_:int = §ً§();
         if(_loc2_ != param1)
         {
            return false;
         }
         §ِ§();
         return true;
      }
      
      protected function eof() : Boolean
      {
         return §١§.eof();
      }
   }
}
