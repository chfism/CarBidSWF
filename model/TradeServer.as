package model
{
   import zebra.Game;
   
   public class TradeServer extends Server
   {
       
      
      public function TradeServer()
      {
         super();
         port = 8300;
         Game.Content.addModel(this);
      }
   }
}
