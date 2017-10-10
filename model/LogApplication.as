package model
{
   import flash.system.ApplicationDomain;
   import zebra.Game;
   import view.SentLogView;
   
   public class LogApplication
   {
       
      
      public function LogApplication()
      {
         super();
      }
      
      public function WriteLogWithRequestID(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Date = null;
         var _loc5_:String = null;
         if(Game.Hack.debug)
         {
            _loc4_ = new Date();
            _loc5_ = String(_loc4_.getHours()) + ":" + String(_loc4_.getMinutes()) + ":" + String(_loc4_.getSeconds()) + "." + String(_loc4_.getMilliseconds());
            SentLogView(Game.Content.getView(SentLogView)).info(_loc5_ + "," + param1 + "," + param2 + ",requestid=" + param3);
         }
      }
      
      public function WriteLog2(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Date = null;
         var _loc5_:String = null;
         if(Game.Hack.debug)
         {
            _loc4_ = new Date();
            _loc5_ = String(_loc4_.getHours()) + ":" + String(_loc4_.getMinutes()) + ":" + String(_loc4_.getSeconds()) + "." + String(_loc4_.getMilliseconds());
            SentLogView(Game.Content.getView(SentLogView)).info(_loc5_ + "," + param1 + "," + param2 + "," + param3);
         }
      }
      
      public function WriteLog(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Date = null;
         var _loc5_:String = null;
         if(Game.Hack.debug)
         {
            _loc4_ = new §§pop().Date();
            _loc5_ = String(_loc4_.getHours()) + ":" + String(_loc4_.getMinutes()) + ":" + String(_loc4_.getSeconds()) + "." + String(_loc4_.getMilliseconds());
            SentLogView(Game.Content.getView(SentLogView)).info(_loc5_ + "," + param1 + "," + param2 + "," + param3);
         }
      }
      
      public function WriteLogWithIpAndPort(param1:String, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:Date = null;
         var _loc6_:String = null;
         if(Game.Hack.debug)
         {
            _loc5_ = new Date();
            _loc6_ = String(_loc5_.getHours()) + ":" + String(_loc5_.getMinutes()) + ":" + String(_loc5_.getSeconds()) + "." + String(_loc5_.getMilliseconds());
            SentLogView(Game.Content.getView(SentLogView)).info(_loc6_ + "," + param1 + "," + param2 + ",ip=" + param3 + ":" + param4);
         }
      }
      
      public function WriteLogWithURL(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Date = null;
         var _loc5_:String = null;
         if(Game.Hack.debug)
         {
            _loc4_ = new Date();
            _loc5_ = String(_loc4_.getHours()) + ":" + String(_loc4_.getMinutes()) + ":" + String(_loc4_.getSeconds()) + "." + String(_loc4_.getMilliseconds());
            SentLogView(Game.Content.getView(SentLogView)).info(_loc5_ + "," + param1 + "," + param2 + "," + "url:" + param3);
         }
      }
   }
}
