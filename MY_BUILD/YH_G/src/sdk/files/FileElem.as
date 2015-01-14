package sdk.files
{
	public class FileElem
	{
		public var src:String;
		public var dst:String;
		public var size:Number;
		public function FileElem(xml:XML)
		{
			src=String(xml.@src);
			dst=String(xml.@dst);
			size=Number(xml.@size);
		}
	}
}