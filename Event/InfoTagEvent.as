package Event
{
   import zebra.directEvent.DirectEventParameter;
   
   public class InfoTagEvent extends DirectEventParameter
   {
      
      public static var name:String = "InfoTag";
       
      
      public var _type:String = "";
      
      public var value;
      
      public function InfoTagEvent()
      {
         super();
      }
   }
}
