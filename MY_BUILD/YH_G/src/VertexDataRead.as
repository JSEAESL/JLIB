package
{
	import flash.utils.ByteArray;
	

	public class VertexDataRead
	{
		public function VertexDataRead()
		{
		}
		
		public var data:ByteArray;
		public var type:int
		public var numVertices:Number;
		public var data32PerVertex:Number
		public function read(Data:ByteArray):void
		{
			data = Data;
			type = data.readByte();
			data32PerVertex = data.readInt();
			numVertices = data.readInt();
		}
	}
}