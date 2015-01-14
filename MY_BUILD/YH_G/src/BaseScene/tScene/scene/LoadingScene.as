package BaseScene.tScene.scene
{
	import BaseScene.core.AScene;
	import BaseScene.core.IScene;
	import BaseScene.tScene.view.LoadingView;
	
	import BaseUI.JStageManager;
	
	public class LoadingScene extends AScene implements IScene
	{
		private static var _instance:LoadingScene;
		
		public static function getInstance():LoadingScene
		{
			if(null == _instance)
			{
				_instance = new LoadingScene();
			}
			return _instance;
		}

		public function LoadingScene()
		{
			super();
		}

		override protected function initClass():void
		{
			
		}
		
		override public function EnterScene(data:*=null):void
		{
			loadingView.toShow();
		}
		
		private var loadingView:LoadingView;
		override public function initScence():void
		{
			loadingView = LoadingView.creatView();
			JStageManager.instance.addToDisplay(loadingView);
		}
		
		override public function LeaveScence():void
		{
			loadingView.toSleep();
			JStageManager.instance.removeToDisplay(loadingView);
		}
	}
}