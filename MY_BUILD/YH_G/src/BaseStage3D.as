package
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3DProgramType;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class BaseStage3D
	{
		public function BaseStage3D()
		{
		}
		
		public static function createVertextData(val:Vector.<Number>,data32PerVertex:uint):ByteArray
		{
			var rel:ByteArray;
			rel = new ByteArray();
			rel.endian = Endian.LITTLE_ENDIAN;
			rel.writeByte(0); //o表示为顶点数据
			rel.writeInt( data32PerVertex );  //写入每一个数据的数量
			rel.writeInt( val.length / data32PerVertex ); //写入顶点数量
			var len:uint = val.length;
			for( var i:int = 0; i<len; i++ )
			{
				rel.writeFloat( val[i] );
			}
			return rel;
		}
		
		public static function createIndexData(val:Vector.<uint>):ByteArray
		{
			var rel:ByteArray;
			rel = new ByteArray();
			rel.endian = Endian.LITTLE_ENDIAN;
			rel.writeByte(1); //1表示为顶点索引数据
			rel.writeInt( val.length ); //写入顶点索引数量长度
			var len:uint = val.length;
			for( var i:int = 0; i<len; i++ )
			{
				rel.writeShort( val[i] );
			}
			return rel;
		}
		
		public static function createVAGAL(val:String):ByteArray
		{
			var rel:ByteArray;
			var vagal:AGALMiniAssembler = new AGALMiniAssembler();
			vagal.assemble( Context3DProgramType.VERTEX, val );
			rel = vagal.agalcode;
			return rel;
		}
		public static function createFAGAL(val:String):ByteArray
		{
			var rel:ByteArray;
			var vagal:AGALMiniAssembler = new AGALMiniAssembler();
			vagal.assemble( Context3DProgramType.FRAGMENT, val );
			rel = vagal.agalcode;
			return rel;
		}
	}
}