package BaseUI
{
	
	import flash.display.DisplayObject;
	
	import Const.BaseConst;

	public class JAutoLayout
	{
		public function JAutoLayout()
		{

		}

		private static var nextX:Number = 0;
		private static var nextY:Number = 0;
		public static function addNom(dim:DisplayObject,offX:Number = 30,offY:Number = 30):void
		{
			if(nextX  == 0 &&nextY == 0)
			{
				nextX= BaseConst.oneCenterX;
				nextY= BaseConst.oneCenterY;
			}
			
			nextX = nextX + offX;
			nextY = nextY + offY;
			dim.x = nextX;
			dim.y = nextY;
			
		}
		
		
		public static function oneCenter(dim:DisplayObject):void
		{
			dim.x = BaseConst.oneCenterX;
			dim.y = BaseConst.oneCenterY;
		}

		public static function twoCenter(dim:DisplayObject):void
		{
			dim.x = BaseConst.twoCenterX;
			dim.y = BaseConst.twoCenterY;
		}

		public static function threeCenter(dim:DisplayObject):void
		{
			dim.x = BaseConst.threeCenterX;
			dim.y = BaseConst.threeCenterY;
		}

		public static function fourCenter(dim:DisplayObject):void
		{
			dim.x = BaseConst.fourCenterX;
			dim.y = BaseConst.fourCenterY;
		}

		public static function threeBestCenter(dim:DisplayObject):void
		{
			dim.x = BaseConst.FULL_WIDTHT * BaseConst.BestNumber;
			dim.y = BaseConst.FULL_HEIGHT * BaseConst.BestNumber;
		}

		public static function fourBestCenter(dim:DisplayObject):void
		{
			dim.x = BaseConst.FULL_WIDTHT * (1-BaseConst.BestNumber);
			dim.y = BaseConst.FULL_HEIGHT * BaseConst.BestNumber ;
		}

		public static function oneBestCenter(dim:DisplayObject):void
		{
			dim.x = BaseConst.FULL_WIDTHT * (1-BaseConst.BestNumber);
			dim.y = BaseConst.FULL_HEIGHT * (1-BaseConst.BestNumber);
		}

		public static function twoBestCenter(dim:DisplayObject):void
		{
			dim.x = BaseConst.FULL_WIDTHT * BaseConst.BestNumber;
			dim.y = BaseConst.FULL_HEIGHT * (1-BaseConst.BestNumber) ;
		}
	}
}