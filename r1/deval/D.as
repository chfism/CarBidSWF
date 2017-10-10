package r1.deval
{
   import r1.deval.parser.BaseParser;
   import r1.deval.rt.Block;
   import r1.deval.rt.Env;
   import r1.deval.rt.FunctionDef;
   
   public class D
   {
      
      private static var _programLimit:int = 512;
      
      private static var _cache:Object = {};
      
      private static var _useCache:Boolean = true;
      
      public static const OVERRIDE_GLOBAL_ERROR:int = 3;
      
      public static const OVERRIDE_GLOBAL_OVERRIDE:int = 1;
      
      public static const OVERRIDE_GLOBAL_WARN:int = 2;
      
      public static const OVERRIDE_GLOBAL_IGNORE:int = 0;
       
      
      public function D()
      {
         super();
      }
      
      public static function display(msg:String) : void
      {
         Env.display(msg);
      }
      
      public static function setOutput(receiver:Function) : void
      {
         Env.outputFunction = receiver;
      }
      
      public static function collectUserFunctions(context:Object) : Object
      {
         var name:String = null;
         var val:Object = null;
         var ret:Object = {};
         for each(name in context)
         {
            val = context[val];
            if(val is FunctionDef)
            {
               ret[name] = val;
            }
         }
         return ret;
      }
      
      public static function useCache(b:Boolean = true, programSizeLimit:int = -1) : void
      {
         _useCache = b;
         if(programSizeLimit > 0)
         {
            _programLimit = programSizeLimit;
         }
      }
      
      public static function setTextControlOutput(host:Object, prop:String = "text", limit:int = 2048) : void
      {
         setOutput(function(msg:String):void
         {
            var s:String = host[prop];
            if(s == "")
            {
               s = msg;
            }
            else
            {
               if(s.length >= limit)
               {
                  s = s.substring(s.length - limit);
               }
               s = s + "\n" + msg;
            }
            host[prop] = s;
         });
      }
      
      public static function parseProgram(program:String) : Object
      {
         return new BaseParser().parseProgram(program);
      }
      
      public static function importClass(cls:Class) : void
      {
         Env.importClass(cls);
      }
      
      public static function eval(program:*, context:Object = null, thisObj:Object = null) : Object
      {
         var dyncode:String = null;
         var fd:FunctionDef = null;
         if(program == null || program == "")
         {
            return null;
         }
         if(program is String)
         {
            dyncode = String(program);
            if(_useCache && dyncode.length <= _programLimit)
            {
               program = _cache[dyncode];
               if(program == null)
               {
                  _cache[dyncode] = program = parseProgram(dyncode);
               }
            }
            else
            {
               program = parseProgram(dyncode);
            }
         }
         if(program is Array)
         {
            if(context == null)
            {
               context = {};
            }
            for each(fd in program[1])
            {
               context[fd.name] = fd;
            }
            program = program[0];
         }
         return Env.run(program as Block,thisObj,context);
      }
      
      public static function importFunction(name:String, f:Function) : void
      {
         Env.importFunction(name,f);
      }
      
      public static function evalToNumber(program:*, context:Object = null, thisObj:Object = null) : Number
      {
         return Number(eval(program,context,thisObj));
      }
      
      public static function setOverrideGlobalOption(option:int) : void
      {
         Env.setOverrideGlobalOption(option);
      }
      
      public static function parseFunctions(code:String) : Object
      {
         var fd:FunctionDef = null;
         var ret:Object = {};
         var prog:Object = parseProgram(code);
         if(prog is Array)
         {
            for each(fd in prog[1])
            {
               ret[fd.name] = fd;
            }
         }
         return ret;
      }
      
      public static function evalToString(program:*, context:Object = null, thisObj:Object = null) : String
      {
         return eval(program,context,thisObj) as String;
      }
      
      public static function evalToBoolean(program:*, context:Object = null, thisObj:Object = null) : Boolean
      {
         return Boolean(eval(program,context,thisObj));
      }
      
      public static function evalToInt(program:*, context:Object = null, thisObj:Object = null) : int
      {
         return int(eval(program,context,thisObj));
      }
      
      public static function importStaticMethods(cls:Class, criteria:* = null) : void
      {
         Env.importStaticMethods(cls,criteria);
      }
   }
}
