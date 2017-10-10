package mx.events
{
   import flash.events.Event;
   
   public class ScrollEvent extends Event
   {
      
      public static const SCROLL:String = "scroll";
       
      
      private var direction:String;
      
      private var delta:Number;
      
      private var position:Number;
      
      public function ScrollEvent(param1:String, param2:Number, param3:Number)
      {
         super(ScrollEvent.SCROLL,false,false);
         this.direction = param1;
         this.delta = param2;
         this.position = param3;
      }
      
      public function get direction() : String
      {
         return this.direction;
      }
      
      public function get delta() : Number
      {
         return this.delta;
      }
      
      public function get position() : Number
      {
         return this.position;
      }
      
      override public function toString() : String
      {
         return formatToString("ScrollEvent","type","bubbles","cancelable","direction","delta","position");
      }
      
      override public function clone() : Event
      {
         return new ScrollEvent(this.direction,this.delta,this.position);
      }
   }
}
