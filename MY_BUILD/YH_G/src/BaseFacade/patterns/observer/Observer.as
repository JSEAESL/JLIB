package BaseFacade.patterns.observer
{
	import BaseFacade.interfaces.INotification;
	import BaseFacade.interfaces.IObserver;
	
	public class Observer implements IObserver
	{
		private var notify:Function;
		private var context:Object;
		
		public function Observer(notifyMethod:Function,notifyContext:Object)
		{
			setNotifyMethod(notifyMethod);
			setNotifyContext(notifyContext);
		}
		
		public function setNotifyMethod(notifyMethod:Function):void
		{
			notify = notifyMethod
		}
		
		public function setNotifyContext(notifyContext:Object):void
		{
			context = notifyContext
		}
		
		public function notifyObserver(notification:INotification):void
		{
			notify.apply(context,[notification]);
		}
		
		public function compareNotifyContext(object:Object):Boolean
		{
			return object == context;
		}
	}
}