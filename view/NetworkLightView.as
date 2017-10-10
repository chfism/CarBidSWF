package view
{
   import zebra.Game;
   import ws.Bidinfo;
   
   public class NetworkLightView extends Bidinfo
   {
       
      
      public function NetworkLightView()
      {
         super();
         Game.Content.addUpdateView(this);
         this.lightstop(1);
      }
      
      public function lightstop(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               light.gotoAndStop(1);
               networkText.visible = true;
               break;
            case 2:
               light.gotoAndStop(2);
               networkText.visible = false;
               break;
            case 3:
               light.gotoAndStop(3);
               networkText.visible = false;
         }
      }
   }
}
