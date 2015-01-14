package BaseFacade.patterns.observer
{
	import BaseFacade.interfaces.INotifier;
	import BaseFacade.patterns.facade.JBaseFacade;

	public class Notifier implements INotifier
	{
		public function Notifier()
		{
		}
		
		public function sendNotifer(name:String, data:Object, key:String):void
		{
		}
		
		public function get facade():JBaseFacade
		{
			if(!key) throw new Error("not find JBaseFacade key");
			return JBaseFacade.getInstance(key);
		}
		
		public var key:String;
		
	}
}