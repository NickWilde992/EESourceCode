package events.Facebook
{
   import flash.utils.setTimeout;
   
   public class FBData
   {
       
      
      private var timer:int = -1;
      
      private var queue:Array;
      
      public function FBData()
      {
         this.queue = [];
         super();
      }
      
      public function query(param1:String, ... rest) : FBQuery
      {
         var _loc3_:FBQuery = new FBQuery().parse(param1,rest);
         this.queue.push(_loc3_);
         this._waitToProcess();
         return _loc3_;
      }
      
      public function waitOn(param1:Array, param2:Function) : FBWaitable
      {
         var result:FBWaitable = null;
         var count:int = 0;
         var dependencies:Array = param1;
         var callback:Function = param2;
         result = new FBWaitable();
         count = dependencies.length;
         FB.forEach(dependencies,function(param1:*, param2:*, param3:*):void
         {
            var item:* = param1;
            var index:* = param2;
            var original:* = param3;
            item.monitor("value",function():Boolean
            {
               var _loc2_:* = undefined;
               var _loc1_:Boolean = false;
               if(FB.Data._getValue(item) != null)
               {
                  count--;
                  _loc1_ = true;
               }
               if(count == 0)
               {
                  _loc2_ = callback(FB.arrayMap(dependencies,FB.Data._getValue));
                  result.value = _loc2_ != null?_loc2_:true;
               }
               return _loc1_;
            });
         });
         return result;
      }
      
      private function _getValue(param1:*) : *
      {
         return param1 is FBWaitable?param1.value:param1;
      }
      
      private function _waitToProcess() : void
      {
         if(this.timer < 0)
         {
            this.timer = setTimeout(this._process,10);
         }
      }
      
      private function _process() : void
      {
         var mqueries:Object = null;
         var item:FBQuery = null;
         this.timer = -1;
         mqueries = {};
         var q:Array = this.queue;
         this.queue = [];
         var i:int = 0;
         while(i < q.length)
         {
            item = q[i];
            if(item.where.type == "index" && !item.hasDependency)
            {
               this._mergeIndexQuery(item,mqueries);
            }
            else
            {
               mqueries[item.name] = item;
            }
            i++;
         }
         var params:Object = {
            "method":"fql.multiquery",
            "queries":{}
         };
         FB.objCopy(params.queries,mqueries,true,function(param1:FBQuery):String
         {
            return param1.toFql();
         });
         params.queries = JSONx.serialize(params.queries);
         FB.api(params,function(param1:*):void
         {
            var _loc2_:* = null;
            var _loc3_:int = 0;
            var _loc4_:* = undefined;
            if(param1.error_msg)
            {
               for(_loc2_ in mqueries)
               {
                  mqueries[_loc2_].error(new Error(param1.error_msg));
               }
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < param1.length)
               {
                  _loc4_ = param1[_loc3_];
                  mqueries[_loc4_.name].value = _loc4_.fql_result_set;
                  _loc3_++;
               }
            }
         });
      }
      
      private function _mergeIndexQuery(param1:FBQuery, param2:Object) : void
      {
         var key:String = null;
         var value:* = undefined;
         var item:FBQuery = param1;
         var mqueries:Object = param2;
         key = item.where.key;
         value = item.where.value;
         var name:String = "index_" + item.table + "_" + key;
         var master:FBQuery = mqueries[name];
         if(!master)
         {
            master = mqueries[name] = new FBQuery();
            master.fields = [key];
            master.table = item.table;
            master.where = {
               "type":"in",
               "key":key,
               "value":[]
            };
         }
         FB.arrayMerge(master.fields,item.fields);
         FB.arrayMerge(master.where.value,[value]);
         master.wait(function(param1:Array):void
         {
            var r:Array = param1;
            item.value = FB.arrayFilter(r,function(param1:Object):Boolean
            {
               return param1[key] == value;
            });
         },function(param1:*):void
         {
            item.fire("error",param1);
         });
      }
   }
}
