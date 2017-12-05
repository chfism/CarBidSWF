package model
{
   import zebra.core.GameModel;
   import Utility.BidinfoParse;
   
   public class UserQueue extends GameModel
   {
       
      
      public var userInitPos:int = 15; 
      
      public var serverTargetPos:int = 5; 
      
      private var _waitCount:int = 0;
      
      public var serverUpdatePos:int = 6;
      
      public function UserQueue()
      {
         super();
      }
      
      public function get ϩ() : int
      {
         return this._waitCount;
      }
      
      public function createWaitCount() : void
      {
         this._waitCount = this.serverTargetPos - this.userInitPos;
      }
      
      public function getPos() : int
      {
         if(BidinfoParse.userUpdatePos >= this.serverTargetPos)
         {
            return 100;
         }
         return (BidinfoParse.userUpdatePos - this.userInitPos) / (this.serverTargetPos - this.userInitPos) * 100;
      }
   }
}
