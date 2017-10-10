package auctionmodel
{
   public interface ITradeInfo
   {
       
      
      function get tradeSn() : int;
      
      function set tradeSn(param1:int) : void;
      
      function get queueLength() : int;
      
      function set queueLength(param1:int) : void;
   }
}
