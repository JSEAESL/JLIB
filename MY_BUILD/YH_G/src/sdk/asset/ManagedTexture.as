package sdk.asset
{
	import starling.textures.Texture;

	public class ManagedTexture
	{
		public var name:String;
		public var texture:Texture;
		public var retainCount:int;
		public function ManagedTexture()
		{
		}
		public function dump():void
		{
			trace("dump mt",name,"rc=",retainCount);
		}
	}
}