package BaseFacade.patterns.proxy
{
	import BaseFacade.interfaces.INotifier;
	import BaseFacade.interfaces.IProxy;
	import BaseFacade.patterns.observer.Notifier;

	public class JProxy extends Notifier implements IProxy, INotifier
	{
		public static var Name:String = "JProxy"
			
		private var ProxyName:String;
		private var Data:Object;
		public function JProxy(proxyName:String,data:Object)
		{
			this.ProxyName = proxyName;
			if(null != data)
				setData(data);
		}
		
		public function onRegister():void
		{
			
		}
		
		public function getProxyName():String
		{
			return ProxyName;
		}
		
		public function getData():Object
		{
			return null;
		}
		
		public function setData(data:Object):void
		{
			this.Data = data
		}
	}
}