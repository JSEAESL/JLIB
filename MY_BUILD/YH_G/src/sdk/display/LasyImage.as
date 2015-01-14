package sdk.display
{
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class LasyImage extends Image
	{
		private static var emptyTexture:Texture=Texture.fromBitmapData(new BitmapData(1,1,true,0x000000));
		public static function containImage(name:String):Boolean
		{
			return LasyTexture.getBitmapData(name)!=null;
		}
		private var lasyTexture:LasyTexture=null;
		public function LasyImage(name:String=null)
		{
			if(name!=null)
			{
				lasyTexture=LasyTexture.getLasyTexture(name);
				lasyTexture.imageAttach(this);
			}
			super(name==null?emptyTexture:lasyTexture.texture);
		}
		override public function dispose():void
		{
			if(lasyTexture!=null)
			{
				lasyTexture.imageDetach(this);
				lasyTexture=null;
			}
			super.dispose();
		}
		public function set source(name:String):void
		{
			if(lasyTexture!=null && lasyTexture.name==name) return;
			if(lasyTexture!=null) lasyTexture.imageDetach(this);
			if(name==null)
			{
				lasyTexture=null;
				this.texture=emptyTexture;
			}
			else
			{
				lasyTexture=LasyTexture.getLasyTexture(name);
				this.texture=lasyTexture.texture;
				lasyTexture.imageAttach(this);
			}
		}
	}
}