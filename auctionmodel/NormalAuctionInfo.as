package WebParamModelmodel
{
   public class NormalBidStageUserModel extends TradeInfo implements ITradeInfo
   {
       
      
      public var quota:int;
      
      public var numberOfBidUsers:int;
      
      public var priceLowerLimit:int;
      
      public var startTime:Date;
      
      public var updateTime:Date;
      
      public var endTime:Date;
      
      public var systemTime:Date;
      
      public var basePrice:int;
      
      public var basePriceTime:Date;
      
      private var tradesn:int;
      
      private var queuelength:int;
      
      public function NormalBidStageUserModel(param1:String)
      {
         super(param1);
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
    	  //TODO: queuelength
         this.queuelength = param1;
      }
   }
}
