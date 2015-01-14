package BaseFacade.core
{
	import BaseFacade.interfaces.IController;
	import BaseFacade.interfaces.INotification;
	
	public class JController implements IController
	{
		private static var MSG:String = ""
		public function JController(insClass:InstanceClass,key:String)
		{
			if(null == key) throw Error(MSG);
			commandMap = [];
			initController();
		}
		
		private static var instanceMap:Array = [];
		private static var commandMap:Array;
		public static function getInstance(key:String):JController
		{
			if(null == instanceMap[key])
			{
				instanceMap[key] = new JController(new InstanceClass(),key)
			}

			return instanceMap[key]

		}

		protected function initController():void
		{

		}

		public function registerCommand(notificationName:String, commandClassRef:Function):void
		{
		}
		
		public function executeCommand(notification:INotification):void
		{
		}
		
		public function removeCommand(notificationName:String):void
		{
		}
		
		public function hasCommand(notificationName:String):Boolean
		{
			return false;
		}
	}
}
class InstanceClass{}