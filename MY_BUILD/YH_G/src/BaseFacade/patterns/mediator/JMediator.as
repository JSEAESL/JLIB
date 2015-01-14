package BaseFacade.patterns.mediator
{
	import BaseFacade.interfaces.IMediator;
	import BaseFacade.interfaces.INotification;
	import BaseFacade.interfaces.INotifier;
	import BaseFacade.patterns.observer.Notifier;
	
	public class JMediator extends Notifier implements INotifier, IMediator
	{
		private var MediatorName:String;
		private var ViewComponent:Object;
		public function JMediator(mediatorName:String, viewComponent:Object)
		{
			MediatorName = mediatorName;
			ViewComponent = viewComponent;
		}
		
		public function onRegister():void
		{
			
		}
		
		
		public function getMediatorName():String
		{
			return null;
		}
		
		public function listNotificationInterests():Array
		{
			return null;
		}
		
		public function handleNotification(notification:INotification):void
		{
		}
	}
}