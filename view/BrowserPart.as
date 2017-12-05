package view
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.text.TextField;
   import zebra.Game;
   import zebra.system.collections.GUID;
   import wicresoft.errorInfo;
   
   public class BrowserPart extends Sprite
   {
       
      
      private var uuid:String;
      
      private var textfield:TextField;
      
      private var _second:int = 0;
      
      public function BrowserPart()
      {
         this.uuid = GUID.create();
         this.textfield = new TextField();
         super();
         var browserSO:SharedObject = SharedObject.getLocal("browserSO");
         browserSO.data["uuid"] = this.uuid;
         browserSO.flush();
         addChild(new BidInitView());
         addEventListener(Event.ENTER_FRAME,this.frameLogic);
      }
      
      private function frameLogic(e:Event) : void
      {
         var error:errorInfo = null;
         this._second++;
         if(this._second % 60 != 0)
         {
            return;
         }
         var browserSO:SharedObject = SharedObject.getLocal("browserSO");
         this.textfield.text = browserSO.data["uuid"] + "<<>>" + this.uuid + ">>" + Math.random();
         if(browserSO.data["uuid"] != this.uuid)
         {
            removeEventListener(Event.ENTER_FRAME,this.frameLogic);
            Main.isKickOut = true;
            ExternalInterface.call("clearbidcookies");
            clearwin();
            BidStageView(Game.Content.getView(BidStageView)).socketControl.close();

            error = new errorInfo();
            error.x = 25;
            Game.graphicsDeviceManager.stage.addChild(error);
         }
      }
   }
}
