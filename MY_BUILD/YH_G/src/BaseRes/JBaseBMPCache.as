package BaseRes
{
	import flash.display.BitmapData;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import BaseUI.old.JImageCode;
	import BaseUI.old.JStrUnti;

	public class JBaseBMPCache
	{
		
		private static var _instance:JBaseBMPCache;
		public static function getInstance():JBaseBMPCache
		{
			if(null == _instance)
			{
				_instance = new JBaseBMPCache();
			}
			return _instance;
		}
		public function JBaseBMPCache()
		{
			cache = new Dictionary();
		}
		
		private var cache:Dictionary;
		private var len:uint = 0;
		public function pushCache(name:String,data:*):uint
		{
			cache[name] = data;
			len++;
			return len
		}
		
		public function saveBySize(len:Number):void
		{
			var data:BitmapData
			for (var i:String in cache ) 
			{
				data = cache[i];
				
				var width:Number = data.rect.width;
				var height:Number = data.rect.height;
				//var file:File = newDirectory(width,height,i);
				var file:File = newDirectory2(i);
			//	trace(file.url)
				//if(file.exists == true)
				{
					//continue;
				}
				var savaData :ByteArray =  JImageCode.getJPG(data,100)
				var _fileStream:FileStream	=	new FileStream();
				_fileStream.open(file,	FileMode.WRITE);	//	openAsync(_fileSave, FileMode.WRITE);
				_fileStream.addEventListener(IOErrorEvent.IO_ERROR,	onFileError);
				_fileStream.writeBytes(savaData , 0, savaData .length);
				_fileStream.close();
				trace(len--)
			}
			

		}

		private function onFileError(e:IOErrorEvent):void
		{
			trace("onFileError  "  + e);		
		}
		
		private function newDirectory2(name:String):File
		{
			var DirectoryName:String = name.slice(0,3);
			var DirectoryName2:String = name.slice(3,6);
			var _rootExportDir:File = new File(File.applicationDirectory.resolvePath(DirectoryName + "/" + DirectoryName2).nativePath);
			if(_rootExportDir.exists == false)
				_rootExportDir.createDirectory();
			return  new File(File.applicationDirectory.resolvePath(DirectoryName + "/" + DirectoryName2).nativePath + "/" + JStrUnti.replaceSuffixStr(name,"jpg"));
		}
		
		private function newDirectory(width:Number,height:Number,name:String):File
		{
			var DirectoryName:String = "width" + width + "_" + "height" + height;
			var _rootExportDir:File = new File(File.applicationDirectory.resolvePath(DirectoryName).nativePath);
			if(_rootExportDir.exists == false)
				_rootExportDir.createDirectory();
			return  new File(File.applicationDirectory.resolvePath(DirectoryName).nativePath + "/" + JStrUnti.replaceSuffixStr(name,"jpg"));
		}
		
		public function cleanDirectory(url:String):void
		{
			var dirFile:File = new File(File.applicationDirectory.resolvePath(url).nativePath);
			var subFiles:Array = dirFile.getDirectoryListing();
			for each(var f:File in subFiles)
			{
				if(f.isDirectory)
					f.deleteDirectory(true);
				else
					f.deleteFile();
			}
		}
	}
}