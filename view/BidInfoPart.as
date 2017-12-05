package view
{
   import zebra.Game;
   import ws.Bidinfo;
   
   public class BidInfoPart extends Bidinfo
   {
       
      
      public function BidInfoPart()
      {
         super();
         Game.Content.addUpdateView(this);
         this.setLightState(1);
      }
      
      public function setLightState(param1:int) : void
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
