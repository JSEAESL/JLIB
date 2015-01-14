package sdk
{
	import flash.utils.Dictionary;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class NotificationCenter extends EventDispatcher
	{
		private static var _inst:NotificationCenter=null;
		public static function inst():NotificationCenter
		{
			if(_inst==null) new NotificationCenter();
			return _inst;
		}
		private var typeHandlers:Dictionary=new Dictionary();
		public function NotificationCenter()
		{
			if(_inst!=null) throw new Error("NotificationCenter is a singleton!");
			_inst=this;
		}
		private function getFunctions(type:String):Vector.<Function>
		{
			if(typeHandlers[type]==null)
			{
				typeHandlers[type]=new Vector.<Function>();
			}
			return typeHandlers[type];
		}
		public function postEvent(type:String,args:Object):void
		{
			var funs:Vector.<Function>=getFunctions(type);
			var temp:Vector.<Function>=new Vector.<Function>();
			for each(var fun:Function in funs)
			{
				temp.push(fun);
			}
			for each(fun in temp)
			{
				switch(fun.length)
				{
					case 0:
						fun();
						break;
					case 1:
						fun(type);
						break;
					case 2:
						fun(type,args);
						break;
					default:
						throw new Error("Illegal argument count.");
				}
			}
		}
		public function register(type:String,callback:Function):void
		{
			getFunctions(type).push(callback);
		}
		public function unregister(type:String,callback:Function):void
		{
			var funs:Vector.<Function>=getFunctions(type);
			var index:int=funs.indexOf(callback);
			if(index!=-1) funs.splice(index,1);
		}
		public function changed():void
		{
			this.dispatchEventWith(Event.CHANGE);
		}
	}
}