package Controller
{
   import model.LogApplication;
   import zebra.Game;
   import view.Container;
   import view.SentLogView;
   import view.SceneView;
   import view.PopMessageView;
   
   public class StageControl
   {
           
      public var logappliction:LogApplication;
      
      public function StageControl()
      {
         this.logappliction = new LogApplication();
         super();
      }
      
      public static function parse(rawdata:String, param2:int = 0) : *
      {
    	  rawdata = RemoveSpecialCharacters(rawdata);
         switch(param2)
         {
            case 0:
               SceneView(Game.Content.getView(SceneView)).AddFontColor(ComposeStatusTxt(rawdata));
               break;
            case 1:
               stage1(rawdata);
               break;
            case 2:
               stage2-3server(rawdata);
               break;
            case 3:
               stage2-3latest(rawdata);
         }
      }
      
      private static function ComposeStatusTxt(rawdata:String) : *
      {
         var _bidcount:* = undefined;
         var _type:* = undefined;
         var _txt:* = undefined;
         var _responseobject:Object = new Object();
      	_responseobject = JSON.parse(rawdata);
         var _responsecode:String = _responseobject.response.responsecode;
         if(_responsecode == "0" && _responseobject.response.data.results != null && _responseobject.response.data.results[0] != null)
         {
            _bidcount = _responseobject.response.data.results[0].bidcount;
            _type = _responseobject.response.data.results[0].type;
            _txt = "您第" + _bidcount + "次出价\n";
            _txt = _txt + ("出价金额:" + _responseobject.response.data.results[0].bidamount + "\n");
            _txt = _txt + ("出价时间:" + ϱ(_responseobject.response.data.results[0].dealtime) + "\n");
            if(_type == "1")
            {
            	_txt = _txt + "出价方式:网络出价";
            }
            else
            {
            	_txt = _txt + "出价方式:电话出价";
            }
            return _txt;
         }
         return "";
      }
      
      private static function stage1(rawdata:String) : void
      {
         var _responsemsg:String = null;
         var _bidamount:* = undefined;
         var _bidcount:* = undefined;
         var _dealtime:* = undefined;
         var _type:* = undefined;
         var _msg:String = null;
         var _txt:* = undefined;
         var _responseobject:Object = JSON.parse(rawdata);
         var _responsecode:String = _responseobject.response.responsecode;
         if(_responsecode != "0")
         {
            if(_responsecode == "2101")
            {
            	_responsemsg = _responseobject.response.responsemsg;
               Container.DisplayCurrentObject(new PopMessageView(_responsemsg,true));
            }
         }
         else if(_responseobject.response.data != null)
         {
            if(_responseobject.response.data[0] != null)
            {
               _bidamount = _responseobject.response.data[0].bidamount;
               _bidcount = _responseobject.response.data[0].bidcount;
               _dealtime = _responseobject.response.data[0].dealtime;
               _type = _responseobject.response.data[0].type;
               _msg = _responseobject.response.data[0].msg;
               _txt = "您第" + _bidcount + "次出价\n";
               _txt = _txt + ("出价金额:" + _bidamount + "\n");
               _txt = _txt + ("出价时间:" + _loc7_ + "\n");
               if(_type == "1")
               {
            	   _txt = _txt + "出价方式:网络出价";
               }
               else
               {
            	   _txt = _txt + "出价方式:电话出价";
               }
               SceneView(Game.Content.getView(SceneView)).AddFontColor(_txt);
            }
         }
      }
      
      private static function stage2-3latest(rawdata:String) : void
      {
         var _responsemsg:String = null;
         var _bidamount:* = undefined;
         var _bidcount:* = undefined;
         var _dealtime:* = undefined;
         var _type:* = undefined;
         var _msg:String = null;
         var _txt:* = undefined;
         var _currenttime:Date = new Date();
         var _currenttimestr:String = String(_currenttime.getHours()) + ":" + String(_currenttime.getMinutes()) + ":" + String(_currenttime.getSeconds());
         SentLogView(Game.Content.getView(SentLogView)).info("投标板块,2-3http最新出价情况,当前时间" + _currenttimestr + ",数据：" + rawdata);
         var _responseobject:Object = JSON.parse(rawdata);
         var _responsecode:String = _responseobject.response.responsecode;
         if(_responsecode != "0")
         {
            if(_responsecode == "2101")
            {
               _responsemsg = _responseobject.response.responsemsg;
               Container.DisplayCurrentObject(new PopMessageView(_responsemsg,true));
            }
            else
            {
               Container.removechildren();
            }
         }
         else if(_responseobject.response.data[0] != null)
         {
            _bidamount = responseobject.response.data[0].bidamount;
            _bidcount = responseobject.response.data[0].bidcount;
            _dealtime = responseobject.response.data[0].dealtime;
            _type = responseobject.response.data[0].type;
            _msg = responseobject.response.data[0].msg;
            _txt = "您第" + _bidcount + "次出价\n";
            _txt = _txt + ("出价金额:" + _bidamount + "\n");
            _txt = _txt + ("出价时间:" + _dealtime + "\n");
            if(_type == "1")
            {
            	_txt = _txt + "出价方式:网络出价";
            }
            else
            {
            	_txt = _txt + "出价方式:电话出价";
            }
            SceneView(Game.Content.getView(SceneView)).AddFontColor(_txt);
            Container.DisplayCurrentObject(new PopMessageView(_msg));
         }
         else
         {
            Container.removechildren();
         }
      }
      
      private static function stage2-3server(rawdata:String) : void
      {
         var _bidamount:* = undefined;
         var _bidcount:* = undefined;
         var _bidtime:* = undefined;
         var _type:* = undefined;
         var _msg:String = null;
         var _servertime:String = null;
         var _dealtime:String = null;
         var _dealtime2:String = null;
         var _msg2:String = null;
         var _currentdate:Date = null;
         var _currentdatestr:String = null;
         var _txt:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _responseobject:Object = JSON.parse(rawdata);
         var _responsecode:String = _responseobject.response.responsecode;
         if(_responsecode == "0")
         {
            _bidamount = _responseobject.response.data.bidamount;
            _bidcount = _responseobject.response.data.bidcount;
            _bidtime = _responseobject.response.data.bidtime;
            _type = _responseobject.response.data.type;
            _msg = _responseobject.response.data.msg;
            _servertime = _responseobject.servertime;
            _dealtime = _responseobject.response.data.dealtime;
            _dealtime2 = _dealtime.substring(0,_dealtime.length - 4);
            _msg2 = _msg;
            //已经出价
            if(_bidcount != "0")
            {
            	_txt = "您第" + _bidcount + "次出价\n";
            	_txt = _txt + ("出价金额:" + _bidamount + "\n");
            	_txt = _txt + ("出价时间:" + _dealtime2 + "\n");
               if(_type == "1")
               {
            	   _txt = _txt + "出价方式: 网络出价";
               }
               else
               {
            	   _txt = _txt + "出价方式: 电话出价";
               }
               SceneView(Game.Content.getView(SceneView)).AddFontColor(_txt);
               Container.DisplayCurrentObject(new PopMessageView(_msg2));
            }
            //还未出价
            else
            {
            	_txt = "您第" + _bidcount + "次出价\n";
            	_txt = _txt + ("出价金额:" + _bidamount + "\n");
            	_txt = _txt + ("出价时间:" + _loc11_ + "\n");
               if(_type == "1")
               {
            	   _txt = _txt + "出价方式:网络出价";
               }
               else
               {
            	   _txt = _txt + "出价方式:电话出价";
               }
               SceneView(Game.Content.getView(SceneView)).AddFontColor(_txt);
               Container.DisplayCurrentObject(new PopMessageView(_msg2));
            }
            _currentdate = new Date();
            _currentdatestr = String(_currentdate.getHours()) + ":" + String(_currentdate.getMinutes()) + ":" + String(_currentdate.getSeconds());
            SentLogView(Game.Content.getView(SentLogView)).info("投标板块,接收出价情况2-3,当前时间:" + _currentdatestr + ",server time:" + _servertime);
         }
         else
         {
            _loc16_ = _responseobject.response.data.bidamount;
            _loc17_ = _responseobject.response.data.bidtime;
            _loc18_ = _responseobject.response.data.msg;
            _loc19_ = _responseobject.servertime;
            _loc20_ = _responseobject.response.data.dealtime;
            _loc21_ = "";
            if(_responsecode != "4019")
            {
               _loc21_ = _loc20_.substring(0,_loc20_.length - 4);
            }
            else
            {
               _loc21_ = _loc20_;
            }
            _loc22_ = _loc18_ + "\n" + "出价金额:" + _loc16_ + "元" + "\n" + "系统处理时间:" + _loc21_;
            Container.DisplayCurrentObject(new PopMessageView(_loc22_));
         }
      }
      
      private static function ϰ(param1:String) : String
      {
         var _loc2_:String = null;
         if(SceneView(Game.Content.getView(SceneView)).bidcode != 4)
         {
            if(param1.indexOf("000") != -1)
            {
               _loc2_ = param1.substring(0,param1.length - 4);
            }
         }
         else
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      private static function ϱ(param1:String) : String
      {
         var _loc2_:String = param1;
         if(param1.indexOf("000") != -1)
         {
            _loc2_ = param1.substring(0,param1.length - 4);
         }
         return _loc2_;
      }
      
      public static function RemoveSpecialCharacters(param1:String) : String
      {
         var _loc2_:String = param1;
         _loc2_ = _loc2_.replace(/>/g,"").replace(/</g,"").replace(/&/g,"");
         return _loc2_;
      }
   }
}
