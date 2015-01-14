package BaseFacade.core
{
	import BaseFacade.interfaces.IModel;
	import BaseFacade.interfaces.IProxy;
	
	public class JModel implements IModel
	{
		public function JModel(insClass:InstanceClass,key:String)
		{
			if(null == key)	return;
			proxyMap = [];
			initModel();
		}
		
		protected function initModel():void
		{
			
		}
		
		private static var instanceMap:Array = [];
		private var proxyMap:Array;
		public static function getInstance(key:String):JModel
		{
			if(null == instanceMap[key])
			{
				instanceMap[key] = new JModel(new InstanceClass(),key)
			}
			return instanceMap[key];
		}
		
		public function registerProxy(proxy:IProxy):void
		{
			proxyMap[proxy.getProxyName()] = proxy;
			proxy.onRegister();
		
		}
		
		public function retrieveProxy(proxyName:String):IProxy
		{
			return null;
		}
		
		public function removeProxy(proxyName:String):IProxy
		{
			return null;
		}
		
		public function hasProxy(proxyName:String):Boolean
		{
			return false;
		}
	}
}
class InstanceClass{}