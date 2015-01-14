package sdk.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class HdImageLoader
	{
		public var name:String;
		public var bitmapData:BitmapData;
		private var callback:Function;
		public function HdImageLoader(name:String,callback:Function)
		{
			this.name=name;
			this.callback=callback;
		}
		public function load():void
		{
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadHdImageComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			var url:String=Catelogs.inst().getHdUrl(name);
			loader.load(new URLRequest(url));
		}
		private function onLoadHdImageComplete(evt:Event):void
		{
			var loaderInfo:LoaderInfo=evt.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE,onLoadHdImageComplete);
			bitmapData=(loaderInfo.content as Bitmap).bitmapData;
			if(callback!=null) callback(this);
		}
		private function onIOError(evt:IOErrorEvent):void
		{
			
		}
	}
}