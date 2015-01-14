package BaseScene.tScene.scene
{
	import BaseScene.core.AScene;
	import BaseScene.core.IScene;
	import BaseScene.tScene.view.MusicView;
	
	import BaseUI.JStageManager;
	
	public class MusicScene extends AScene implements IScene
	{
		private static var _instance:MusicScene;
		public static function getInstance():MusicScene
		{
			if(null == _instance)
			{
				_instance  = new MusicScene();	
			}
			return _instance
		}
		public function MusicScene()
		{
			super();
		}
		
		override protected function initClass():void
		{
			
		}
				
		private var musicView:MusicView;
		override public function initScence():void
		{
			musicView = MusicView.creatView();
			JStageManager.instance.addToDisplay(musicView);
		}
		
		override public function EnterScene(data:*=null):void
		{
			musicView.toShow();
		}
		
		override public function LeaveScence():void
		{
			musicView.toSleep();
			JStageManager.instance.removeToDisplay(musicView);
		}
	}
}