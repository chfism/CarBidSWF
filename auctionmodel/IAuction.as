package auctionmodel
{
   public interface IAuction
   {
       
      
      function get tradeSn() : int;
      
      function set tradeSn(param1:int) : void;
      
      function get queueLength() : int;
      
      function set queueLength(param1:int) : void;
   }
}
