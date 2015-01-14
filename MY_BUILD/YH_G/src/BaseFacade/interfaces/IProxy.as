package BaseFacade.interfaces
{
	public interface IProxy
	{
		function onRegister():void

		function getProxyName():String
			
		function getData():Object
		
		function setData(data:Object):void
	}
}