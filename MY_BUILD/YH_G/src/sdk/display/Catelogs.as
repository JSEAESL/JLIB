package sdk.display
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import sdk.files.FileElem;

	public class Catelogs
	{
		private static var _inst:Catelogs=null;
		public static function inst():Catelogs
		{
			if(_inst==null)
			{
				_inst=new Catelogs();
			}
			return _inst;
		}
		[Embed(source="/small_list.xml",mimeType="application/octet-stream")]
		private const smallListClass:Class;
		
		[Embed(source="/hd_list.xml",mimeType="application/octet-stream")]
		private const hdListClass:Class;
		
		public var smallImages:ConfigSmallImages;
		private var hdFiles:Dictionary;
		public function Catelogs()
		{
			var byteArray:ByteArray=new smallListClass();
			var xmlString:String=byteArray.readUTFBytes(byteArray.length);
			var xml:XML=new XML(xmlString);
			smallImages=new ConfigSmallImages(xml);
			
			hdFiles=createFiles(new hdListClass());
		}
		
		private function createFiles(byteArray:ByteArray):Dictionary
		{
			var files:Dictionary=new Dictionary();
			var xmlString:String=byteArray.readUTFBytes(byteArray.length);
			var xml:XML=new XML(xmlString);
			for each(var file:XML in xml.file)
			{
				var fe:FileElem=new FileElem(file);
				files[fe.src]=fe;
			}
			return files;
		}
		public function getHdUrl(name:String):String
		{
			name="loose_assets/"+name;
			if(hdFiles[name]==null) return null;
			return "hashed/"+(hdFiles[name] as FileElem).dst;
		}
	}
}