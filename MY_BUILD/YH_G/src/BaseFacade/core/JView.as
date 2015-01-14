package BaseFacade.core
{
	import BaseFacade.interfaces.IMediator;
	import BaseFacade.interfaces.IObserver;
	import BaseFacade.interfaces.IView;
	import BaseFacade.patterns.observer.Observer;
	
	public class JView implements IView
	{
		public function JView(insClass:InstanceClass,key:String)
		{
			if( null == key) 
				throw new Error("not find key");
				m_key = key;
				mediatorMap = [];
				observerMap = [];
				initView();
		}
		
		private static var instanceMap : Array = [];

		private var mediatorMap:Array = [];
		private var observerMap:Array = [];
		
		private var m_key:String;
		public static function getInstance(key:String):JView
		{
			if(null == instanceMap[key])
			{
				instanceMap[key] = new JView(new InstanceClass(),key);
			}
			return instanceMap[key]
			
		}
		
		protected function initView():void
		{
			
		}
		
		public function registerObserver( notificationName:String, observer:IObserver ):void
		{
			if(observerMap[notificationName] != null)
			{
				observerMap[notificationName].push(observer);
			}else
			{
				observerMap[notificationName] = [observer];
			}
		}
		
		public function removeObserver(notificationName:String, notifyContext:Object):void
		{

		}
		
		public function registerMediator(mediator:IMediator):void
		{
			if(mediatorMap[mediator.getMediatorName()] == null)
			{
				mediatorMap[mediator.getMediatorName()] = mediator;
				
				var interests:Array = mediator.listNotificationInterests();
				
				if(interests.length >0)
				{
					var observer:Observer = new Observer( mediator.handleNotification, mediator );	
					for(var index:int = interests.length; index>0; index--)
					{
						registerObserver(mediator.getMediatorName(),observer)
					}
				}
				mediator.onRegister();
			}
		}
		
		public function retrieveMediator(mediatorName:String):IMediator
		{
			return null;
		}
		
		public function removeMediator(mediatorName:String):IMediator
		{
			return null;
		}
		
		public function hasMediator(mediatorName:String):Boolean
		{
			return false;
		}
		
		public function getMediatorArray():Array
		{
			return null;
		}
	}
}
class InstanceClass{}