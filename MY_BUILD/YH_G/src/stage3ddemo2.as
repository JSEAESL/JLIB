package
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	
	[SWF(frameRate="60")]
	public class stage3ddemo2 extends Sprite
	{
		[Embed(source="player.png")]
		private var pic:Class;
		
		private var _stage3d:Stage3D;
		private var _context3d:Context3D;
		
		public function stage3ddemo2()
		{
			trace( stage.stage3Ds.length );
			
			_stage3d = stage.stage3Ds[0];
			_stage3d.addEventListener(Event.CONTEXT3D_CREATE,created);
			//_stage3d.requestContext3D( Context3DRenderMode.AUTO );

			_stage3d.requestContext3D();
			
		}
		
		private function created(evt:Event):void
		{
			trace( _stage3d.context3D.driverInfo );
			
			_context3d = _stage3d.context3D;
			_context3d.enableErrorChecking = true;
			_context3d.configureBackBuffer( 300,300,16,true );
			
			init();
		}
		
		private function init():void
		{
			//顶点数据
			var vb:Vector.<Number> = Vector.<Number>([
				0,0, 0,1,//0
				1,0, 1,1,//1
				1,1, 1,0,//2
				0,1, 0,0 //3
			]);
			
			vbs = _context3d.createVertexBuffer( vb.length/4, 4 );
			vbs.uploadFromVector( vb,0, vb.length/4 );
			
			//顶点索引
			var ib:Vector.<uint> = Vector.<uint>([
				0,3,1,
				1,2,3
			]);
			
			ibs = _context3d.createIndexBuffer( ib.length );
			ibs.uploadFromVector( ib, 0, ib.length );
			
			//纹理
			tex = _context3d.createTexture( 128,128, Context3DTextureFormat.BGRA,true);
			var bit:Bitmap = new pic();
			bit.x = 350;
			addChild( bit );
			tex.uploadFromBitmapData( bit.bitmapData, 0 );
			
			//AGAL
			var vp:String = "mov op, va0" + "\n" + 
				" mov v0, va1";
			
			var vagal:AGALMiniAssembler = new AGALMiniAssembler();
			vagal.assemble( Context3DProgramType.VERTEX, vp );
			
			var fp:String = "tex ft0, v0, fs0 <2d,repeat,linear,nomip>" + "\n" + 
				"mov oc,ft0";
			
			var fagal:AGALMiniAssembler = new AGALMiniAssembler();
			fagal.assemble( Context3DProgramType.FRAGMENT, fp );
			
			//shader
			pm = _context3d.createProgram();
			pm.upload( vagal.agalcode, fagal.agalcode );
			
			_context3d.setTextureAt( 0, tex );
			_context3d.setProgram( pm );
			_context3d.setVertexBufferAt(0,vbs,0, Context3DVertexBufferFormat.FLOAT_2 );
			_context3d.setVertexBufferAt(1,vbs,2, Context3DVertexBufferFormat.FLOAT_2);
			
			addEventListener(Event.ENTER_FRAME, update);
			
		}
		private var pm:Program3D;
		private var vbs:VertexBuffer3D;
		private var ibs:IndexBuffer3D;
		private var tex:Texture;
		
		//循环渲染
		private function update(evt:Event):void
		{
			_context3d.clear();
			_context3d.drawTriangles( ibs );
			_context3d.present();
		}
	}
}