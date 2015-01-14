package sdk
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import starling.textures.Texture;

	public class Asset
	{
		private static var textures:Dictionary=new Dictionary();
		private static var bitmapDataAndByteArray:Dictionary=new Dictionary();
		private static function mapName(name:String):String
		{
			return name.replace(/\//g,"_").replace(/\./g,"_");
		}
		public static function getTexture(name:String,gray:Boolean=false):Texture
		{
			var key:String=mapName(name);
			var grayKey:String=key+(gray?"_gray":"");
			if(textures[grayKey]==null)
			{
				var bd:BitmapData=getBitmapData(name);
				if(bd==null) return null;
				if(gray)
				{
					var bmp:Bitmap=new Bitmap(bd);
					bmp.filters=[new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
					var bd1:BitmapData=new BitmapData(bd.width,bd.height,true,0x000000);
					//var ct:ColorTransform=new ColorTransform();
					bd1.draw(bmp);
					textures[grayKey]=Texture.fromBitmapData(bd1,false);
				}
				else
				{
					textures[key]=Texture.fromBitmapData(bd,false);
				}
			}
			return textures[grayKey];
		}
		public static function createXml(name:String):XML
		{
			var ba:ByteArray=getByteArray(name);
			var strXml:String=ba.readUTFBytes(ba.length);
			return new XML(strXml);
		}
		public static function getBitmapData(name:String):BitmapData
		{
			var key:String=mapName(name);
			if(bitmapDataAndByteArray[key]==null)
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
				bitmapDataAndByteArray[key]=bmp;
			}
			return bitmapDataAndByteArray[key];
		}

		public static function getByteArray(name:String):ByteArray
		{
			var key:String=mapName(name);
			if(bitmapDataAndByteArray[key]==null)
			{
				var cls:Class=getDefinitionByName(key) as Class;
				var ba:ByteArray=new cls();
				bitmapDataAndByteArray[key]=ba;
			}
			ba=bitmapDataAndByteArray[key];
			ba.position=0;
			return bitmapDataAndByteArray[key];
		}
	
	}
}