package sdk
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;

	public class LasyLoader
	{
		private var url:String;
		public var completeHandler:Function;
		public var progressHandler:Function;
		
		public var isComplete:Boolean=false;
		public function LasyLoader(url:String,completeHandler:Function=null,progressHandler:Function=null)
		{
			this.url=url;
			this.completeHandler=completeHandler;
			this.progressHandler=progressHandler;
		}
		public function start():void
		{
			var loader:Loader=new Loader();
			var context:LoaderContext=new LoaderContext(false,ApplicationDomain.currentDomain);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			loader.load(new URLRequest(url),context);
		}
		private function onProgress(evt:ProgressEvent):void
		{
			if(progressHandler!=null) progressHandler(evt.bytesLoaded,evt.bytesTotal);
		}
		private function onComplete(evt:Event):void
		{
			isComplete=true;
			var loaderInfo:LoaderInfo=evt.target as LoaderInfo;
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			loaderInfo.removeEventListener(Event.COMPLETE,onComplete);
			if(completeHandler!=null) completeHandler();
		}
		private function onIOError(evt:IOErrorEvent):void
		{
			
		}
	}
}