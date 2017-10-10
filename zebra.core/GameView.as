package zebra.core
{
   import zebra.Game;
   
   public class GameView extends BaseSprite
   {
       
      
      public function GameView()
      {
         super();
         Game.Content.addView(this);
      }
   }
}
