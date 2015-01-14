package BaseScene.core
{
	public class AScene implements IScene
	{
		

		protected var isComplete:Boolean = false
		
		public function AScene()
		{	
			initClass();
		}
		
		protected function initClass():void
		{
			
		}
		
		public function EnterScene(data:* = null):void
		{
		}
		
		public function LeaveScence():void
		{
		}
		
		public function initScence():void
		{
			if(!isComplete)
			{
				initClass();	
				isComplete = true;
			}
		}
	}
}