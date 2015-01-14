package sdk.util
{
	import flash.utils.ByteArray;

	public class Base64
	{
		private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
		public static function Base64_decodeToByteArray(data:String):ByteArray
		{
			// Initialise output ByteArray for decoded data
			var output:ByteArray = new ByteArray();
			// Create data and output buffers
			var dataBuffer:Array = new Array(4);
			var outputBuffer:Array = new Array(3);
			// While there are data bytes left to be processed
			for (var i:uint = 0; i < data.length; i += 4)
			{
				// Populate data buffer with position of Base64 characters for
				// next 4 bytes from encoded data
				for (var j:uint = 0; j < 4 && i + j < data.length; j++)
				{
					dataBuffer[j] = BASE64_CHARS.indexOf(data.charAt(i + j));
				}
				// Decode data buffer back into bytes
				outputBuffer[0] = (dataBuffer[0] << 2) + ((dataBuffer[1] & 0x30) >> 4);
				outputBuffer[1] = ((dataBuffer[1] & 0x0f) << 4) + ((dataBuffer[2] & 0x3c) >> 2);
				outputBuffer[2] = ((dataBuffer[2] & 0x03) << 6) + dataBuffer[3];
				// Add all non-padded bytes in output buffer to decoded data
				for (var k:uint = 0; k < outputBuffer.length; k++)
				{
					if (dataBuffer[k+1] == 64) break;
					output.writeByte(outputBuffer[k]);
				}
			}
			// Rewind decoded data ByteArray
			output.position = 0;
			// Return decoded data
			return output;
		}
	}
}