package zebra.core
{
   import zebra.Game;
   
   public class GameModel
   {
       
      
      public function GameModel()
      {
         super();
         Game.Content.addModel(this);
      }
   }
}
