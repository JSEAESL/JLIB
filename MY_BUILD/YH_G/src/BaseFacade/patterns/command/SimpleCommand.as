package BaseFacade.patterns.command
{
	import BaseFacade.interfaces.ICommand;
	import BaseFacade.interfaces.INotification;
	import BaseFacade.interfaces.INotifier;
	import BaseFacade.patterns.observer.Notifier;
	
	public class SimpleCommand extends Notifier implements ICommand, INotifier
	{
		public function execute(notification:INotification):void
		{
		}
	}
}