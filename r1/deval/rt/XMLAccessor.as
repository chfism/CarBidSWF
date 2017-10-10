package r1.deval.rt
{
   class XMLAccessor extends Accessor
   {
       
      
      var ns:IExpr;
      
      var flags:int;
      
      var dotQuery:Boolean;
      
      function XMLAccessor(host:IExpr, idx:*, ns:IExpr, dotQuery:Boolean = false, attr:Boolean = false, descendants:Boolean = false)
      {
         super(host,idx);
         this.dotQuery = dotQuery;
         this.ns = ns;
         this.flags = 0;
         if(attr)
         {
            flags = flags | 2;
         }
         if(descendants)
         {
            flags = flags | 1;
         }
      }
      
      override public function setValue(val:Object) : void
      {
         var idx:Object = getIndex();
         if(ns != null)
         {
            idx = new QName(ns.getAny(),idx);
         }
         var xml:Object = host.getAny();
         switch(flags)
         {
            case 0:
               xml[idx] = val;
               break;
            case 2:
               xml[idx] = val;
               break;
            default:
               throw new RTError("msg.unknown.xml.operator");
         }
      }
      
      override public function getAny() : Object
      {
         var xml:Object = null;
         if(dotQuery)
         {
            return doDotQuery();
         }
         var idx:Object = getIndex();
         if(ns != null)
         {
            idx = new QName(ns.getAny(),idx);
         }
         if(host == null)
         {
            xml = Env.peekObject();
            switch(flags)
            {
               case 0:
                  return xml[idx];
               case 1:
                  return xml.descendants(idx);
               case 2:
                  return xml[idx];
               case 3:
                  return xml..[idx];
            }
         }
         else
         {
            xml = host.getAny();
            switch(flags)
            {
               case 0:
                  return xml[idx];
               case 1:
                  return xml.descendants(idx);
               case 2:
                  return xml[idx];
               case 3:
                  return xml..[idx];
            }
         }
         throw new RTError("msg.unknown.xml.operator");
      }
      
      private function doDotQuery() : Object
      {
         var root:XML = null;
         var x:* = undefined;
         var xml:Object = host.getAny();
         if(xml is XML)
         {
            Env.pushObject(xml);
            if(!getIndexAsBoolean())
            {
               return new XMLList("");
            }
            Env.popObject();
         }
         else
         {
            root = <root/>;
            for each(x in xml as XMLList)
            {
               Env.pushObject(x);
               if(getIndexAsBoolean())
               {
                  root.appendChild(x);
               }
               Env.popObject();
            }
            xml = root.children();
         }
         return xml;
      }
   }
}
