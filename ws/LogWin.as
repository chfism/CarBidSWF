package ws
{
   import flash.display.MovieClip;
   import fl.controls.Button;
   import fl.controls.TextArea;
   
   public dynamic class LogWin extends MovieClip
   {
       
      
      public var closeBut:MovieClip;
      
      public var localSaveBut:Button;
      
      public var log:TextArea;
      
      public var sentLogDataBut:Button;
      
      public function LogWin()
      {
         super();
         this.__setProp_sentLogDataBut_元件9_图层1_0();
         this.__setProp_localSaveBut_元件9_图层1_0();
      }
      
      function __setProp_sentLogDataBut_元件9_图层1_0() : *
      {
         try
         {
            this.sentLogDataBut["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sentLogDataBut.ҁ = false;
         this.sentLogDataBut.enabled = true;
         this.sentLogDataBut.label = "提交到服务器";
         this.sentLogDataBut.labelPlacement = "right";
         this.sentLogDataBut.selected = false;
         this.sentLogDataBut.tomd5_ggle = false;
         this.sentLogDataBut.visible = true;
         try
         {
            this.sentLogDataBut["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      function __setProp_localSaveBut_元件9_图层1_0() : *
      {
         try
         {
            this.localSaveBut["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.localSaveBut.ҁ = false;
         this.localSaveBut.enabled = true;
         this.localSaveBut.label = "保持到本地";
         this.localSaveBut.labelPlacement = "right";
         this.localSaveBut.selected = false;
         this.localSaveBut.tomd5_ggle = false;
         this.localSaveBut.visible = true;
         try
         {
            this.localSaveBut["componentInspectorSetting"] = false;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
