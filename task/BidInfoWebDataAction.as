package task
{
   import flash.utils.getTimer;
   import model.LogApplication;
   import zebra.Game;
   import view.BidStageView;
   import view.BidStagePart;
   import view.BidinfoPart;
   import zebra.thread.task.TaskAction;
   
   public class BidInfoWebDataAction extends TaskAction
   {
      
      public static var Reader3to1Timer:int;
      
      public static var isGetWebData:Boolean = false;
       
      
      public var logappliction:LogApplication;
      
      public function BidInfoWebDataAction()
      {
         this.logappliction = new LogApplication();
         super();
      }
      
      override public function execute() : void
      {
         var bidinfo:BidInfoPart = null;
         var bidstage:BidStagePart = null;
         var bidstageview:BidStageView = null;
         super.execute();
         isGetWebData = false;
         if(getTimer() - Reader3to1Timer > 10 * 1000)
         {
            bidinfo = Bidinfo(Game.Content.getView(Bidinfo));
            bidstage = BidStageView(Game.Content.getView(BidStageView)).bidstagePart;
            bidstageview = BidStageView(Game.Content.getView(BidStageView));
            Reader3to1Timer = getTimer();
            trace("公开信息超过10秒钟未更新");
            bidinfo.setLightState(1);
            if(!Main.isReconnectBy31)
            {
               Main.isReconnectBy31 = true;
               bidstageview.reconnect();
            }
         }
      }
   }
}
