package r1.deval.rt
{
   public class ForInPrologue extends EmptyStmt
   {
       
      
      var _forEach:Boolean;
      
      var _iterVar:String;
      
      var _temp_arr_name:String;
      
      var _temp_idx_name:String;
      
      var _collection:IExpr;
      
      public function ForInPrologue(forInLoopId:int, iterVar:String, collection:IExpr, forEach:Boolean, lineno:int)
      {
         super(lineno);
         this._iterVar = iterVar;
         this._collection = collection;
         this._forEach = forEach;
         this._temp_arr_name = "_tmp_arr_" + forInLoopId;
         this._temp_idx_name = "_tmp_idx_" + forInLoopId;
      }
      
      override public function exec() : void
      {
         var _tmp_arr:Array = null;
         var x:* = undefined;
         var coll:Object = _collection.getAny();
         if(_forEach)
         {
            if(coll is Array)
            {
               _tmp_arr = coll as Array;
            }
            else
            {
               _tmp_arr = [];
               for each(x in coll)
               {
                  _tmp_arr.push(x);
               }
            }
         }
         else
         {
            _tmp_arr = [];
            for(x in coll)
            {
               _tmp_arr.push(x);
            }
         }
         Env.setProperty(_temp_arr_name,_tmp_arr);
         Env.setProperty(_temp_idx_name,0);
      }
   }
}
