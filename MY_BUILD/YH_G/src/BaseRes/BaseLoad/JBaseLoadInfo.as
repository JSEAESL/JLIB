package BaseRes.BaseLoad
{
	public class JBaseLoadInfo
	{
		public static var TXT_TYPE:String = "TXT_TYPE";
		public static var XML_TYPE:String = "XML_TYPE";
		public static var IMG_TYPE:String = "IMG_TYPE";
		public static var MP3_TYPE:String = "MP3_TYPE";
		
		public static var BMP_TYPE:String = "BMP_TYPE";
		public var url:String;
		public var type:String
		public var id:String;
		public var caller:Object;
		public var callBack:Function;
		public function JBaseLoadInfo()
		{

		}

		public static function creatInfo(_url:String,_type:String,_id:String,_caller:Object,_callBack:Function):JBaseLoadInfo
		{
			var result:JBaseLoadInfo = new JBaseLoadInfo();
			
			result.url  = _url;
			result.type  = _type;
			result.id  = _id;
			result.caller  = _caller;
			result.callBack  = _callBack;
			

			return result;
		}
	}
}