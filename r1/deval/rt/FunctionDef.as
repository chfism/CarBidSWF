package r1.deval.rt
{
   public class FunctionDef implements IExpr
   {
       
      
      private var head:Block;
      
      private var params:Array;
      
      public var name:String;
      
      private var tail:EndBlock;
      
      public function FunctionDef(name:String, params:Array, head:Block, tail:EndBlock)
      {
         super();
         this.name = name == null?"_anonymous_":name;
         this.params = params;
         this.head = head;
         this.tail = tail;
      }
      
      public function optimize() : void
      {
         if(head != null)
         {
            head.optimize();
         }
      }
      
      public function getString() : String
      {
         throw new RTError("msg.rt.eval.function.to.value");
      }
      
      public function getBoolean() : Boolean
      {
         throw new RTError("msg.rt.eval.function.to.value");
      }
      
      public function run(paramVals:Array) : Object
      {
         var paramsLen:int = params == null?int(0):int(params.length);
         var len:int = paramVals == null?int(0):int(paramVals.length);
         if(len > paramsLen)
         {
            len = paramsLen;
         }
         var context:Object = {};
         for(var idx:int = 0; idx < len; idx++)
         {
            context[params[idx]] = paramVals[idx];
         }
         try
         {
            Env.pushObject(context);
            Env.setReturnValue(null);
            head.run(tail);
            return Env.getReturnValue();
         }
         finally
         {
            while(true)
            {
               Env.popObject();
            }
            return null;
         }
         break loop1;
      }
      
      public function dump(dumpMap:Object) : void
      {
         var ret:String = "\n<Function name=\"" + name + "\" params=\"";
         var len:int = params == null?int(0):int(params.length);
         for(var i:int = 0; i < len; i++)
         {
            if(i > 0)
            {
               ret = ret + ",";
            }
            ret = ret + params[i];
         }
         trace(ret + "\">");
         head.dump(dumpMap,1);
         trace("\n</Function>");
      }
      
      public function getAny() : Object
      {
         return this;
      }
      
      public function getNumber() : Number
      {
         throw new RTError("msg.rt.eval.function.to.value");
      }
   }
}
