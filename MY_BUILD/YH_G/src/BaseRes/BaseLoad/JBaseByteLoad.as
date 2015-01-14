package BaseRes.BaseLoad
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import BaseMusic.JSoundManager;
	
	import BaseRes.JBaseBMPCache;
	
	import BaseUI.old.JStrUnti;
	
	import lib.BMPDecoder;

	public class JBaseByteLoad extends EventDispatcher
	{
		public function JBaseByteLoad()
		{

		}

		private var m_byte:ByteArray;
		//private var m_type:String;
		private var m_load:Loader;
		
		private var comCaller:Object;
		private var comFunction:Function;

		private var m_loadInfo:JBaseLoadInfo;
		public static function creatByteLoad(byte:ByteArray,loadInfo:JBaseLoadInfo):JBaseByteLoad
		{
			var result:JBaseByteLoad = new JBaseByteLoad();
			result.m_byte = byte;
			result.m_loadInfo = loadInfo;
			//result.m_type = loadInfo.type;
			result.m_load = new Loader();
			result.comCaller = loadInfo.caller;
			result.comFunction = loadInfo.callBack;
			return result;
		}
		
		private var m_file:File;
		public static function creartFileLoad(f:File,loadInfo:JBaseLoadInfo):JBaseByteLoad
		{
			var result:JBaseByteLoad = new JBaseByteLoad();
			result.m_file = f
			result.m_loadInfo = loadInfo;

			result.comCaller = loadInfo.caller;
			result.comFunction = loadInfo.callBack;
			return result;
		}
		
		private static var i:int = 0
		public function toLoadFile():void
		{
			var fileSteam:FileStream = new FileStream();
			fileSteam.addEventListener(Event.COMPLETE,onFileLoaded);
			fileSteam.addEventListener(IOErrorEvent.IO_ERROR,	onFileError);
			fileSteam.openAsync(m_file, FileMode.READ);
			
			//m_loadInfo = new JBaseLoadInfo()	
			//m_loadInfo.type = JBaseLoadInfo.BMP_TYPE;
			//m_loadInfo.url = m_file.url;
			//m_loadInfo.callBack = callBack 
			//m_loadInfo.caller= caller

			m_load = new Loader();
			trace("toLoadFile  " + m_loadInfo.url)
		}
		
		private function onFileError(e:IOErrorEvent):void
		{
			trace("!!!!!!!!!!" + e)
		}
		
	
		private function onFileLoaded(e:Event):void
		{
			var _fileStream:FileStream=FileStream(e.currentTarget);
			m_byte  = new ByteArray();
			_fileStream.readBytes(m_byte, 0, _fileStream.bytesAvailable);
			_fileStream.close();
			i = i + 1
			trace("开始加载File IMG" + m_loadInfo.url)
			//byteLoadBMP()
			toLoad()
		}
		
		private function byteLoadBMP():void
		{
			var decode:BMPDecoder = new BMPDecoder();
			var data:BitmapData =  decode.decode(m_byte);
			var name:String = JStrUnti.getUrlLastStr(m_loadInfo.url);
			//JBaseBMPCache.getInstance().pushCache(name,data);

			m_loadInfo.callBack.apply(m_loadInfo.caller,[JBaseBMPCache.getInstance().pushCache(name,data)]);

			destroy();
		}


		public function toLoad():void
		{
			if(!m_byte)
			{
				return;
			}
			trace(m_loadInfo.url + "大小" + m_byte.length)

			switch(m_loadInfo.type)
			{
				case JBaseLoadInfo.XML_TYPE:
					byteLoadXML();
					break;
				case JBaseLoadInfo.MP3_TYPE:
					byteLoadMp3();
					break;
				case JBaseLoadInfo.IMG_TYPE:
					byteLoadImg();
					break;
				case JBaseLoadInfo.BMP_TYPE:
					byteLoadBMP();
					break;
				default:
					trace("未找到资源类型    " + m_loadInfo.url)
					break;
			}
		}

		private function addEvent():void
		{
			m_load.contentLoaderInfo.addEventListener(Event.COMPLETE, onDataLoaded);
			m_load.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onDataProgress);
			m_load.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onDataSecurityError);
			m_load.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onDataFailed);
		}

		private function removeEvent():void
		{
			m_load.contentLoaderInfo.removeEventListener(Event.COMPLETE, onDataLoaded);
			m_load.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onDataProgress);
			m_load.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onDataSecurityError);
			m_load.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onDataFailed);
		}
		private function onDataLoaded(e:Event):void
		{
			comFunction.apply(comCaller,[e.currentTarget.content.bitmapData,m_loadInfo.type,m_loadInfo]);
			removeEvent();
			destroy();

		}

		private function onDataProgress(e:ProgressEvent):void
		{

		}
		private function onDataSecurityError(e:SecurityErrorEvent):void
		{

		}
		private function onDataFailed(e:IOErrorEvent):void
		{

		}

		private function byteLoadXML():void
		{
			trace("开始加载XML   " + m_loadInfo.url)
			m_byte.position = 0;
			var xml:XML = XML(m_byte.readUTFBytes(m_byte.length));
			comFunction.apply(comCaller,[xml,m_loadInfo.type,m_loadInfo]);
			destroy();
		}

		private function byteLoadMp3():void
		{
			trace("开始加载MP3   " + m_loadInfo.url)
			comFunction.apply(comCaller,[JSoundManager.getInstance().saveCaseSound(m_loadInfo.id,m_byte),m_loadInfo.type,m_loadInfo]);
			destroy();
		}

		private function byteLoadImg():void
		{
			trace("开始加载IMG" + m_loadInfo.url)
			addEvent();
			var lC:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			lC.allowCodeImport = true;
			m_load.loadBytes(m_byte, lC);
		}

		public var isCom:Boolean = false;
		public function destroy():void
		{
			m_loadInfo = null;
			m_byte = null;
			m_load = null;
			comCaller = null;
			comFunction = null;
			isCom = true;
		}
	}
}