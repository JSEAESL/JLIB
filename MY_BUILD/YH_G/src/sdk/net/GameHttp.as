package sdk.net
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	internal class GameHttp
	{
		private var gateUrl:String;
		private var vars:URLVariables;
		private var callback:Function;
		private var context:Object;
		public function GameHttp(gateUrl:String,vars:URLVariables,callback:Function)
		{
			this.gateUrl=gateUrl;
			this.vars=vars;
			this.callback=callback;
			this.context=context;
		}
		public function post():void
		{
			var request:URLRequest=new URLRequest(gateUrl);
			request.method=URLRequestMethod.POST;
			request.data=vars;
			
			var loader:URLLoader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,onHttpOK);
			loader.load(request);
		}
		private function onHttpOK(event:Event):void
		{
			var loader:URLLoader=event.target as URLLoader;
			loader.removeEventListener(Event.COMPLETE,onHttpOK);
			if(callback!=null)
			{
				var json:Object=JSON.parse(loader.data);
				switch(callback.length)
				{
					case 0:
						callback();
						break;
					case 1:
						callback(json);
						break;
					default:
						throw new Error("Illegal argument count!");
				}
			}
		}
	}
}