package sdk.util
{
	import starling.utils.formatString;

	public class StringFormater
	{
		public function StringFormater()
		{
		}
		public static function getStringByInt(value:int,length:int):String
		{
			var r:String=value.toString();
			for(var i:int=r.length;i<length;i++)
			{
				r="0"+r;
			}
			return r;
		}
		public static function getLeftSeconds(second:int):String
		{
			var sec:int=second%60;
			var min:int=(second/60)%60;
			var hour:int=second/3600;
			return getStringByInt(hour,2)+":"+getStringByInt(min,2)+":"+getStringByInt(sec,2);
		}
		public static function getLeftMinuteSecond(second:int):String
		{
			var sec:int=second%60;
			var min:int=(second/60)%60;
			var hour:int=second/3600;
			return (hour>0?(getStringByInt(hour,2)+":"):"")+getStringByInt(min,2)+":"+getStringByInt(sec,2);
		}
		public static function getAccurTimeString(second:int):String
		{
			if(second<60) return "刚刚";
			if(second<=3600) return formatString("{0}分钟前",int(second/60));
			if(second<=24*3600) return formatString("{0}小时{1}分钟前",int(second/3600),int((second%3600)/60));
			return formatString("{0}天{1}小时前",int(second/24/3600),int((second%(24*3600))/3600));
		}
		public static function getLeftDays(second:int):String
		{
			var sec:int=second%60;
			var min:int=(second/60)%60;
			var hour:int=(second/3600)%24;
			var day:int=(second/3600/24);
			if(day>0)
			{
				return formatString("{0}天{1}时{2}分",day,hour,min,sec);
			}
			else
			{
				return formatString("{0}时{1}分{2}秒",hour,min,sec);
			}
		}
	}
}