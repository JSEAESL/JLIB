package BaseScene.tScene.view
{
	
	import flash.system.Worker;
	
	import BaseMusic.JSoundManager;
	import BaseMusic.JSoundSpectrum;
	
	import BaseScene.core.JSceneStateMachine;
	import BaseScene.tScene.AView;
	import BaseScene.tScene.IView;
	import BaseScene.tScene.scene.StartScene;
	
	import BaseUI.BaseSprite;
	import BaseUI.JStageManager;
	import BaseUI.old.JAButton;
	import BaseUI.old.JButtonDeco;
	
	public class MusicView extends AView implements IView
	{
		public function MusicView()
		{
			super()		
		}
		
		private var drawBg:BaseSprite
		override protected function initView():void
		{
			var btn1:JButtonDeco = new JButtonDeco("1",new JAButton(playMusic,["1"]));
			var btn0:JButtonDeco = new JButtonDeco("0",new JAButton(playMusic,["0"]));
			var btn2:JButtonDeco = new JButtonDeco("2",new JAButton(playMusic,["2"]));
			var btnPlay:JButtonDeco = new JButtonDeco("播放",new JAButton(playNow));
			var btnStop:JButtonDeco = new JButtonDeco("停止",new JAButton(stopMusic));
			var btnBack:JButtonDeco = new JButtonDeco("返回",new JAButton(backFun));
			var aaa:Worker
			btn0.x  = 150;
			btn0.y = 550;
			btn1.x  = 200;
			btn1.y = 550;
			btn2.x = 250;
			btn2.y = 550;
			
			btnPlay.x  = 250;
			btnPlay.y = 600;
			btnStop.x  = 300;
			btnStop.y = 600;
			btnBack.x = 350
			btnBack.y = 600;	
			drawBg = BaseSprite.creatSprite(0x111111);

			addChild(drawBg);
			addChild(btn0);
			addChild(btn1);
			addChild(btn2);
			addChild(btnPlay);
			addChild(btnStop);
			addChild(btnBack);
			var a:JSoundSpectrum = JSoundSpectrum.creat();
			addChild(a);
			JStageManager.instance.setEasyDraw(a);
			function playMusic(id:String):void
			{
				JSoundManager.getInstance().selectNowBgm(id);
			}
			function playNow():void
			{
				JSoundManager.getInstance().playNowBgm();
				a.start();
			}
			function stopMusic():void
			{
				JSoundManager.getInstance().stopBgm();
			}
			function backFun():void
			{
				JSceneStateMachine.getInstance().changeScene(StartScene.getInstance());
			}

			
		}
		
		private static var View:MusicView;
		public static function creatView():MusicView
		{
			if(null == View)
			{
				View = new MusicView();				
			}
			return View;
		}
		
		override public function toShow():void
		{
		}
		
		override public function toHide():void
		{
		}
		
		override public function toSleep():void
		{
		}
		
		override public function destroy():void
		{
		}
	}
}