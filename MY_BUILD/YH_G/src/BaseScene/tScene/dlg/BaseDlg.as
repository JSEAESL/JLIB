package BaseScene.tScene.dlg
{
	import flash.display.Sprite;
	
	import BaseUI.JStageManager;
	
	import Const.BaseConst;
	
	public class BaseDlg extends Sprite implements IDlg
	{
		public function BaseDlg()
		{
			super();
			init();
			initMask();
		}
		private function init():void
		{
			
		}
		
		private var dlgMC:Sprite;		
		private var maskMC:Sprite
		private function initMask():void
		{
			maskMC = new Sprite()
			maskMC.graphics.beginFill(0x666666,0.5);
			maskMC.graphics.drawRect(0,0,BaseConst.FULL_WIDTHT,BaseConst.FULL_HEIGHT);
			addChild(maskMC);
			
			dlgMC = new Sprite();	
			dlgMC.mask = maskMC;
			addChild(dlgMC);
				
				
		}
		
		public function toHide():void
		{
			
		}
		
		public function toAdd(father:Sprite):void
		{
			JStageManager.instance.addToDlg(father);
		}
		
		public function destroy():void
		{
			
		}
	}
}