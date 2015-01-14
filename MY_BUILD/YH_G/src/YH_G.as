package 
{
	import flash.display.Sprite;
	
	import BaseFacade.TfacdeT;
	
	import BaseRes.JBaseResManager;
	
	import BaseScene.core.JSceneStateMachine;
	import BaseScene.tScene.scene.LoadingScene;
	import BaseScene.tScene.scene.StartScene;
	
	import BaseUI.JStageManager;
	
	[SWF(backgroundColor="#ffffff", width="1024", height="840", frameRate="30")]
	public class YH_G extends Sprite
	{

		public function YH_G()
		{
			JStageManager.instance.setStage(this.stage);
			//var testbg:ColourBg = ColourBg.creatColourBg(0x1E90FF,500,500,0.3);
			//JChildManager.addToFather(testbg,this,300,300);
			//JStageManager.instance.setEasyDraw(testbg);
		//	JStageManager.instance.stage3dT2()			
			//JStageManager.instance.stage3DT()	
			//return;

			JSceneStateMachine.getInstance().changeScene(LoadingScene.getInstance());

			JBaseResManager.getInstance().firstLoad();
			var Tfacde:TfacdeT = new TfacdeT();
		}
		
		public function ViewTest():void
		{
			JSceneStateMachine.getInstance().changeScene(StartScene.getInstance());
		}

		
		public  function getBooleanArray(byte:Number,len:Number):Array
		{
			var result:Array = [];
			for(var index:Number = 0; index < len;index++ )
			{
				result[index] = byte & 1;
				byte = byte >> 1;
			}
			return result;
		}
	

		
	
	}
}