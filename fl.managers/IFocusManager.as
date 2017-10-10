package fl.managers
{
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import Controls.textboxcontrol;
   
   public interface IFocusManager
   {
       
      
      function get Վ() : textboxcontrol;
      
      function set Վ(param1:textboxcontrol) : void;
      
      function get Տ() : Boolean;
      
      function set Տ(param1:Boolean) : void;
      
      function get Ր() : int;
      
      function get Ց() : Boolean;
      
      function set Ց(param1:Boolean) : void;
      
      function ѐ() : InteractiveObject;
      
      function setFocus(param1:InteractiveObject) : void;
      
      function Ւ() : void;
      
      function Փ() : void;
      
      function activate() : void;
      
      function deactivate() : void;
      
      function Ք(param1:InteractiveObject) : InteractiveObject;
      
      function Օ(param1:Boolean = false) : InteractiveObject;
      
      function get form() : DisplayObjectContainer;
      
      function set form(param1:DisplayObjectContainer) : void;
   }
}
