package
{
	import flash.utils.ByteArray;
	

	public class IndexDataRead
	{
		public function IndexDataRead()
		{
		}
		
		public var data:ByteArray;
		public var type:int;
		public var numVertices:Number;
		public function read(Data:ByteArray):void
		{
			data = Data;
			type = data.readByte();
			numVertices = data.readInt();
		}
	}
}