package sdk.util
{
	import flash.utils.ByteArray;

	public class XmlUtil
	{
		public static function getXmlFromClass(cls:Class):XML
		{
			var ba:ByteArray=new cls() as ByteArray;
			var str:String=ba.readUTFBytes(ba.length);
			return new XML(str);
		}
	}
}