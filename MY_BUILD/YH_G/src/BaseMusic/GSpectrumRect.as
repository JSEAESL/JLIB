package BaseMusic
{

		import com.adobe.utils.AGALMiniAssembler;
		
		import flash.display.BitmapData;
		import flash.display.Sprite;
		import flash.display3D.Context3D;
		import flash.display3D.Context3DProfile;
		import flash.display3D.Context3DProgramType;
		import flash.display3D.Context3DRenderMode;
		import flash.display3D.Context3DTextureFormat;
		import flash.display3D.Context3DVertexBufferFormat;
		import flash.display3D.IndexBuffer3D;
		import flash.display3D.Program3D;
		import flash.display3D.VertexBuffer3D;
		import flash.display3D.textures.Texture;
		import flash.events.Event;
		import flash.geom.Matrix3D;
		import flash.media.Sound;
		import flash.media.SoundChannel;
		import flash.media.SoundMixer;
		import flash.net.FileReference;
		import flash.utils.ByteArray;
		
		[ backgroundColor='#000000', frameRate='60')]
		public class GSpectrumRect extends Sprite
		{
			private static var VERTEX_SHADER:String =
				<![CDATA[
				
				m44 op, va0, vc0
				mov v0, va1 
				
				]]>;
			
			
			private static var FRAGMENT_SHADER:String =
				<![CDATA[
				
				// radius
				add ft6.x, v0.x, fc1.z
				mov ft6.y, fc1.w
				tex ft0, ft6.xy, fs0<2d, wrap, linear, mipnone>
				mul ft0.x, ft0.x, fc1.y
				mul ft0.x, ft0.x, fc1.x
				
				//distance
				sub ft1.x, v0.x, fc0.x
				mul ft1.x, ft1.x, ft1.x
				sub ft1.y, v0.y, fc0.y
				mul ft1.y, ft1.y, ft1.y
				add ft1.x, ft1.x, ft1.y
				sqt ft1.x, ft1.x
			
			// if distance < radius
				mov ft3.xyzw, fc2.xyzw // fc2 = color
				div ft1.y, ft1.x, ft0.x
				sub ft1.y, fc2.w, ft1.y
				mul ft4.xyz, ft3.xyz, ft1.yyy
				mov ft4.w, fc2.w
				
			// else  
				mov ft5.xyz, fc0.www
				mov ft5.w, fc2.w
				
				slt ft6.x, ft1.x, ft0.x
				mul ft4.xyzw, ft4.xyzw, ft6.xxxx
				mul ft5.xyzw, ft5.xyzw, ft6.xxxx
			
				add oc, ft4, ft5
				
				]]>;
			
			
			private var context:Context3D;
			private var isReady:Boolean;
			private var program:Program3D;
			private var renderMatrix:Matrix3D;
			private var vertexBuffer:VertexBuffer3D;
			private var indexBuffer:IndexBuffer3D;
			private var texture:Texture;
			private var sound:Sound
			private var soundBytes:ByteArray = new ByteArray();
			private var soundVector:Vector.<Number> = new Vector.<Number>(512, true);
			private var _file:FileReference;
			
			private var channel:SoundChannel;
			public function GSpectrumRect()
			{
				super();
				
				init();
			}
			
			private function init():void
			{
				this.context = new Context3D();
			}
				
			private function requestContext():void
			{
				stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onStage3dContext);
				stage.stage3Ds[0].requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			}
			
			private function onStage3dContext(e:Event):void
			{
				this.context = stage.stage3Ds[0].context3D;
				this.context.configureBackBuffer(stage.stageWidth, stage.stageHeight, 1, false, false);
				
				createVertexBuffer();
				createIndexBuffer();
				createTexture();
				createPrograms();
				
				this.isReady = true;
			}
			
			private function bytesToVector(bytes:ByteArray, v:Vector.<Number>):void
			{
				var i:int = 0;
				while (bytes.bytesAvailable)
					v[i++] = bytes.readFloat();
			}
			
			private function createVertexBuffer():void
			{
				var vertices:Vector.<Number> = new <Number>[
					//      x          y        u  v
					-1.0,      1.0,     0, 0, 
					1.0,       1.0,     1, 0,
					-1.0,      -1.0,     0, 1,
					1.0,     -1.0,     1, 1  ];
				
				this.vertexBuffer = this.context.createVertexBuffer(4, 4);
				this.vertexBuffer.uploadFromVector(vertices, 0, 4);
			}
			
			private function createIndexBuffer():void
			{
				this.indexBuffer = this.context.createIndexBuffer(6);
				
				// 2 triangles (0, 1, 2) & (1, 3, 2)
				//   0 - 1
				//   | / |
				//   2 - 3
				this.indexBuffer.uploadFromVector(new <uint>[0, 1, 2,   1, 3, 2], 0, 6);
			}
			
			private function createTexture():void
			{
				var dat:BitmapData = new BitmapData(256, 256, false, 0x0);
				dat.perlinNoise(4, 4, 16, int(Math.random() * 99999), true, true);
				
				this.texture = this.context.createTexture(dat.width, dat.height, Context3DTextureFormat.BGRA, false);
				this.texture.uploadFromBitmapData(dat);
				dat.dispose();
			}
			
			private function createPrograms():void
			{
				var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
				vertexShaderAssembler.assemble(Context3DProgramType.VERTEX, VERTEX_SHADER);
				
				var fragmentShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
				fragmentShaderAssembler.assemble(Context3DProgramType.FRAGMENT, FRAGMENT_SHADER);
				
				this.program = this.context.createProgram();
				this.program.upload(vertexShaderAssembler.agalcode, fragmentShaderAssembler.agalcode);
			}
			
			private var fc0:Vector.<Number> = new <Number>[.5, .5, 0, 0];
			private var fc1:Vector.<Number> = new <Number>[0, 2.5, 0, 0];
			private var fc2:Vector.<Number> = new <Number>[1, 0, 1, 1];
			private var radius:Number = 0.0;
			private var t:Number = 0.0;
			public function onFrame(e:Event):void
			{

				
				this.soundBytes.clear();
				
				SoundMixer.computeSpectrum(this.soundBytes, true);
				bytesToVector(this.soundBytes, this.soundVector);   
				
				
				this.context.clear(0, 0, 0, 1);
				
				this.context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, this.renderMatrix, true);
				
				this.context.setVertexBufferAt(0, this.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
				this.context.setVertexBufferAt(1, this.vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2);
				
				this.context.setTextureAt(0, this.texture);
				
				this.radius += (this.soundVector[50] - this.radius) / 10;
				fc1[0] = this.radius; // radius adjust
				fc1[2] = this.soundVector[325]; // x adjust
				fc1[3] = this.soundVector[250] + t; // y pos
				
				// color (over drive)
				fc2[0] = this.soundVector[5] * 4;
				fc2[1] = this.soundVector[15] * 4;
				fc2[2] = this.soundVector[25] * 4;
				
				t += 1 / 512;
				
				this.context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, fc0, 1);
				this.context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, fc1, 1);
				this.context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, fc2, 1);
				
				this.context.setProgram(this.program);
				
				this.context.drawTriangles(this.indexBuffer);
				
				this.context.present();
			}
		}
	
}