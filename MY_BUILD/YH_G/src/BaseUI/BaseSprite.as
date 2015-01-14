package BaseUI
{
	import flash.display.Sprite;
	
	import Const.BaseConst;
	
	public class BaseSprite extends Sprite
	{
		public function BaseSprite()
		{
			super();
			//JStageManager.instance.setEasyDraw(this);
		}
		
		private static var Count:Number = 0;
		public static function creatSprite(colour:uint):BaseSprite
		{
			Count++;
			trace(Count)
			var mColour:uint = colour;
			var result:BaseSprite = new BaseSprite();
			result.graphics.beginFill(mColour,1);
			result.graphics.drawRect(0,0, BaseConst.FULL_WIDTHT,BaseConst.FULL_HEIGHT)
			result.graphics.endFill();

			return result;
		}
		
		
	}
}