package task
{
   import model.BidStageUserModel;
   import zebra.Game;
   import view.BidStageView;
   import zebra.system.net.SocketThreadParam;
   import zebra.system.collections.FlashBytesReader;
   import zebra.thread.task.TaskAction;
   
   public class BidStageHeartAction extends TaskAction
   {
       
      
      public function BidStageHeartAction()
      {
         super();
      }
      
      override public function execute() : void
      {
         super.execute();
         Game.Hack.gc();
         var userModel:BidStageUserModel = Game.Content.getModel(BidStageUserModel) as BidStageUserModel;
         if(userModel != null)
         {
        	userModel.sendTimespan = new Date();
            BidStageView(Game.Content.getView(BidStageView)).socketControl.socket.receive("0-0",this.Reader0to0Handler);
            BidStageView(Game.Content.getView(BidStageView)).socketControl.socket.send("0-0",userModel.bytes0_0);
         }
      }
      
      private function Reader0to0Handler(param1:SocketThreadParam) : void
      {
         var bytesReader:FlashBytesReader = param1.bytesReader.clone();
         var receiveData2to2:String = bytesReader.readString();
         var userModel:BidStageUserModel = Game.Content.getModel(BidStageUserModel) as BidStageUserModel;
      		userModel.getTimespan = new Date();
      		userModel.timespan = (userModel.getTimespan - userModel.sendTimespan).toString();
         BidStageView(Game.Content.getView(BidStageView)).socketControl.socket.destroy("0-0",this.Reader0to0Handler);
      }
   }
}
