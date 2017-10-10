package r1.deval.rt
{
   class ObjectInit extends ObjectExprBase
   {
       
      
      var elems:Array;
      
      var objectInit:Object;
      
      function ObjectInit(objinit:Object, elems:Array)
      {
         super();
         objectInit = objinit;
         this.elems = elems;
      }
      
      override public function getAny() : Object
      {
         var x:* = undefined;
         var y:String = null;
         var arr:Array = null;
         if(objectInit is Array)
         {
            arr = [];
            for each(x in objectInit as Array)
            {
               if(x is IExpr)
               {
                  x = (x as IExpr).getAny();
               }
               arr.push(x);
            }
            return arr;
         }
         var obj:Object = {};
         for each(y in elems)
         {
            x = objectInit[y];
            if(x is IExpr)
            {
               x = (x as IExpr).getAny();
            }
            obj[y] = x;
         }
         return obj;
      }
   }
}
