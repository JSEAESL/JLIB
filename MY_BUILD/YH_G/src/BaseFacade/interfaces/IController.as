package BaseFacade.interfaces
{
	public interface IController
	{
		function registerCommand( notificationName : String, commandClassRef : Function ):void;
		function executeCommand( notification : INotification ):void;
		function removeCommand( notificationName : String ):void;
		function hasCommand( notificationName:String ) : Boolean;
	}
}