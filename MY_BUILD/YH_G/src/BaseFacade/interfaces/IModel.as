package BaseFacade.interfaces
{
	public interface IModel
	{

		function registerProxy( proxy:IProxy ) : void;
		function retrieveProxy( proxyName:String ) : IProxy;
		
		function removeProxy( proxyName:String ) : IProxy;
		function hasProxy( proxyName:String ) : Boolean;
	}
}