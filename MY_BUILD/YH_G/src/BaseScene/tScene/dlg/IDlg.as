package BaseScene.tScene.dlg
{
	import flash.display.Sprite;
	
	import BaseScene.tScene.IDestroy;

	public interface IDlg extends IDestroy
	{
		function toAdd(father:Sprite):void
			
		function toHide():void

	}
}