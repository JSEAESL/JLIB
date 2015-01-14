package sdk.display
{
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import starling.textures.Texture;

	internal class LasyTexture
	{
		private static var bitmapDatas:Dictionary=new Dictionary();
		private static function mapName(name:String):String
		{
			return name.replace(/\//g,"_").replace(/\./g,"_");
		}
		public static function getBitmapData(name:String):BitmapData
		{
			var key:String=mapName(name);
			if(bitmapDatas[name]==null)
			{
				try
				{
					var cls:Class=getDefinitionByName(key) as Class;
				}
				catch(e:Error)
				{
					return null;
				}
				var bmp:BitmapData=new cls();
				bitmapDatas[name]=bmp;
			}
			return bitmapDatas[name];
		}
		
		private static var lasyTextures:Dictionary=new Dictionary();
		public static function getLasyTexture(name:String):LasyTexture
		{
			if(lasyTextures[name]==null)
			{
				var lt:LasyTexture=new LasyTexture();
				lt.name=name;
				
				var bd:BitmapData=getBitmapData(name);
				var smallImage:ConfigSmallImage=Catelogs.inst().smallImages.getSmallImage(name);
				if(smallImage==null)
				{
					//如果就是普通的图
					lt.texture=Texture.fromBitmapData(bd,false,false);
				}
				else
				{
					//如果是有小图的图
					if(bd.width==smallImage.width)
					{
						//如果已经是高清图
						lt.texture=Texture.fromBitmapData(bd,false,false);
					}
					else
					{
						//如果不是高清图
						lt.texture=Texture.fromBitmapData(bd,false,false,bd.width*1.0/smallImage.width);
						loadHdImage(smallImage.image);
					}
				}
				lasyTextures[name]=lt;
			}
			return lasyTextures[name];
		}
		
		private static var loadings:Dictionary=new Dictionary();
		private static function loadHdImage(name:String):void
		{
			if(loadings[name]!=null) return;
			loadings[name]="hello";
			var hdLoader:HdImageLoader=new HdImageLoader(name,onLoadHdImage);
			hdLoader.load();
		}
		private static function onLoadHdImage(hdLoader:HdImageLoader):void
		{
			delete loadings[hdLoader.name];
			(bitmapDatas[hdLoader.name] as BitmapData).dispose();
			bitmapDatas[hdLoader.name]=hdLoader.bitmapData;
			
			var lasyTexture:LasyTexture=lasyTextures[hdLoader.name] as LasyTexture;
			if(lasyTexture==null) return;
			lasyTexture.replaceImageTexture(Texture.fromBitmapData(hdLoader.bitmapData,false,false));
		}
		
		public var name:String;
		public var texture:Texture;
		public var images:Vector.<LasyImage>=new Vector.<LasyImage>();
		public function LasyTexture()
		{
		}
		public function imageAttach(image:LasyImage):void
		{
			images.push(image);
		}
		public function imageDetach(image:LasyImage):void
		{
			images.splice(images.indexOf(image),1);
			if(images.length==0)
			{
				//trace("Lasy texture "+name+" disposed.");
				texture.dispose();
				delete lasyTextures[name];
			}
		}
		private function replaceImageTexture(newTexture:Texture):void
		{
			var oldTexture:Texture=this.texture;
			this.texture=newTexture;
			for each(var image:LasyImage in images)
			{
				image.texture=newTexture;
			}
			oldTexture.dispose();
		}
	}
}