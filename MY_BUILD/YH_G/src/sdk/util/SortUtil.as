package sdk.util
{
	public class SortUtil
	{
		public function SortUtil()
		{
		}
		public static function sort(...subs):int
		{
			for(var i:int=0;i<subs.length;i++)
			{
				if(subs[i]!=0) return subs[i];
			}
			return 0;
		}
		public static function sortWithValue(...values):int
		{
			var subs:Array=new Array();
			for(var i:int=0;i<values.length;i+=2)
			{
				var a:int=values[i]-values[i+1];
				if(a<0) return -1;
				else if(a==0) subs.push(0);
				else return 1;
			}
			return 0;
		}
	}
}