//Created by Action Script Viewer - http://www.buraks.com/asv
package task
{
    import zebra.thread.task.TaskAction;
    import zebra.Game;
    import model.BidInfoUserModel;
    import view.BidInfoView;
    import zebra.system.net.SocketThreadParam;

    public class BidInfoHeartAction extends TaskAction 
    {


        override public function execute():void
        {
            super.execute();
            Game.Hack.gc();
            var bidInfoUserModel:BidInfoUserModel = (Game.Content.getModel(BidInfoUserModel) as BidInfoUserModel);
            if (bidInfoUserModel != null)
            {
                bidInfoUserModel.sendTimespan = new Date();
                BidInfoView(Game.Content.getView(BidInfoView)).socketControl.socket.send("0-0", bidInfoUserModel.bytes0_0);
            };
        }

        private function Reader0to0Handler(data:SocketThreadParam):void
        {
            var bidInfoUserModel:BidInfoUserModel = (Game.Content.getModel(BidInfoUserModel) as BidInfoUserModel);
            bidInfoUserModel.getTimespan = new Date();
            bidInfoUserModel.timespan = (bidInfoUserModel.getTimespan - bidInfoUserModel.sendTimespan).toString();
            BidInfoView(Game.Content.getView(BidInfoView)).socketControl.socket.destroy("0-0", this.Reader0to0Handler);
        }


    }
}//package task