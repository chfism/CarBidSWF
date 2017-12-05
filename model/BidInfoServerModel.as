package model
{
   import zebra.Game;
   
   public class BidInfoServerModel extends ServerModel 
   {
       
      
      public function BidInfoServerModel()
      {
         super();
         port = 8301;
         Game.Content.addModel(this);
      }
      
      public function init() : void
      {
      }
   }
}
