package task
{
   import flash.utils.getTimer;
   import model.LogApplication;
   import zebra.Game;
   import view.RightContainerView;
   import view.SceneView;
   import view.NetworkLightView;
   import zebra.thread.task.TaskAction;
   
   public class TimeDelay extends TaskAction
   {
      
      public static var _time:int;
      
      public static var Լ:Boolean = false;
       
      
      public var logappliction:LogApplication;
      
      public function TimeDelay()
      {
         this.logappliction = new LogApplication();
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:NetworkLightView = null;
         var _loc2_:SceneView = null;
         var _loc3_:RightContainerView = null;
         super.execute();
         Լ = false;
         if(getTimer() - _time > 10 * 1000)
         {
            _loc1_ = NetworkLightView(Game.Content.getView(NetworkLightView));
            _loc2_ = RightContainerView(Game.Content.getView(RightContainerView))._sceneview;
            _loc3_ = RightContainerView(Game.Content.getView(RightContainerView));
            _time = getTimer();
            _loc1_.lightstop(1);
            if(!Main.isReconnectBy31)
            {
               Main.isReconnectBy31 = true;
               _loc3_.reconnect();
            }
         }
      }
   }
}
