package BaseScene.tScene.scene
{
	import BaseScene.core.AScene;
	import BaseScene.core.IScene;
	import BaseScene.tScene.view.StartView;
	
	import BaseUI.JStageManager;
	
	public class StartScene extends AScene implements IScene
	{
		private  static var _instance:StartScene;
		
		public static function getInstance():StartScene
		{
			if(null== _instance)
			{
				_instance = new StartScene();
			}
			return _instance;
		}
		
		public function StartScene()
		{
			super();
		}
		
		override protected function initClass():void
		{
			
		}
		
		override public function EnterScene(data:*=null):void
		{
			startView.toShow();
		}
		
		private var startView:StartView;
		override public function initScence():void
		{
			startView = StartView.creatView();
			JStageManager.instance.addToDisplay(startView);
		}
		
		override public function LeaveScence():void
		{
			startView.toSleep();
			JStageManager.instance.removeToDisplay(startView);
		}
		

	}
}