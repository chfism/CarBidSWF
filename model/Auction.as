package model
{
   import zebra.core.GameModel;
   
   public class Auction extends GameModel
   {
       
      
      public var uid:String;
      
      public var uname:String;
      
      public var clientid:String;
      
      public var informationserverstr:String;
      
      public var tradeserverstr:String;
      
      public var webserverstr:String;
      
      public var lcserverstr:String;
      
      public var auctype:String;
      
      public var pwd:String;
      
      public function Auction()
      {
         super();
      }
   }
}
