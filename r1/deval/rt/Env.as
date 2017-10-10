package r1.deval.rt
{
   import flash.utils.describeType;
   import r1.deval.D;
   
   public class Env
   {
      
      public static var outputFunction:Function = trace;
      
      private static var _overrideGlobalOption:int = D.OVERRIDE_GLOBAL_OVERRIDE;
      
      private static var stack:Array = [];
      
      private static const _global:Object = {
         "decodeURI":decodeURI,
         "decodeURIComponent":decodeURIComponent,
         "encodeURI":encodeURI,
         "encodeURIComponent":encodeURIComponent,
         "escape":escape,
         "isFinite":isFinite,
         "isNaN":isNaN,
         "isXMLName":isXMLName,
         "parseFloat":parseFloat,
         "parseInt":parseInt,
         "trace":trace,
         "unescape":unescape,
         "printf":printf,
         "importFunction":importFunction,
         "importStaticMethods":importStaticMethods,
         "Array":Array,
         "Boolean":Boolean,
         "int":int,
         "Number":Number,
         "Object":Object,
         "String":String,
         "uint":uint,
         "XML":XML,
         "XMLList":XMLList,
         "Date":Date,
         "Math":Math,
         "RegExp":RegExp,
         "QName":QName,
         "Namespace":Namespace,
         "Error":Error,
         "Class":Class
      };
      
      public static var INFINITE_LOOP_LIMIT:Number = 100000;
      
      private static const __errors:Object = {
         "msg.no.paren.parms":"missing ( before function parameters.",
         "msg.misplaced.case":"misplaced case",
         "msg.no.colon.prop":"missing : in object property definition",
         "msg.no.brace.switch":"missing { in switch",
         "msg.bad.continue":"incorrect use of continue",
         "msg.illegal.character":"illegal character",
         "msg.reserved.id":"identifier is a reserved word",
         "msg.bad.break.continue":"incorrect use of break or continue",
         "msg.unreachable.code":"unreachable code",
         "msg.bad.prop":"invalid property id",
         "msg.no.name.after.dot":"missing name after . operator",
         "msg.no.paren":"missing ) in parenthetical",
         "msg.misplaced.right.brace":"misplaced }",
         "msg.unreachable.stmts.in.switch":"unreachable code in switch statement",
         "msg.XML.bad.form":"illegally formed XML syntax",
         "msg.dup.label":"duplicatet label",
         "msg.no.semi.stmt":"missing ; before statement",
         "msg.class.not.supported":"class not supported",
         "msg.no.colon.cond":"missing : in conditional expression",
         "msg.bad.number.base":"incorrect number base",
         "msg.missing.exponent":"missing exponent",
         "msg.case.no.colon":"missing : after case expression",
         "msg.no.name.after.xmlAttr":"missing name after .@",
         "msg.no.brace.prop":"missing } after property list",
         "msg.unterminated.re.lit":"unterminated regular expression literal",
         "msg.invalid.escape":"invalid Unicode escape sequence",
         "msg.unterminated.comment":"unterminated comment",
         "msg.invalid.re.flag":"invalid flag after regular expression",
         "msg.caught.nfe":"number format error",
         "msg.not.assignable":"not assignable",
         "msg.unexpected.eof":"Unexpected end of file",
         "msg.no.brace.body":"missing \'{\' before function body",
         "msg.undef.label":"undefined labe",
         "msg.function.expr.not.supported":"function expression is not supported",
         "msg.missing.function.name":"missing function name",
         "msg.syntax":"syntax error",
         "msg.unterminated.string.lit":"unterminated string literal",
         "msg.no.bracket.arg":"missing ] after element list",
         "msg.bad.namespace":"not a valid default namespace statement. Syntax is: default xml namespace : EXPRESSION;",
         "msg.no.bracket.index":"missing ] in index expression",
         "msg.no.name.after.coloncolon":"missing name after ::",
         "msg.no.paren.for":"missing ( after for",
         "msg.no.paren.after.parms":"missing ) after formal parameters"
      };
      
      private static var _curEnv:Env;
       
      
      private var thisObject_getters:Object;
      
      private var scopeChain:Array;
      
      private var context:Object;
      
      private var thisObject_setters:Object;
      
      private var thisObject:Object;
      
      private var result:Object;
      
      public function Env(thisObj:Object, context:Object)
      {
         var xml:XML = null;
         var x:XML = null;
         var access:String = null;
         super();
         this.thisObject = thisObj;
         this.context = context;
         this.scopeChain = [context];
         thisObject_setters = {};
         thisObject_getters = {};
         if(thisObj)
         {
            this.scopeChain.push(thisObj);
            if(thisObj.prototype != null)
            {
               this.scopeChain.push(thisObj.prototype);
            }
            xml = describeType(thisObj);
            for each(x in xml.accessor)
            {
               access = x.@access;
               if(access == "readwrite")
               {
                  thisObject_getters[x.@name] = true;
                  thisObject_setters[x.@name] = true;
               }
               else if(access == "readonly")
               {
                  thisObject_getters[x.@name] = true;
               }
               else if(access == "writeonly")
               {
                  thisObject_setters[x.@name] = true;
               }
            }
         }
         else
         {
            thisObject_setters = thisObject_getters;
         }
         this.scopeChain.push(_global);
      }
      
      public static function getClass(className:String) : Class
      {
         var x:* = _global[className];
         if(x == null)
         {
            return null;
         }
         if(x is Class)
         {
            return x as Class;
         }
         if(x is Array)
         {
            x = (x as Array)[0];
            if(x is Class)
            {
               return x;
            }
         }
         return null;
      }
      
      public static function getProperty(prop:*) : Object
      {
         return _curEnv.getProperty(prop);
      }
      
      public static function isInDocQuery() : Boolean
      {
         var x:* = _curEnv.scopeChain[0];
         return x is XML || x is XMLList;
      }
      
      public static function reportWarning(... args) : void
      {
         outputFunction("[D:warn ] " + getMessage.apply(null,args));
      }
      
      public static function display(msg:String) : void
      {
         outputFunction(msg);
      }
      
      public static function run(prgm:Block, thisObj:Object = null, context:Object = null) : Object
      {
         var env:Env = new Env(thisObj,context != null?context:{});
         if(prgm)
         {
            try
            {
               pushEnv(env);
               prgm.run();
               return env.returnValue;
            }
            finally
            {
               while(true)
               {
                  popEnv();
               }
               return null;
            }
         }
         return null;
      }
      
      public static function importClass(cls:Class, clsName:String = null) : void
      {
         if(clsName == null)
         {
            clsName = describeType(cls).@name;
         }
         var segs:Array = clsName.split(/\./g);
         clsName = segs[segs.length - 1];
         importGlobal(clsName,cls);
      }
      
      public static function getThis() : Object
      {
         return _curEnv.thisObject;
      }
      
      public static function setProperty(prop:*, val:Object) : void
      {
         _curEnv.setProperty(prop,val);
      }
      
      public static function printf(... args) : void
      {
         display(getMessageAsIs.apply(null,args));
      }
      
      private static function popEnv() : void
      {
         stack.pop();
         if(stack.length > 0)
         {
            _curEnv = stack[stack.length - 1];
         }
         else
         {
            _curEnv = null;
         }
      }
      
      public static function importFunction(name:String, f:Function) : void
      {
         importGlobal(name,f);
      }
      
      public static function setReturnValue(ret:Object) : void
      {
         _curEnv.returnValue = ret;
      }
      
      public static function getMessage(... args) : String
      {
         if(args.length > 0)
         {
            args[0] = idToMessage(args[0]);
         }
         return getMessageAsIs.apply(null,args);
      }
      
      public static function setOverrideGlobalOption(option:int) : void
      {
         _overrideGlobalOption = option;
      }
      
      private static function importGlobal(name:String, value:*) : void
      {
         if(_overrideGlobalOption != D.OVERRIDE_GLOBAL_OVERRIDE)
         {
            if(_global[name])
            {
               switch(_overrideGlobalOption)
               {
                  case D.OVERRIDE_GLOBAL_WARN:
                     reportWarning("msg.override.global.name",name);
                     break;
                  case D.OVERRIDE_GLOBAL_ERROR:
                     throw new RTError("msg.override.global.name",name);
               }
            }
         }
         _global[name] = value;
      }
      
      public static function getReturnValue() : Object
      {
         return _curEnv.returnValue;
      }
      
      public static function getMessageAsIs(... args) : String
      {
         switch(args.length)
         {
            case 0:
               return "";
            case 1:
               return String(args[0]);
            default:
               return Util.substitute.apply(null,args);
         }
      }
      
      public static function popObject() : *
      {
         return _curEnv.popObject();
      }
      
      private static function idToMessage(id:String) : String
      {
         var msg:String = __errors[id] as String;
         return msg == null?id:msg;
      }
      
      private static function pushEnv(e:Env) : void
      {
         stack.push(_curEnv = e);
      }
      
      public static function reportError(... args) : void
      {
         outputFunction("[D:error] " + getMessage.apply(null,args));
      }
      
      public static function debug(... args) : void
      {
         outputFunction("[D:debug] " + getMessage.apply(null,args));
      }
      
      public static function pushObject(o:*) : void
      {
         _curEnv.pushObject(o);
      }
      
      public static function peekObject() : *
      {
         return _curEnv.scopeChain[0];
      }
      
      public static function importStaticMethods(cls:Class, criteria:* = null) : void
      {
         var mthd:XML = null;
         var n:String = null;
         var xml:XML = describeType(cls);
         for each(mthd in xml.method)
         {
            n = mthd.@name;
            if(criteria)
            {
               if(criteria is RegExp)
               {
                  if(!n.match(criteria as RegExp))
                  {
                     n = null;
                  }
               }
               else if(criteria is Array)
               {
                  if((criteria as Array).indexOf(n) < 0)
                  {
                     n = null;
                  }
               }
               else if(n != criteria)
               {
                  n = null;
               }
            }
            if(n)
            {
               importFunction(n,cls[n]);
            }
         }
      }
      
      function set returnValue(ret:Object) : void
      {
         result = ret;
      }
      
      function get returnValue() : Object
      {
         return result;
      }
      
      function getProperty(prop:*) : Object
      {
         var x:* = undefined;
         for each(x in scopeChain)
         {
            if(x.hasOwnProperty(prop))
            {
               return x[prop];
            }
         }
         if(thisObject != null && thisObject_getters[prop])
         {
            return thisObject[prop];
         }
         return null;
      }
      
      function popObject() : *
      {
         return scopeChain.shift();
      }
      
      function setProperty(prop:*, val:*) : void
      {
         var x:* = undefined;
         for each(x in scopeChain)
         {
            if(x.hasOwnProperty(prop))
            {
               x[prop] = val;
               return;
            }
         }
         if(thisObject != null && thisObject_setters[prop])
         {
            thisObject[prop] = val;
         }
         else
         {
            context[prop] = val;
         }
      }
      
      function pushObject(o:*) : void
      {
         scopeChain.unshift(o);
      }
   }
}
