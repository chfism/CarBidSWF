package r1.deval.rt
{
   class AddSubExpr extends MultiOpExprBase
   {
       
      
      function AddSubExpr(first:IExpr, rest:Array, ops:Array)
      {
         super(first,rest,ops);
      }
      
      override public function getNumber() : Number
      {
         return Number(getAny());
      }
      
      override public function getString() : String
      {
         return getAny().toString();
      }
      
      override public function getBoolean() : Boolean
      {
         return Boolean(getAny());
      }
      
      override public function getAny() : Object
      {
         var numResult:Number = NaN;
         var o:Object = null;
         var cntNumber:int = 0;
         var cntXML:int = 0;
         var vals:Array = null;
         var strResult:String = null;
         var xmlResult:XMLList = null;
         var allSame:Boolean = true;
         for(var i:int = ops.length - 1; i >= 0; i--)
         {
            if(!ops[i])
            {
               allSame = false;
               break;
            }
         }
         if(allSame)
         {
            o = first.getAny();
            cntNumber = o is Number?int(1):int(0);
            cntXML = o is XML?int(1):int(0);
            vals = [o];
            for(i = 0; i < rest.length; i++)
            {
               o = (rest[i] as IExpr).getAny();
               if(o is Number)
               {
                  cntNumber++;
               }
               else if(o is XML || o is XMLList)
               {
                  cntXML++;
               }
               vals.push(o);
            }
            if(cntXML == rest.length + 1)
            {
               xmlResult = new XMLList("");
               for each(o in vals)
               {
                  xmlResult = xmlResult + o;
               }
               return xmlResult;
            }
            if(cntNumber == rest.length + 1)
            {
               numResult = 0;
               for each(o in vals)
               {
                  numResult = numResult + Number(o);
               }
               return numResult;
            }
            strResult = "";
            for each(o in vals)
            {
               strResult = strResult + o;
            }
            return strResult;
         }
         numResult = first.getNumber();
         for(i = 0; i < rest.length; i++)
         {
            if(ops[i])
            {
               numResult = numResult + rest[i].getNumber();
            }
            else
            {
               numResult = numResult - rest[i].getNumber();
            }
         }
         return numResult;
      }
   }
}
