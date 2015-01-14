package BaseScene.tScene.scene
{
	import BaseScene.core.AScene;
	import BaseScene.core.IScene;
	import BaseScene.tScene.view.TestView;
	
	import BaseUI.JStageManager;
	
	public class TestScene extends AScene implements IScene
	{
		private  static var _instance:TestScene;
		
		public static function getInstance():TestScene
		{
			if(null== _instance)
			{
				_instance = new TestScene();
			}
			return _instance;
		}
		public function TestScene()
		{
			super();
		}
		
		override protected function initClass():void
		{
			
		}
		
		override public function EnterScene(data:*=null):void
		{
			testView.toShow();
		}
		
		private var testView:TestView;
		override public function initScence():void
		{
			testView = TestView.creatView();
			JStageManager.instance.addToDisplay(testView);
		}
		
		override public function LeaveScence():void
		{
			testView.toSleep();
			JStageManager.instance.removeToDisplay(testView);
		}
	}
}