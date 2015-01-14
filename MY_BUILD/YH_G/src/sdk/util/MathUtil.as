package sdk.util
{
	import flash.geom.Point;

	public class MathUtil
	{
		public function MathUtil()
		{
		}
		public static function getAngle(vector:Point):Number
		{
			var sinValue:Number=vector.y/vector.length;
			//返回-pi/2到pi/2之间的一个角度,在1，4象限,如果x>0,否则在2，3象限
			var arcSinValue:Number=Math.asin(sinValue);
			//sin(pi-alpha)=sin(alpha)
			//转换为角度
			var angle:Number=arcSinValue;
			if(vector.x>=0) return angle;
			else return Math.PI-angle;
		}
	}
}