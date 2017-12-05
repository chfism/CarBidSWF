package view
{
   import flash.events.MouseEvent;
   import model.WebParamModel;
   import zebra.Game;
   import ws.PriceResult2;
   import zebra.system.util.Javascript;
   
   public class KickOutPart extends PriceResult2
   {
       
      
      public function KickOutPart(param1:*)
      {
         super();
         switch(param1)
         {
            case 1:
               this.myPriceResult.text = "该投标号已在其他地方登录，请检查投标号并重新登录。";
               break;
            case 2:
               this.myPriceResult.text = "您与服务器的连接已经断开，请重新登录";
         }
         okBut.addEventListener(MouseEvent.CLICK,this.closeHandler);
      }
      
      private function closeHandler(param1:MouseEvent) : void
      {
         this.parent.removeChild(this);
         var webParamModel:WebParamModel = WebParamModel(Game.Content.getModel(WebParamModel));
         if(!Game.Hack.debug)
         {
            if(webParamModel.auctype == "0")
            {
               Javascript.OpenURL("http://" + webParamModel.httpIP + "/bid/");
            }
            else
            {
               Javascript.OpenURL("http://" + webParamModel.httpIP + "/pubbid/");
            }
         }
      }
   }
}
