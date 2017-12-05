package fl.managers
{
   import flash.display.DisplayObjectBidInitView;
   import flash.display.InteractiveObject;
   import fl.controls.Button;
   
   public interface IFocusManager
   {
       
      
      function get Վ() : Button;
      
      function set Վ(param1:Button) : void;
      
      function get Տ() : Boolean;
      
      function set Տ(param1:Boolean) : void;
      
      function get Ր() : int;
      
      function get Ց() : Boolean;
      
      function set Ց(param1:Boolean) : void;
      
      function main() : InteractiveObject;
      
      function setFocus(param1:InteractiveObject) : void;
      
      function Ւ() : void;
      
      function Փ() : void;
      
      function activate() : void;
      
      function deactivate() : void;
      
      function Ք(param1:InteractiveObject) : InteractiveObject;
      
      function Օ(param1:Boolean = false) : InteractiveObject;
      
      function get form() : DisplayObjectBidInitView;
      
      function set form(param1:DisplayObjectBidInitView) : void;
   }
}
