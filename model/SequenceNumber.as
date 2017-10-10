package model
{
   import zebra.core.GameModel;
   import Utility.DateAndStrUtil;
   
   public class SequenceNumber extends GameModel
   {
       
      
      public var systemSN:int = 15; //正处理的序号
      
      public var mySN:int = 5; //我的序号
      
      private var _SNDiff:int = 0;
      
      public var Ϩ:int = 6;
      
      public function SequenceNumber()
      {
         super();
      }
      
      public function get ϩ() : int
      {
         return this._SNDiff;
      }
      
      public function SNDiff() : void
      {
         this._SNDiff = this.mySN - this.systemSN;
      }
      
      //TODO:这三个SN什么关系？应该可以推导出处理量
      public function MyBidProgress() : int
      {
         if(DateAndStrUtil.currentSN >= this.mySN)
         {
            return 100;
         }
         return (DateAndStrUtil.currentSN - this.systemSN) / (this.mySN - this.systemSN) * 100;
      }
   }
}
