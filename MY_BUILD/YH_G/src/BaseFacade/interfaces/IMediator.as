package BaseFacade.interfaces
{
	public interface IMediator
	{
		function onRegister():void
		
		function getMediatorName():String
			
		function listNotificationInterests( ):Array
			
		function handleNotification( notification:INotification ):void

	}
}