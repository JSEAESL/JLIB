package BaseFacade.interfaces
{
	public interface IView
	{

		function registerObserver( notificationName:String, observer:IObserver ) : void

		function removeObserver( notificationName:String, notifyContext:Object ):void

		function registerMediator( mediator:IMediator ) : void

		function retrieveMediator( mediatorName:String ) : IMediator
		
		function removeMediator( mediatorName:String ) : IMediator
		
		function hasMediator( mediatorName:String ) : Boolean
		
		function getMediatorArray() : Array
	}
}