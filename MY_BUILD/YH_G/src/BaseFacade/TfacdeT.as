package BaseFacade
{
	import BaseFacade.patterns.facade.JBaseFacade;

	public class TfacdeT
	{
		public static var TEST_MSG:String = "TEST_MSG"
		public function TfacdeT()
		{
			init();
		}
		
		private function init():void
		{
			JBaseFacade.getInstance(TEST_MSG);			
		}
		private function reg():void
		{
			//JBaseFacade.getInstance(TEST_MSG).regMediator()
			//JBaseFacade.getInstance(TEST_MSG).regProxy()
		}
		
		
	}
}