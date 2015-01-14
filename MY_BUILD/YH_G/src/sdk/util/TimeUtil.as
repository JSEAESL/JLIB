package sdk.util
{
	import flash.utils.getTimer;
	
	import starling.utils.formatString;

	public class TimeUtil
	{
		private static var baseTime:int;
		public static var day_base_time:int=0;
		public static function setVirtualSecond(value:int):void
		{
			baseTime=value-getTimer()/1000;
		}
		public static function getVirtualSecond():int
		{
			return getTimer()/1000+baseTime;
		}
		public static function getDay(value:int=-1):int
		{
			var base:int=new Date(1984,4,30,0,0,0,0).time;
			if(value==-1) value=getVirtualSecond();
			return int((value-day_base_time)/24/3600);
		}
		public static function getDayString(value:int):String
		{
			var day:int=getDay(value);
			var nowDay:int=getDay();
			if(nowDay==day) return "今天";
			else if(nowDay-1==day) return "昨天";
			else if(nowDay-2==day) return "前天";
			return formatString("{0}天前",nowDay-day);
		}
		public static function getTimeString(value:int):String
		{
			var date:Date=new Date();
			date.setTime(value*1000.0);
			return StringFormater.getStringByInt(date.hours,2)+":"+StringFormater.getStringByInt(date.minutes,2)+":"+StringFormater.getStringByInt(date.seconds,2);
		}
		public static function getMonthAndDayString(value:int):String
		{
			var date:Date=new Date();
			date.setTime(value*1000.0);
			return StringFormater.getStringByInt(date.month+1,2)+"月"+StringFormater.getStringByInt(date.date,2);
		}
		public static function GetCurrentDate():Date
		{
			return new Date( getVirtualSecond() * 1000 );
		}
		public static function GetWeekDay():int
		{
			var d:Date = GetCurrentDate();
			if( d.hours < 6 )
			{
				return d.day > 0 ? d.day - 1 : 6;
			}
			return d.day;
		}
		/**
		 * 返回一个月的天数
		 * @param year
		 * @param month 从0开始索引
		 * @return 
		 * 
		 */		
		public static function getDayCountOfYearMonth(year:int,month:int):int
		{
			var firstDay:Date=new Date(year,month);
			var nextFirstDay:Date;
			if(month==11)
			{
				nextFirstDay=new Date(year+1,0);
			}
			else
			{
				nextFirstDay=new Date(year,month+1);
			}
			var span:Number=nextFirstDay.getTime()-firstDay.getTime();
			span=span/1000/3600/24;
			return span;
		}
		/**
		 * 返回1到31之间的一个整数
		 * @return 
		 * 
		 */		
		public static function getNowDate():int
		{
			var now:Date=new Date();
			now.setTime(getVirtualSecond()*1000.0);
			return now.date;
		}
		public static function getVirtualSecondByHourMinute(hour:int,min:int):int
		{
			var now:Date=new Date();
			now.setTime(getVirtualSecond()*1000.0);
			var newDate:Date=new Date(now.fullYear,now.month,now.date,hour,min,0,0);
			return newDate.getTime()/1000;
		}
		public static function getVirtualSecondByHourMinSec(hour:int,min:int,sec:int):int
		{
			var now:Date=new Date();
			now.setTime(getVirtualSecond()*1000.0);
			var newDate:Date=new Date(now.fullYear,now.month,now.date,hour,min,sec,0);
			return newDate.getTime()/1000;
		}
		public static function isBefore(hour:int,min:int):Boolean
		{
			return getVirtualSecond()<getVirtualSecondByHourMinute(hour,min);
		}
		public static function isAfter(hour:int,min:int):Boolean
		{
			return getVirtualSecond()>=getVirtualSecondByHourMinute(hour,min);
		}
		public static function isIn(hour1:int,min1:int,hour2:int,min2:int):Boolean
		{
			return isAfter(hour1,min1) && isBefore(hour2,min2);
		}
	
		public static function getFormHourMinSecString(value:String):int
		{
			var hour:int=int(value.substr(0,2));
			var min:int=int(value.substr(3,2));
			var sec:int=int(value.substr(6,2));
			return getVirtualSecondByHourMinSec(hour,min,sec);
		}
		public static function getStartTime(value:String):int
		{
			var values:Array=value.split("-");
			var year:int=int(values[0]);
			var month:int=int(values[1])-1;
			var day:int=int(values[2]);
			
			var date:Date=new Date(year,month,day,0,0,0,0);
			return date.getTime()/1000;
		}
		public static function getEndTime(value:String):int
		{
			var values:Array=value.split("-");
			var year:int=int(values[0]);
			var month:int=int(values[1])-1;
			var day:int=int(values[2]);
			
			var date:Date=new Date(year,month,day,23,59,59,0);
			return date.getTime()/1000;
		}
	}
}