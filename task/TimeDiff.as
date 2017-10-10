package task
{
   import model.AuctionInfo;
   import zebra.Game;
   import view.RightContainerView;
   import zebra.system.net.SocketThreadParam;
   import zebra.system.collections.FlashBytesReader;
   import zebra.thread.task.TaskAction;
   
   public class TimeDiff extends TaskAction
   {
       
      
      public function TimeDiff()
      {
         super();
      }
      
      override public function execute() : void
      {
         super.execute();
         Game.Hack.gc();
         var _auctioninfo:AuctionInfo = Game.Content.getModel(AuctionInfo) as AuctionInfo;
         if(_auctioninfo != null)
         {
        	 _auctioninfo._time1 = new Date();
            RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket.receive("0-0",this.Т);
            RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket.send("0-0",_auctioninfo.CurrentTimeRequest);
         }
      }
      
      private function Т(param1:SocketThreadParam) : void
      {
         var _loc2_:FlashBytesReader = param1.bytesReader.clone();
         var _str:String = _loc2_.readString();
         var _auctioninfo:AuctionInfo = Game.Content.getModel(AuctionInfo) as AuctionInfo;
      		_auctioninfo._time2 = new Date();
      		_auctioninfo._timediffstr = (_auctioninfo._time2 - _auctioninfo._time1).toString();
         RightContainerView(Game.Content.getView(RightContainerView)).socketControl.socket.destroy("0-0",this.Т);
      }
   }
}
