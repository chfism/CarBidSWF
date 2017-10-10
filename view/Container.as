package view
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.setTimeout;
   import zebra.core.GameView;
   import zebra.Game;
   
   public class Container extends GameView
   {
      
      public static var _staticsprite:Sprite;
       
      
      public var left_container:Sprite;
      
      public var right_container:Sprite;
      
      public var sprite1:Sprite;
      
      private var sprite2:Sprite;
      
      public function Container()
      {
         super();
         this.x = 23;
         this.left_container = new Sprite();
         addChild(this.left_container);
         this.right_container = new Sprite();
         addChild(this.right_container);
         this.sprite1 = new Sprite();
         this.sprite1.x = 403;
         addChild(this.sprite1);
         _staticsprite = new Sprite();
         _staticsprite.x = 403;
         addChild(_staticsprite);
         this.sprite2 = new Sprite();
         this.sprite2.addChild(new SentLogView());
         addChild(this.sprite2);
         this.create();
      }
      
      public static function removechildren() : void
      {
         _staticsprite.removeChildren();
      }
      
      public static function DisplayCurrentObject(param1:DisplayObject) : void
      {
         _staticsprite.removeChildren();
         _staticsprite.addChild(param1);
      }
      
      public function create() : void
      {
         Game.TimeUpdate.§ͤ§();
         this.right_container.addChild(new RightContainerView());
         this.left_container.addChild(new LeftContainerView());
      }
      
      public function PopMessage(param1:String, param2:Boolean = false) : void
      {
         this.sprite1.removeChildren();
         this.sprite1.addChild(new PopMessageView(param1,true,param2));
      }
      
      //hum not used function??
      public function §̾§(value:int, timeout:int = 0) : void
      {
         var _value:int = value;
         var _timeout:int = timeout;
         setTimeout(function():*
         {
            if(_value == 0)
            {
               left_container.removeChildren();
               left_container.addChild(new LeftContainerView());
            }
            else
            {
               right_container.removeChildren();
               right_container.addChild(new RightContainerView());
            }
         },_timeout);
      }
   }
}
