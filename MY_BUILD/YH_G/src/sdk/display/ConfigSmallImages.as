package sdk.display
{
	import flash.utils.Dictionary;

	internal class ConfigSmallImages
	{
		private var image:Dictionary=new Dictionary();
		public function ConfigSmallImages(xml:XML)
		{
			for each(var imageXml:XML in xml.image)
			{
				var si:ConfigSmallImage=new ConfigSmallImage(imageXml);
				image[si.image]=si;
			}
		}
		public function getSmallImage(name:String):ConfigSmallImage
		{
			return image[name];
		}
		public function getNames():Vector.<String>
		{
			var r:Vector.<String>=new Vector.<String>();
			for(var name:String in image)
			{
				r.push(name);
			}
			return r;
		}
	}
}