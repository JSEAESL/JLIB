package BaseUI
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class JChildManager
	{
		public function JChildManager()
		{
		}
		
		
		public static function addToFather(dim:DisplayObject,father:Sprite,x:int = 0,y:int = 0):void
		{
			dim.x = x;
			dim.y = y;
			father.addChild(dim);
		}
		
		public static function removeChild(child:DisplayObjectContainer):void
		{
			if(child.parent)
			{
				child.parent.removeChild(child)
			}
		}
	}
}