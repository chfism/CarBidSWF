package model
{
   import zebra.Game;
   
   public class InformationServer extends Server
   {
       
      
      public function InformationServer()
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
