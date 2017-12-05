package model
{
   import zebra.Game;
   
   public class BidStageServerModel extends ServerModel 
   {
       
      
      public function BidStageServerModel()
      {
         super();
         port = 8300;
         Game.Content.addModel(this);
      }
   }
}
