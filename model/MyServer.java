package Util
{
   public class MyServer
   {
      
      public var _str:String;
      
      public var iplist:Array;
      
      public var port:int = 0;
      
      public var changeCount:int = 0;
      
      private var serverindex:int = 0;
      
      private var _allowChangeCount:Boolean = false;
      
      private var logapplication:LogApplication;
      
      public function MyServer()
      {
      }
      
      native public function setAllowChangeCount() : void;
      
      native public function resetAllowChangeCount() : void;
      
      native public function get ip() : String;
      
      native public function changeIP() : void;
   }
}
