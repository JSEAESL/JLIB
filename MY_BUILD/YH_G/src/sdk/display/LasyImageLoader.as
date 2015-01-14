package sdk.display
{
	import feathers.controls.ImageLoader;
	import feathers.core.FeathersControl;
	
	public class LasyImageLoader extends FeathersControl
	{
		private var image:LasyImage=null;
		private var imageLoader:ImageLoader=null;
		public function LasyImageLoader()
		{
			super();
		}
		private var _source:String=null;
		public function get source():String
		{
			return _source;
		}
		public function set source(value:String):void
		{
			_source=value;
			invalidate();
		}
		private function disposeImage():void
		{
			if(image!=null)
			{
				this.removeChild(image,true);
				image=null;
			}
			if(imageLoader!=null)
			{
				this.removeChild(imageLoader,true);
				imageLoader=null;
			}
		}
		override protected function draw():void
		{
			this.disposeImage();
			if(source==null) return;
			if(source.substr(0,4)=="http")
			{
				imageLoader=new ImageLoader();
				imageLoader.source=source;
				addChild(imageLoader);
			}
			else
			{
				image=new LasyImage(source);
				addChild(image);
			}
		}
		override protected function initialize():void
		{
			super.initialize();
		}
	}
}