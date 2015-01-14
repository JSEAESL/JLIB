package sdk.display
{
	internal class ConfigSmallImage
	{
		public var image:String;
		public var width:int;
		public var height:int;
		public function ConfigSmallImage(xml:XML)
		{
			image=String(xml.@image);
			width=int(xml.@width);
			height=int(xml.@height);
		}
	}
}