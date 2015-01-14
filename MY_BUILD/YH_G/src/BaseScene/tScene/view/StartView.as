package BaseScene.tScene.view
{
	import BaseScene.core.JSceneStateMachine;
	import BaseScene.tScene.AView;
	import BaseScene.tScene.IView;
	import BaseScene.tScene.scene.BlackScene;
	import BaseScene.tScene.scene.MusicScene;
	import BaseScene.tScene.scene.TestScene;
	
	import BaseUI.BaseSprite;
	import BaseUI.JAutoLayout;
	import BaseUI.JStageManager;
	import BaseUI.old.JAButton;
	import BaseUI.old.JButtonDeco;
	
	public class StartView extends AView implements IView
	{
		public function StartView()
		{
			super();
		}

		
		private var drawBg:BaseSprite
		
		private var btnstr:Array = ["start","music","3D","test"]
		private var FunList:Array = [toStartFun,toMusicFun,DFun,TestFun]

		override protected function initView():void
		{			drawBg = BaseSprite.creatSprite(null);
			addChild(drawBg);

			for(var index:int = 0; index<btnstr.length; index++)
			{
				var tBtn:JButtonDeco= new JButtonDeco(btnstr[index],new JAButton(FunList[index]));
				JAutoLayout.addNom(tBtn);
				addChild(tBtn);
			}
			

			
			

			
		/*	JAutoLayout.oneBestCenter(startBtn);
			JAutoLayout.twoBestCenter(musicBtn);
			JAutoLayout.threeBestCenter(testBtn);*/
		
			
		}
		
		private function TestFun():void
		{
			JSceneStateMachine.getInstance().changeScene(BlackScene.getInstance())				

		}
		
		private function DFun():void
		{
			JStageManager.instance.stage3DT()				
		}
		
		private function toStartFun():void
		{
			JSceneStateMachine.getInstance().changeScene(TestScene.getInstance());

		}
		
		private function toMusicFun():void
		{
			JSceneStateMachine.getInstance().changeScene(MusicScene.getInstance());
		}
		
		private static var View:StartView;
		public static function creatView():StartView
		{
			if(null == View)
			{
				View = new StartView();				
			}
			return View;
		}
		
		override public function toShow():void
		{
			
		}
		
		override public function toSleep():void
		{
			
		}
		
		override public function toHide():void
		{
			
		}
		
		override public function destroy():void
		{
			
		}
		

	}
}