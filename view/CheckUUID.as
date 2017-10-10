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
   
   public class CheckUUID extends Sprite
   {
       
      
      private var uuid:String;
      
      private var textfield:TextField;
      
      private var _second:int = 0;
      
      public function CheckUUID()
      {
         this.uuid = GUID.create();
         this.textfield = new TextField();
         super();
         var _sharedobject:SharedObject = SharedObject.getLocal("browserSO");
         _sharedobject.data["uuid"] = this.uuid;
         _sharedobject.flush();
         addChild(new Container());
         addEventListener(Event.ENTER_FRAME,this.CheckUUIDHandler);
      }
      
      private function CheckUUIDHandler(param1:Event) : void
      {
         var _errorinfo:errorInfo = null;
         this._second++;
         if(this._second % 60 != 0)
         {
            return;
         }
         var _sharedobject:SharedObject = SharedObject.getLocal("browserSO");
         this.textfield.text = _sharedobject.data["uuid"] + "<<>>" + this.uuid + ">>" + Math.random();
         if(_sharedobject.data["uuid"] != this.uuid)
         {
            removeEventListener(Event.ENTER_FRAME,this.CheckUUIDHandler);
            Main._disconnected = true;
            ExternalInterface.call("clearbidcookies");
            removeChildren();
            RightContainerView(Game.Content.getView(RightContainerView)).socketControl.close();
            
            if(!new MovieClip()["@doswf__stage"])
            {
               return;
            }
            _errorinfo = new §§pop().errorInfo();
            _errorinfo.x = 25;
            Game.graphicsDeviceManager.stage.addChild(_errorinfo);
         }
      }
   }
}
