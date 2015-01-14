package BaseScene.tScene.scene
{
	import BaseScene.core.AScene;
	import BaseScene.core.IScene;
	import BaseScene.tScene.view.BlackView;
	
	import BaseUI.JStageManager;
	
	public class BlackScene extends AScene implements IScene
	{		
		private static var _instance:BlackScene;
		public function BlackScene()
		{
			super();
		}
		public static function getInstance():BlackScene
		{
			if(_instance == null);
			{
				_instance = new BlackScene();
			}
			return _instance;
		}
		
		override protected function initClass():void
		{
			
		}
		
		override public function EnterScene(data:*=null):void
		{
			blackView.toShow();
		}
		
		private var blackView:BlackView;
		override public function initScence():void
		{
			blackView = BlackView.creatView();
			JStageManager.instance.addToDisplay(blackView);
		}
		
		override public function LeaveScence():void
		{
			blackView.toSleep();
			JStageManager.instance.removeToDisplay(blackView);
		}
	}
	
}