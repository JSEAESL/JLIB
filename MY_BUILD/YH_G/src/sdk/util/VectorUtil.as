package sdk.util
{
	public class VectorUtil
	{
		public function VectorUtil()
		{
		}
		public static function add(src:Vector.<*>,dst:Vector.<*>):void
		{
			for each(var obj:Object in dst)
			{
				src.push(obj);
			}
		}
	}
}