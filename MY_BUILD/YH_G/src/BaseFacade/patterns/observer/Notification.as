package BaseFacade.patterns.observer
{
	import BaseFacade.interfaces.INotification;
	
	public class Notification implements INotification
	{
		
		private var Name:String;
		private var Data:Object;
		private var Key:String;
		public function Notification(name:String,data:Object,key:String)
		{
			Name = name;
			Data = data;
			Key = key;
		}
		
		public function getName():String
		{
			return Name;
		}
		
		public function getData():Object
		{
			return Data;
		}
		
		public function getKey():String
		{
			return Key;
		}
	}
}