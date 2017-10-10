package ws
{
   import flash.display.MovieClip;
   import Controls.textboxcontrol;
   import Controls.textfieldcontrol;
   
   public dynamic class SentLogWindow extends MovieClip
   {
       
      
      public var closeBut:MovieClip;
      
      public var localSaveBut:textboxcontrol;
      
      public var log:textfieldcontrol;
      
      public var sentLogDataBut:textboxcontrol;
      
      public function SentLogWindow()
      {
         super();
         this.§͂§();
         this.§̓§();
      }
      
      function §͂§() : *
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
      
      function §̓§() : *
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
