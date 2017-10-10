package zebra
{
   import flash.display.Stage;
   import flash.system.ApplicationDomain;
   import zebra.directEvent.DirectEventManager;
   import zebra.directEvent.IDirectEventManager;
   import zebra.core.GameTimeUpdate;
   import zebra.data.GameDataService;
   import zebra.system.net.GameSocketThread;
   import zebra.graphics.GraphicsDeviceManager;
   import zebra.input.KeyInput;
   import zebra.input.MouseInput;
   import zebra.content.GameContent;
   import zebra.system.GameHack;
   
   public class Game
   {
      
      private static var _initialized:Boolean;
      
      private static var _gameContent:GameContent;
      
      private static var _graphicsDeviceManager:GraphicsDeviceManager;
      
      private static var _mouseInput:MouseInput;
      
      private static var _gamehack:GameHack;
      
      private static var _gametimeUpdate:GameTimeUpdate;
      
      private static var _gameDirectEventManager:IDirectEventManager;
      
      private static var _keyInput:KeyInput;
      
      private static var _gameDataService:GameDataService;
      
      private static var _IsDebugMode:Boolean;
      
      private static var _socketThread:GameSocketThread;
       
      
      public function Game(param1:Stage)
      {
         super();
         if(_initialized)
         {
            throw new Error(" Game FrameWork is Initialized ");
         }
         _gamehack = new GameHack();
         _gamehack.keepframe();
         _graphicsDeviceManager = new GraphicsDeviceManager(param1);
         _gametimeUpdate = new GameTimeUpdate();
         _gameContent = new GameContent();
         _mouseInput = new MouseInput(param1);
         _gameDirectEventManager = new DirectEventManager();
         _keyInput = new KeyInput();
         _gameDataService = new GameDataService();
         _socketThread = new GameSocketThread();
         _IsDebugMode = true;
         _initialized = true;
      }
      
      public static function get INITIALIZED() : Boolean
      {
         return _initialized;
      }
      
      public static function get Content() : GameContent
      {
         return _gameContent;
      }
      
      public static function get currentApplicationDomain() : ApplicationDomain
      {
         return _graphicsDeviceManager.stage.loaderInfo.applicationDomain;
      }
      
      public static function get graphicsDeviceManager() : GraphicsDeviceManager
      {
         return _graphicsDeviceManager;
      }
      
      public static function get DataService() : GameDataService
      {
         return _gameDataService;
      }
      
      public static function get Hack() : GameHack
      {
         return _gamehack;
      }
      
      public static function get DirectEvent() : IDirectEventManager
      {
         return _gameDirectEventManager;
      }
      
      public static function get TimeUpdate() : GameTimeUpdate
      {
         return _gametimeUpdate;
      }
      
      public static function get mouseInput() : MouseInput
      {
         return _mouseInput;
      }
      
      public static function get keyInput() : KeyInput
      {
         return _keyInput;
      }
      
      public static function get SocketThread() : GameSocketThread
      {
         return _socketThread;
      }
      
      public static function get IsDebugMode() : Boolean
      {
         return false;
      }
   }
}
