package BaseFacade.interfaces
{
	public interface IFacade extends INotifier
	{
		function regProxy(Proxy:IProxy):void
		function regMediator(Mediator:IMediator):void
		function registerCommand( noteName : String, commandClassRef : Function ) : void

		
		function retProxy(ProxyName:String):void
		function retMediator(MediatorName:String):void
		
	}
}