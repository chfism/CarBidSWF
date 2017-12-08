package auctionmodel
{
   public class AuctionWaitResultModel extends AuctionBasicModel implements IAuction
   {
       
      
      public var content:String;
      
      private var tradesn:int;
      
      private var queuelength:int;
      
      public function AuctionWaitResultModel()
      {
         super("G");
      }
      
      public function get tradeSn() : int
      {
         return this.tradesn;
      }
      
      public function set tradeSn(param1:int) : void
      {
         this.tradesn = param1;
      }
      
      public function get queueLength() : int
      {
         return this.queuelength;
      }
      
      public function set queueLength(param1:int) : void
      {
         this.queuelength = param1;
      }
   }
}
