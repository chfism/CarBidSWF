package r1.deval.parser
{
   import ʊ.ʉ;
   import ʯ.ʮ;
   
   class ʞ extends ʎ
   {
       
      
      private var ڮ:Boolean;
      
      private var ڰ:String;
      
      private var string:String = "";
      
      var ڷ:String;
      
      private var ں:ʮ;
      
      private var ڠ:int;
      
      private var ڿ:int = -1;
      
      private var ۀ:int;
      
      private var ۂ:Array;
      
      private var number:Number;
      
      private var ۃ:int = 0;
      
      private var ۅ:int;
      
      private var ۆ:int;
      
      private var ۊ:Boolean;
      
      private var ۋ:Boolean = false;
      
      private var ی:String;
      
      private var ۍ:int;
      
      private var ې:Boolean;
      
      function ʞ(param1:String, param2:int = 1)
      {
         super();
         this.ڠ = param2;
         this.ں = new ʮ();
         this.ۂ = new Array(3);
         this.ڰ = param1;
         this.ۀ = param1.length;
         this.ۅ = 0;
      }
      
      private static function ے(param1:int) : Boolean
      {
         return CHAR_0 <= param1 && param1 <= CHAR_9;
      }
      
      private static function ۓ(param1:int) : Boolean
      {
         return ە(param1) || param1 >= CHAR_0 && param1 <= CHAR_9;
      }
      
      private static function ؾ() : void
      {
         ʉ.§׫§(ʛ.ک,"KT");
      }
      
      private static function ם(param1:String, param2:* = null, param3:* = null, param4:* = null) : void
      {
         ʉ.ם(param1,param2,param3,param4);
      }
      
      private static function §۔§(param1:int) : Boolean
      {
         if((param1 & 57296) != 0)
         {
            return false;
         }
         return param1 == CHAR_NL || param1 == CHAR_CR || param1 == 8232 || param1 == 8233;
      }
      
      private static function ە(param1:int) : Boolean
      {
         return param1 >= CHAR_a && param1 <= CHAR_z || param1 >= CHAR_A && param1 <= CHAR_Z || param1 == CHAR_UNDERSCORE;
      }
      
      private static function §ۖ§(param1:int) : Boolean
      {
         return param1 == 32 || param1 == 9 || param1 == 12 || param1 == 11 || param1 == 160;
      }
      
      private static function §ۗ§(param1:int) : Boolean
      {
         if(param1 <= CHAR_Z)
         {
            return CHAR_A <= param1;
         }
         return CHAR_a <= param1 && param1 <= CHAR_z;
      }
      
      private static function §ۘ§(param1:int, param2:int) : int
      {
         return param2 << 3 | param1 - CHAR_0;
      }
      
      private static function §ۙ§(param1:int, param2:int) : int
      {
         if(param1 <= CHAR_9)
         {
            param1 = param1 - CHAR_0;
            if(0 <= param1)
            {
               addr44:
               return param2 << 4 | param1;
            }
         }
         else if(param1 <= CHAR_F)
         {
            if(CHAR_A <= param1)
            {
               param1 = param1 - (CHAR_A - 10);
               §§goto(addr44);
            }
         }
         else if(param1 <= CHAR_f)
         {
            if(CHAR_a <= param1)
            {
               param1 = param1 - (CHAR_a - 10);
               §§goto(addr44);
            }
         }
         return -1;
      }
      
      private static function §׫§(param1:String) : void
      {
         ʉ.§׫§(param1,"KT");
      }
      
      private static function §ۚ§(param1:String) : int
      {
         var _loc3_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = param1.length;
         if(_loc4_ >= 2)
         {
            _loc5_ = param1.charCodeAt(0);
            _loc6_ = param1.charCodeAt(1);
            loop0:
            switch(_loc4_)
            {
               case 2:
                  switch(_loc5_)
                  {
                     case CHAR_a:
                        if(_loc6_ == CHAR_s)
                        {
                           return AS;
                        }
                        break loop0;
                     case CHAR_i:
                        switch(_loc6_)
                        {
                           case CHAR_f:
                              return IF;
                           case CHAR_n:
                              return IN;
                           case CHAR_s:
                              return IS;
                           default:
                              break loop0;
                        }
                     case CHAR_d:
                        if(param1.charCodeAt(1) == CHAR_o)
                        {
                           return DO;
                        }
                        break loop0;
                     case CHAR_o:
                        if(param1.charCodeAt(1) == CHAR_r)
                        {
                           return OR;
                        }
                        break loop0;
                     default:
                        break loop0;
                  }
               case 3:
                  switch(_loc5_)
                  {
                     case CHAR_a:
                        _loc3_ = "and";
                        _loc2_ = AND;
                        break loop0;
                     case CHAR_f:
                        _loc3_ = "for";
                        _loc2_ = FOR;
                        break loop0;
                     case CHAR_n:
                        if(param1 == "new")
                        {
                           return NEW;
                        }
                        if(param1 == "nor")
                        {
                           return NOR;
                        }
                        if(param1 == "not")
                        {
                           return NOT;
                        }
                        break loop0;
                     case CHAR_t:
                        _loc3_ = "try";
                        _loc2_ = TRY;
                        break loop0;
                     case CHAR_v:
                        _loc3_ = "var";
                        _loc2_ = VAR;
                        break loop0;
                     case CHAR_x:
                        _loc3_ = "xor";
                        _loc2_ = XOR;
                        break loop0;
                     default:
                        break loop0;
                  }
               case 4:
                  switch(_loc5_)
                  {
                     case CHAR_c:
                        _loc3_ = "case";
                        _loc2_ = CASE;
                        break loop0;
                     case CHAR_e:
                        _loc3_ = "else";
                        _loc2_ = ELSE;
                        break loop0;
                     case CHAR_n:
                        if(param1 == "null")
                        {
                           return NULL;
                        }
                        if(param1 == "nand")
                        {
                           return NAND;
                        }
                        break loop0;
                     case CHAR_t:
                        if(param1 == "true")
                        {
                           return TRUE;
                        }
                        if(param1 == "this")
                        {
                           return THIS;
                        }
                        break loop0;
                     case CHAR_v:
                        _loc3_ = "void";
                        _loc2_ = VOID;
                        break loop0;
                     case CHAR_w:
                        _loc3_ = "with";
                        _loc2_ = WITH;
                        break loop0;
                     default:
                        break loop0;
                  }
               case 5:
                  switch(param1.charCodeAt(2))
                  {
                     case CHAR_a:
                        _loc3_ = "class";
                        _loc2_ = CLASS;
                        break loop0;
                     case CHAR_e:
                        _loc3_ = "break";
                        _loc2_ = BREAK;
                        break loop0;
                     case CHAR_i:
                        _loc3_ = "while";
                        _loc2_ = WHILE;
                        break loop0;
                     case CHAR_l:
                        _loc3_ = "false";
                        _loc2_ = FALSE;
                        break loop0;
                     case CHAR_r:
                        _loc3_ = "throw";
                        _loc2_ = THROW;
                        break loop0;
                     case CHAR_t:
                        _loc3_ = "catch";
                        _loc2_ = CATCH;
                        break loop0;
                     default:
                        break loop0;
                  }
               case 6:
                  switch(_loc5_)
                  {
                     case CHAR_d:
                        _loc3_ = "delete";
                        _loc2_ = DELETE;
                        break loop0;
                     case CHAR_r:
                        _loc3_ = "return";
                        _loc2_ = RETURN;
                        break loop0;
                     case CHAR_i:
                        _loc3_ = "import";
                        _loc2_ = IMPORT;
                        break loop0;
                     case CHAR_s:
                        _loc3_ = "switch";
                        _loc2_ = SWITCH;
                        break loop0;
                     case CHAR_t:
                        _loc3_ = "typeof";
                        _loc2_ = TYPEOF;
                        break loop0;
                     default:
                        break loop0;
                  }
               case 7:
                  switch(_loc6_)
                  {
                     case CHAR_e:
                        _loc3_ = "default";
                        _loc2_ = DEFAULT;
                        break loop0;
                     case CHAR_i:
                        _loc3_ = "finally";
                        _loc2_ = FINALLY;
                        break loop0;
                     default:
                        break loop0;
                  }
               case 8:
                  switch(_loc5_)
                  {
                     case CHAR_c:
                        _loc3_ = "continue";
                        _loc2_ = CONTINUE;
                        break loop0;
                     case CHAR_f:
                        _loc3_ = "function";
                        _loc2_ = FUNCTION;
                        break loop0;
                     default:
                        break loop0;
                  }
               case 10:
                  if(param1 == "instanceof")
                  {
                     return INSTANCEOF;
                  }
            }
            if(_loc3_ != null && _loc3_ != param1)
            {
               _loc2_ = 0;
            }
         }
         return _loc2_ == 0?int(EOF):_loc2_ & 255;
      }
      
      private static function §ۛ§(param1:String) : Boolean
      {
         return EOF != §ۚ§(param1);
      }
      
      public final function گ() : int
      {
         var _loc1_:int = ۅ - ۃ;
         if(ڿ >= 0)
         {
            _loc1_--;
         }
         return _loc1_;
      }
      
      public final function §׮§() : String
      {
         return string;
      }
      
      public function ڱ() : Boolean
      {
         return ې;
      }
      
      public function ڲ(param1:int) : void
      {
         if(ۆ != 0 && ۂ[ۆ - 1] == CHAR_NL)
         {
            ؾ();
         }
         var _loc2_:* = ۆ++;
         ۂ[_loc2_] = param1;
      }
      
      public function ڳ() : Boolean
      {
         var _loc1_:int = ۉ();
         while(_loc1_ != CHAR_EOF)
         {
            ڼ(_loc1_);
            if(_loc1_ == CHAR_QUESTION && ۈ() == CHAR_GT)
            {
               _loc1_ = ۉ();
               ڼ(_loc1_);
               return true;
            }
            _loc1_ = ۉ();
         }
         ں.clear();
         this.string = null;
         §׫§("msg.XML.bad.form");
         return false;
      }
      
      private function ڴ() : Boolean
      {
         var _loc1_:int = ۉ();
         while(_loc1_ != CHAR_EOF)
         {
            ڼ(_loc1_);
            if(_loc1_ == CHAR_RBRACKET && ۈ() == CHAR_RBRACKET)
            {
               _loc1_ = ۉ();
               ڼ(_loc1_);
               if(ۈ() == CHAR_GT)
               {
                  _loc1_ = ۉ();
                  ڼ(_loc1_);
                  return true;
               }
            }
            else
            {
               _loc1_ = ۉ();
            }
         }
         ں.clear();
         this.string = null;
         §׫§("msg.XML.bad.form");
         return false;
      }
      
      private function ڵ() : Boolean
      {
         var _loc1_:int = 1;
         var _loc2_:int = ۉ();
         while(_loc2_ != CHAR_EOF)
         {
            ڼ(_loc2_);
            switch(_loc2_)
            {
               case CHAR_LT:
                  _loc1_++;
                  break;
               case CHAR_GT:
                  _loc1_--;
                  if(_loc1_ == 0)
                  {
                     return true;
                  }
                  break;
            }
            _loc2_ = ۉ();
         }
         ں.clear();
         this.string = null;
         §׫§("msg.XML.bad.form");
         return false;
      }
      
      public function ڶ() : void
      {
         var _loc1_:int = 0;
         while((_loc1_ = ۉ()) != CHAR_EOF && _loc1_ != CHAR_NL)
         {
         }
         ڲ(_loc1_);
      }
      
      public function ڸ(param1:int) : void
      {
         var _loc2_:int = 0;
         ں.clear();
         if(param1 == ASSIGN_DIV)
         {
            ڼ(CHAR_EQUAL);
         }
         else if(param1 != DIV)
         {
            ؾ();
         }
         while((_loc2_ = ۉ()) != CHAR_SLASH)
         {
            if(_loc2_ == CHAR_NL || _loc2_ == CHAR_EOF)
            {
               ڲ(_loc2_);
               §׫§("msg.unterminated.re.lit");
            }
            if(_loc2_ == CHAR_BACKSLASH)
            {
               ڼ(_loc2_);
               _loc2_ = ۉ();
            }
            ڼ(_loc2_);
         }
         var _loc3_:int = ں.length;
         while(true)
         {
            if(ڽ(CHAR_g))
            {
               ڼ(CHAR_g);
               continue;
            }
            if(ڽ(CHAR_i))
            {
               ڼ(CHAR_i);
               continue;
            }
            if(ڽ(CHAR_m))
            {
               ڼ(CHAR_m);
               continue;
            }
            break;
         }
         if(§ۗ§(ۈ()))
         {
            §׫§("msg.invalid.re.flag");
         }
         this.string = ں.substring(0,_loc3_);
         this.ڷ = ں.substr(_loc3_,ں.length - _loc3_);
      }
      
      public final function ڹ() : int
      {
         return ڠ;
      }
      
      public function ڻ() : int
      {
         ں.clear();
         var _loc1_:int = ۉ();
         while(true)
         {
            if(_loc1_ == CHAR_EOF)
            {
               ں.clear();
               this.string = null;
               §׫§("msg.XML.bad.form");
               return ERROR;
            }
            if(ڮ)
            {
               switch(_loc1_)
               {
                  case CHAR_GT:
                     ڼ(_loc1_);
                     ڮ = false;
                     ې = false;
                     break;
                  case CHAR_SLASH:
                     ڼ(_loc1_);
                     if(ۈ() == CHAR_GT)
                     {
                        _loc1_ = ۉ();
                        ڼ(_loc1_);
                        ڮ = false;
                        ۍ--;
                        break;
                     }
                     break;
                  case CHAR_LBRACE:
                     ڲ(_loc1_);
                     this.string = ێ();
                     return XML;
                  case CHAR_QUOTE:
                  case CHAR_DOUBLEQUOTE:
                     ڼ(_loc1_);
                     if(!ۄ(_loc1_))
                     {
                        return ERROR;
                     }
                     break;
                  case CHAR_EQUAL:
                     ڼ(_loc1_);
                     ې = true;
                     break;
                  case CHAR_SPACE:
                  case CHAR_TAB:
                  case CHAR_CR:
                  case CHAR_NL:
                     ڼ(_loc1_);
                     break;
                  default:
                     ڼ(_loc1_);
                     ې = false;
               }
               if(!ڮ && ۍ == 0)
               {
                  break;
               }
            }
            else
            {
               loop2:
               switch(_loc1_)
               {
                  case CHAR_LT:
                     ڼ(_loc1_);
                     _loc1_ = ۈ();
                     switch(_loc1_)
                     {
                        case CHAR_BAN:
                           _loc1_ = ۉ();
                           ڼ(_loc1_);
                           _loc1_ = ۈ();
                           switch(_loc1_)
                           {
                              case CHAR_DASH:
                                 _loc1_ = ۉ();
                                 ڼ(_loc1_);
                                 _loc1_ = ۉ();
                                 if(_loc1_ == CHAR_DASH)
                                 {
                                    ڼ(_loc1_);
                                    if(!ۑ())
                                    {
                                       return ERROR;
                                    }
                                    break loop2;
                                 }
                                 ں.clear();
                                 this.string = null;
                                 §׫§("msg.XML.bad.form");
                                 return ERROR;
                              case CHAR_LBRACKET:
                                 _loc1_ = ۉ();
                                 ڼ(_loc1_);
                                 if(ۉ() == CHAR_C && ۉ() == CHAR_D && ۉ() == CHAR_A && ۉ() == CHAR_T && ۉ() == CHAR_A && ۉ() == CHAR_LBRACKET)
                                 {
                                    ڼ("CDATA[");
                                    if(!ڴ())
                                    {
                                       return ERROR;
                                    }
                                    break loop2;
                                 }
                                 ں.clear();
                                 this.string = null;
                                 §׫§("msg.XML.bad.form");
                                 return ERROR;
                              default:
                                 if(!ڵ())
                                 {
                                    return ERROR;
                                 }
                                 break loop2;
                           }
                        case CHAR_QUESTION:
                           _loc1_ = ۉ();
                           ڼ(_loc1_);
                           if(!ڳ())
                           {
                              return ERROR;
                           }
                           break loop2;
                        case CHAR_SLASH:
                           _loc1_ = ۉ();
                           ڼ(_loc1_);
                           if(ۍ == 0)
                           {
                              ں.clear();
                              this.string = null;
                              §׫§("msg.XML.bad.form");
                              return ERROR;
                           }
                           ڮ = true;
                           ۍ--;
                           break loop2;
                        default:
                           ڮ = true;
                           ۍ++;
                           break loop2;
                     }
                  case CHAR_LBRACE:
                     ڲ(_loc1_);
                     this.string = ێ();
                     return XML;
                  default:
                     ڼ(_loc1_);
               }
            }
            _loc1_ = ۉ();
         }
         this.string = ێ();
         return XMLEND;
      }
      
      public function ڼ(param1:*) : void
      {
         if(param1 is String)
         {
            ں.ܖ(param1);
         }
         else
         {
            ں.ܖ(String.fromCharCode(int(param1)));
         }
      }
      
      public function ڽ(param1:int) : Boolean
      {
         var _loc2_:int = ۉ();
         if(_loc2_ == param1)
         {
            return true;
         }
         ڲ(_loc2_);
         return false;
      }
      
      public function ھ() : int
      {
         ۍ = 0;
         ې = false;
         ڮ = false;
         ڲ(CHAR_LT);
         return ڻ();
      }
      
      public final function getNumber() : Number
      {
         return number;
      }
      
      public final function ہ() : int
      {
         var c:int = 0;
         var ޤ:Boolean = false;
         var ޟ:Boolean = false;
         var ޞ:Boolean = false;
         var ޡ:String = null;
         var ޠ:int = 0;
         var i:int = 0;
         var ח:int = 0;
         var base:int = 0;
         var ޣ:Boolean = false;
         var §ަ§:String = null;
         var ޥ:Number = NaN;
         var ޢ:Boolean = false;
         loop0:
         while(true)
         {
            while(true)
            {
               c = ۉ();
               if(c == CHAR_EOF)
               {
                  break;
               }
               if(c == CHAR_NL)
               {
                  ۊ = false;
                  return EOL;
               }
               if(!§ۖ§(c))
               {
                  if(c != CHAR_DASH)
                  {
                     ۊ = true;
                  }
                  if(c == CHAR_AT)
                  {
                     return XMLATTR;
                  }
                  ޟ = false;
                  if(c == CHAR_BACKSLASH)
                  {
                     c = ۉ();
                     if(c == CHAR_u)
                     {
                        ޤ = true;
                        ޟ = true;
                        ں.clear();
                     }
                     else
                     {
                        ޤ = false;
                        ڲ(c);
                        c = CHAR_BACKSLASH;
                     }
                  }
                  else
                  {
                     ޤ = ە(c);
                     if(ޤ)
                     {
                        ں.clear();
                        ڼ(c);
                     }
                  }
                  if(ޤ)
                  {
                     ޞ = ޟ;
                     while(true)
                     {
                        if(ޟ)
                        {
                           ޠ = 0;
                           i = 0;
                           while(i != 4)
                           {
                              c = ۉ();
                              ޠ = §ۙ§(c,ޠ);
                              if(ޠ < 0)
                              {
                                 break;
                              }
                              i++;
                           }
                           if(ޠ < 0)
                           {
                              break;
                           }
                           ڼ(ޠ);
                           ޟ = false;
                        }
                        else
                        {
                           c = ۉ();
                           if(c == CHAR_BACKSLASH)
                           {
                              c = ۉ();
                              if(c == CHAR_u)
                              {
                                 ޟ = true;
                                 ޞ = true;
                                 continue;
                              }
                              §׫§("msg.illegal.character");
                              return ERROR;
                           }
                           if(c == CHAR_EOF || !ۓ(c))
                           {
                              ڲ(c);
                              ޡ = ێ();
                              if(!ޞ)
                              {
                                 ח = §ۚ§(ޡ);
                                 if(ח != EOF)
                                 {
                                    if(ח != RESERVED)
                                    {
                                       return ח;
                                    }
                                    ם("msg.reserved.keyword",ޡ);
                                 }
                              }
                              this.string = ޡ;
                              return NAME;
                           }
                           ڼ(c);
                        }
                     }
                     §׫§("msg.invalid.escape");
                     return ERROR;
                  }
                  if(ے(c) || c == CHAR_DOT && ے(ۈ()))
                  {
                     ں.clear();
                     base = 10;
                     if(c == CHAR_0)
                     {
                        c = ۉ();
                        if(c == CHAR_x || c == CHAR_X)
                        {
                           base = 16;
                           c = ۉ();
                        }
                        else if(ے(c))
                        {
                           base = 8;
                        }
                        else
                        {
                           ڼ(CHAR_0);
                        }
                     }
                     if(base == 16)
                     {
                        while(0 <= §ۙ§(c,0))
                        {
                           ڼ(c);
                           c = ۉ();
                        }
                     }
                     else
                     {
                        while(CHAR_0 <= c && c <= CHAR_9)
                        {
                           if(base == 8 && c >= CHAR_8)
                           {
                              ם("msg.bad.octal.literal",c == CHAR_8?"8":"9");
                              base = 10;
                           }
                           ڼ(c);
                           c = ۉ();
                        }
                     }
                     ޣ = true;
                     if(base == 10 && (c == CHAR_DOT || c == CHAR_e || c == CHAR_E))
                     {
                        ޣ = false;
                        if(c == CHAR_DOT)
                        {
                           do
                           {
                              ڼ(c);
                              c = ۉ();
                           }
                           while(ے(c));
                           
                        }
                        if(c == CHAR_e || c == CHAR_E)
                        {
                           ڼ(c);
                           c = ۉ();
                           if(c == CHAR_PLUS || c == CHAR_DASH)
                           {
                              ڼ(c);
                              c = ۉ();
                           }
                           if(!ے(c))
                           {
                              §׫§("msg.missing.exponent");
                              return ERROR;
                           }
                           do
                           {
                              ڼ(c);
                              c = ۉ();
                           }
                           while(ے(c));
                           
                        }
                     }
                     ڲ(c);
                     §ަ§ = ێ();
                     if(base == 10 && !ޣ)
                     {
                        try
                        {
                           ޥ = Number(§ަ§);
                        }
                        catch(error:Error)
                        {
                           §׫§("msg.caught.nfe");
                           return ERROR;
                        }
                     }
                     else
                     {
                        ޥ = ۇ(§ަ§,base);
                     }
                     this.number = ޥ;
                     return NUMBER;
                  }
                  switch(c)
                  {
                     case CHAR_DOUBLEQUOTE:
                     case CHAR_QUOTE:
                        break loop0;
                     case CHAR_SEMICOLON:
                        return SEMI;
                     case CHAR_LBRACKET:
                        return LB;
                     case CHAR_RBRACKET:
                        return RB;
                     case CHAR_LBRACE:
                        return LC;
                     case CHAR_RBRACE:
                        return RC;
                     case CHAR_LPAREN:
                        return LP;
                     case CHAR_RPAREN:
                        return RP;
                     case CHAR_COMMA:
                        return COMMA;
                     case CHAR_QUESTION:
                        return HOOK;
                     case CHAR_TILDA:
                        return BITNOT;
                     case CHAR_COLON:
                        return !!ڽ(CHAR_COLON)?int(COLONCOLON):int(COLON);
                     case CHAR_DOT:
                        if(ڽ(CHAR_DOT))
                        {
                           return DOTDOT;
                        }
                        return !!ڽ(CHAR_LPAREN)?int(DOTQUERY):int(DOT);
                     case CHAR_PIPE:
                        if(ڽ(CHAR_PIPE))
                        {
                           return !!ڽ(CHAR_EQUAL)?int(ASSIGN_OR):int(OR);
                        }
                        return !!ڽ(CHAR_EQUAL)?int(ASSIGN_BITOR):int(BITOR);
                     case CHAR_CARET:
                        return !!ڽ(CHAR_EQUAL)?int(ASSIGN_BITXOR):int(BITXOR);
                     case CHAR_AMPERSAND:
                        if(ڽ(CHAR_AMPERSAND))
                        {
                           return !!ڽ(CHAR_EQUAL)?int(ASSIGN_AND):int(AND);
                        }
                        return !!ڽ(CHAR_EQUAL)?int(ASSIGN_BITAND):int(BITAND);
                     case CHAR_EQUAL:
                        if(ڽ(CHAR_EQUAL))
                        {
                           return !!ڽ(CHAR_EQUAL)?int(SHEQ):int(EQ);
                        }
                        return ASSIGN;
                     case CHAR_BAN:
                        if(ڽ(CHAR_EQUAL))
                        {
                           return !!ڽ(CHAR_EQUAL)?int(SHNE):int(NE);
                        }
                        return NOT;
                     case CHAR_LT:
                        if(ڽ(CHAR_BAN))
                        {
                           if(ڽ(CHAR_DASH))
                           {
                              if(ڽ(CHAR_DASH))
                              {
                                 ڶ();
                                 continue loop0;
                              }
                              ڲ(CHAR_DASH);
                           }
                           ڲ(CHAR_BAN);
                        }
                        if(ڽ(CHAR_LT))
                        {
                           return !!ڽ(CHAR_EQUAL)?int(ASSIGN_LSH):int(LSH);
                        }
                        return !!ڽ(CHAR_EQUAL)?int(LE):int(LT);
                     case CHAR_GT:
                        if(ڽ(CHAR_GT))
                        {
                           if(ڽ(CHAR_GT))
                           {
                              return !!ڽ(CHAR_EQUAL)?int(ASSIGN_URSH):int(URSH);
                           }
                           return !!ڽ(CHAR_EQUAL)?int(ASSIGN_RSH):int(RSH);
                        }
                        return !!ڽ(CHAR_EQUAL)?int(GE):int(GT);
                     case CHAR_STAR:
                        return !!ڽ(CHAR_EQUAL)?int(ASSIGN_MUL):int(MUL);
                     case CHAR_SLASH:
                        if(ڽ(CHAR_SLASH))
                        {
                           ڶ();
                           continue loop0;
                        }
                        if(ڽ(CHAR_STAR))
                        {
                           ޢ = false;
                           while(true)
                           {
                              c = ۉ();
                              if(c == CHAR_EOF)
                              {
                                 break;
                              }
                              if(c == CHAR_STAR)
                              {
                                 ޢ = true;
                              }
                              else if(c == CHAR_SLASH)
                              {
                                 if(ޢ)
                                 {
                                    continue loop0;
                                 }
                              }
                              else
                              {
                                 ޢ = false;
                              }
                           }
                           §׫§("msg.unterminated.comment");
                           return ERROR;
                        }
                        return !!ڽ(CHAR_EQUAL)?int(ASSIGN_DIV):int(DIV);
                     case CHAR_PERCENT:
                        return !!ڽ(CHAR_EQUAL)?int(ASSIGN_MOD):int(MOD);
                     case CHAR_PLUS:
                        if(ڽ(CHAR_EQUAL))
                        {
                           return ASSIGN_ADD;
                        }
                        return !!ڽ(CHAR_PLUS)?int(INC):int(ADD);
                     case CHAR_DASH:
                        if(ڽ(CHAR_EQUAL))
                        {
                           c = ASSIGN_SUB;
                        }
                        else if(ڽ(CHAR_DASH))
                        {
                           if(!ۊ)
                           {
                              if(ڽ(CHAR_GT))
                              {
                                 ڶ();
                                 continue loop0;
                              }
                           }
                           c = DEC;
                        }
                        else
                        {
                           c = SUB;
                        }
                        ۊ = true;
                        return c;
                     default:
                        §׫§("msg.illegal.character");
                        return ERROR;
                  }
               }
               else
               {
                  continue;
               }
            }
            return EOF;
         }
         return readString(c);
      }
      
      private function readString(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         ں.clear();
         var _loc3_:int = ۉ();
         loop0:
         while(_loc3_ != param1)
         {
            if(_loc3_ == CHAR_NL || _loc3_ == CHAR_EOF)
            {
               ڲ(_loc3_);
               §׫§("msg.unterminated.string.lit");
               return ERROR;
            }
            if(_loc3_ == CHAR_BACKSLASH)
            {
               _loc3_ = ۉ();
               switch(_loc3_)
               {
                  case CHAR_b:
                     _loc3_ = CHAR_BACKSLASH;
                     break;
                  case CHAR_f:
                     _loc3_ = CHAR_FEED;
                     break;
                  case CHAR_n:
                     _loc3_ = CHAR_NL;
                     break;
                  case CHAR_r:
                     _loc3_ = CHAR_CR;
                     break;
                  case CHAR_t:
                     _loc3_ = CHAR_TAB;
                     break;
                  case CHAR_v:
                     _loc3_ = 11;
                     break;
                  case CHAR_u:
                     _loc4_ = ں.length;
                     _loc5_ = "u";
                     _loc2_ = 0;
                     _loc6_ = 0;
                     while(_loc6_ != 4)
                     {
                        _loc3_ = ۉ();
                        _loc2_ = §ۙ§(_loc3_,_loc2_);
                        if(_loc2_ < 0)
                        {
                           ڼ(_loc5_);
                           continue loop0;
                        }
                        _loc5_ = _loc5_ + String.fromCharCode(_loc3_);
                        _loc6_++;
                     }
                     _loc3_ = _loc2_;
                     break;
                  case CHAR_x:
                     _loc3_ = ۉ();
                     _loc2_ = §ۙ§(_loc3_,0);
                     if(_loc2_ < 0)
                     {
                        ڼ(CHAR_x);
                        continue;
                     }
                     _loc7_ = _loc3_;
                     _loc3_ = ۉ();
                     _loc2_ = §ۙ§(_loc3_,_loc2_);
                     if(_loc2_ < 0)
                     {
                        ڼ(CHAR_x);
                        ڼ(_loc7_);
                        continue;
                     }
                     _loc3_ = _loc2_;
                     break;
                  case CHAR_NL:
                     _loc3_ = ۉ();
                     continue;
                  default:
                     if(CHAR_0 <= _loc3_ && _loc3_ < CHAR_8)
                     {
                        _loc8_ = _loc3_ - CHAR_0;
                        _loc3_ = ۉ();
                        if(CHAR_0 <= _loc3_ && _loc3_ < CHAR_8)
                        {
                           _loc8_ = 8 * _loc8_ + _loc3_ - CHAR_0;
                           _loc3_ = ۉ();
                           if(CHAR_0 <= _loc3_ && _loc3_ < CHAR_8 && _loc8_ <= 37)
                           {
                              _loc8_ = 8 * _loc8_ + _loc3_ - CHAR_0;
                              _loc3_ = ۉ();
                           }
                        }
                        ڲ(_loc3_);
                        _loc3_ = _loc8_;
                        break;
                     }
               }
            }
            ڼ(_loc3_);
            _loc3_ = ۉ();
         }
         this.string = ێ();
         return STRING;
      }
      
      private function ۄ(param1:int) : Boolean
      {
         var _loc2_:int = ۉ();
         while(_loc2_ != CHAR_EOF)
         {
            ڼ(_loc2_);
            if(_loc2_ == param1)
            {
               return true;
            }
            _loc2_ = ۉ();
         }
         ں.clear();
         this.string = null;
         §׫§("msg.XML.bad.form");
         return false;
      }
      
      private function ۇ(param1:String, param2:Number) : Number
      {
         var _loc4_:int = 0;
         var _loc3_:Number = 0;
         if(param2 == 10)
         {
            return Number(param1);
         }
         if(param2 == 16)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ = §ۙ§(param1.charCodeAt(_loc4_),_loc3_);
               _loc4_++;
            }
         }
         else if(param2 == 8)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ = §ۘ§(param1.charCodeAt(_loc4_),_loc3_);
               _loc4_++;
            }
         }
         else
         {
            ʉ.§׫§("msg.bad.number.base",param2);
         }
         return _loc3_;
      }
      
      public function ۈ() : int
      {
         var _loc1_:int = ۉ();
         ڲ(_loc1_);
         return _loc1_;
      }
      
      public function ۉ() : int
      {
         var _loc1_:int = 0;
         if(ۆ != 0)
         {
            return ۂ[--ۆ];
         }
         while(ۅ != ۀ)
         {
            _loc1_ = ڰ.charCodeAt(ۅ++);
            if(ڿ >= 0)
            {
               if(ڿ == CHAR_CR && _loc1_ == CHAR_NL)
               {
                  ڿ = CHAR_NL;
                  continue;
               }
               ڿ = -1;
               ۃ = ۅ - 1;
               ڠ++;
            }
            if(_loc1_ <= 127)
            {
               if(_loc1_ == CHAR_NL || _loc1_ == CHAR_CR)
               {
                  ڿ = _loc1_;
                  _loc1_ = CHAR_NL;
               }
            }
            else if(§۔§(_loc1_))
            {
               ڿ = _loc1_;
               _loc1_ = CHAR_NL;
            }
            return _loc1_;
         }
         ۋ = true;
         return CHAR_EOF;
      }
      
      public function ێ() : String
      {
         return ں.toString();
      }
      
      public final function ۏ() : String
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(ڰ != null)
         {
            _loc1_ = ۅ;
            if(ڿ >= 0)
            {
               _loc1_--;
            }
            else
            {
               while(_loc1_ != ۀ)
               {
                  _loc2_ = ڰ.charCodeAt(_loc1_);
                  if(§۔§(_loc2_))
                  {
                     break;
                  }
                  _loc1_++;
               }
            }
            return ڰ.substring(ۃ,_loc1_);
         }
         _loc3_ = ۅ - ۃ;
         if(ڿ >= 0)
         {
            _loc3_--;
         }
         else
         {
            while(true)
            {
               _loc4_ = ۃ + _loc3_;
               if(_loc4_ == ۀ)
               {
                  break;
               }
               _loc2_ = ڰ.charCodeAt(_loc4_);
               if(§۔§(_loc2_))
               {
                  break;
               }
               _loc3_++;
            }
         }
         return ڰ.substring(ۃ,_loc3_);
      }
      
      public final function eof() : Boolean
      {
         return ۋ;
      }
      
      private function ۑ() : Boolean
      {
         var _loc1_:int = ۉ();
         while(_loc1_ != CHAR_EOF)
         {
            ڼ(_loc1_);
            if(_loc1_ == CHAR_DASH && ۈ() == CHAR_DASH)
            {
               _loc1_ = ۉ();
               ڼ(_loc1_);
               if(ۈ() == CHAR_GT)
               {
                  _loc1_ = ۉ();
                  ڼ(_loc1_);
                  return true;
               }
            }
            else
            {
               _loc1_ = ۉ();
            }
         }
         ں.clear();
         this.string = null;
         §׫§("msg.XML.bad.form");
         return false;
      }
   }
}
