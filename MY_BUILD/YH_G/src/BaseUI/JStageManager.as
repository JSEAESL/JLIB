package BaseUI
{

import com.adobe.utils.AGALMiniAssembler;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.Stage3D;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.display3D.Context3D;
import flash.display3D.Context3DProgramType;
import flash.display3D.Context3DRenderMode;
import flash.display3D.Context3DTextureFormat;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.IndexBuffer3D;
import flash.display3D.Program3D;
import flash.display3D.VertexBuffer3D;
import flash.display3D.textures.Texture;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Endian;

import Const.Stats;


public class JStageManager
{
	
	private static var _instance:JStageManager;
	
	public static function get instance():JStageManager
	{
		if(_instance == null)
		{
			_instance = new JStageManager(new instanceClass());
		}
		
		return _instance;
	}
	public function JStageManager(insClass:instanceClass)
	{
	}
	
	
	public function get stage():Stage
	{
		return _stage;
	}
	
	//_______________________________________STAGE 3D______________________________________________________
	private var _stage3d:Stage3D;
	private var _context3d:Context3D;
	public function stage3DT():void
	{
		if( _stage.stage3Ds.length > 0 )
		{
			_stage3d = _stage.stage3Ds[3];
			_stage3d.addEventListener(Event.CONTEXT3D_CREATE,created_handler);
			_stage3d.addEventListener(ErrorEvent.ERROR, created_error_handler );
			_stage3d.requestContext3D( Context3DRenderMode.AUTO );
		}
	}
	
	private function created_handler (evt:Event):void
	{
		if(_context3d)
		{
			//trace( "GPU设备类型：",_context3d.driverInfo );		
		}
		_context3d = _stage3d.context3D;
		_context3d.enableErrorChecking = true;
		_context3d.configureBackBuffer( 300,300,0,true);
		trace( "GPU设备类型：",_stage3d.context3D.driverInfo );
		//addTriangle()
		//draw();
		
		//loadFile( files[ filesIndex ] );

		demo4();
		//_stage.addEventListener(MouseEvent.CLICK, click_handler );
	}
	private var pm:Program3D;
	private var vbs:VertexBuffer3D;
	private var ibs:IndexBuffer3D;
	private var tex:Texture;
	
	//循环渲染
	private function update(evt:Event):void
	{
		this._context3d.clear();
		this._context3d.drawTriangles( this.ibs );
		this._context3d.present();
	}
	
	[Embed(source="player.png")]
	private var pic:Class;
	private function demo4():void
	{
		//顶点数据
		var vb:Vector.<Number> = Vector.<Number>([
			0,0, 0,1,
			1,0, 1,1,
			1,1, 1,0,
			0,1, 0,0
		]);
		
		vbs = this._context3d.createVertexBuffer( vb.length/4, 4 );
		vbs.uploadFromVector( vb,0, vb.length/4 );
		
		//顶点索引
		var ib:Vector.<uint> = Vector.<uint>([
			0,3,1,
			1,2,3
		]);
		
		ibs = this._context3d.createIndexBuffer( ib.length );
		ibs.uploadFromVector( ib, 0, ib.length );
		
		//纹理
		tex = this._context3d.createTexture( 128,128, Context3DTextureFormat.BGRA,true);
		var bit:Bitmap = new pic();
		bit.x = 350;
		_stage.addChild( bit );
		tex.uploadFromBitmapData( bit.bitmapData, 0 );
		
		//AGAL
		var vp:String = "mov op, va0" + "\n" +
						"mov v0, va1";
		
		var vagal:AGALMiniAssembler = new AGALMiniAssembler();
		vagal.assemble( Context3DProgramType.VERTEX, vp );
		
	
		
	/*	var fp:String = 
			"tex ft0, v0, fs0 <2d,linear,nomip>\n" +
			"max ft1.w, ft0.x, ft0.y\n" +
			"max ft1.x, ft1.w, ft0.z\n" +
			"mov ft0.x, ft1.x\n" +
			"mov ft0.y, ft1.x\n" +
			"mov ft0.z, ft1.x\n" +
			"mov oc,ft0";*/
		
		/*var fp:String = 
			"tex ft0, v0, fs0 <2d,linear,nomip>\n" +
			"add ft1.x, ft0.x, ft0.y\n" +
			"add ft1.x, ft1.x, ft0.z\n" +
			"div ft1.w, ft1.x, fc0.x\n" +
			"mov ft0.x, ft1.w\n" +
			"mov ft0.y, ft1.w\n" +
			"mov ft0.z, ft1.w\n" +
			"mov oc,ft0";
		_context3d.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, Vector.<Number>([3, 0, 0, 0]) );*/
		
		
		/*var fp:String = 
			"tex ft0, v0, fs0 <2d,linear,nomip>\n" +
			"mul ft1.x, ft0.x, fc1.x\n" +
			"mul ft1.y, ft0.y, fc1.y\n" +
			"mul ft1.z, ft0.z, fc1.z\n" +
			"add ft1.w, ft1.x, ft1.y\n" +
			"add ft1.w, ft1.w, ft1.z\n" +
			"mov ft0.x, ft1.w\n" +
			"mov ft0.y, ft1.w\n" +
			"mov ft0.z, ft1.w\n" +
			"mov oc,ft0";
		_context3d.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, Vector.<Number>([0.3,0.59,0.11,0]) );*/
		
		var fp:String = "tex ft0, v0, fs0 <2d,repeat,linear,nomip>" + "\n" +
		"mov oc,ft0";
		var fagal:AGALMiniAssembler = new AGALMiniAssembler();
		fagal.assemble( Context3DProgramType.FRAGMENT, fp );
		//shader
		pm = this._context3d.createProgram();
		pm.upload( vagal.agalcode, fagal.agalcode );
		
		this._context3d.setTextureAt( 0, this.tex );
		this._context3d.setProgram( pm );
		this._context3d.setVertexBufferAt(0,this.vbs,0, Context3DVertexBufferFormat.FLOAT_2 );
		this._context3d.setVertexBufferAt(1,this.vbs,2, Context3DVertexBufferFormat.FLOAT_2);
		
		_stage.addEventListener(Event.ENTER_FRAME, update);
		
	}
	
	private function created_error_handler(e:ErrorEvent):void
	{
		trace(e.errorID)
	}
	
	private function click_handler(evt:MouseEvent):void
	{
		_context3d.dispose();
	}
	
	private var _vb:VertexBuffer3D;
	private var _ib:IndexBuffer3D;
	private var _pm:Program3D;
	private function addTriangle():void
	{
		//三角形顶点数据
		var triangleData:Vector.<Number> = Vector.<Number>([
			//	x, y, r, g, b
			0, 1, 0, 0, 1,
			1, 0, 0, 1, 0,
			0, 0, 1, 0, 0
		]);
		_vb = _context3d.createVertexBuffer( triangleData.length/5, 5 );
		_vb.uploadFromVector( triangleData,0,triangleData.length/5 );
		//三角形索引数据
		var indexData:Vector.<uint> = Vector.<uint>([
			0, 1, 2
		]);
		_ib = _context3d.createIndexBuffer( indexData.length );
		_ib.uploadFromVector( indexData, 0, indexData.length );
		//AGAL
		var vagalcode:String = "mov op, va0\n" +
			"mov v0, va1";
		var vagal:AGALMiniAssembler = new AGALMiniAssembler();
		vagal.assemble( Context3DProgramType.VERTEX, vagalcode );
		var fagalcode:String = "mov oc, v0";
		var fagal:AGALMiniAssembler = new AGALMiniAssembler();
		fagal.assemble( Context3DProgramType.FRAGMENT, fagalcode );
		
		_pm = _context3d.createProgram();
		_context3d.setVertexBufferAt( 0, _vb, 0, Context3DVertexBufferFormat.FLOAT_2 );
		_context3d.setVertexBufferAt( 1, _vb, 2, Context3DVertexBufferFormat.FLOAT_3 );
		_pm.upload( vagal.agalcode, fagal.agalcode );
	}
	private function draw():void
	{
		_context3d.clear( 0, 0, 0);

		_context3d.drawTriangles( _ib );
		_context3d.present();
	}
	
	

	
	public function stage3dT2():void
	{
		var triangleData:Vector.<Number> = Vector.<Number>([
			//	x, y, r, g, b
			0, 1, 0, 0, 1,
			1, 0, 0, 1, 0,
			0, 0, 1, 0, 0
		]);
		var byte:ByteArray = BaseStage3D.createVertextData( triangleData, 5 );
		var file:File = File.desktopDirectory;
		file = file.resolvePath("ver.stage3dvertex");
		var fileStream:FileStream = new FileStream();
		fileStream.open(file, FileMode.UPDATE);
		fileStream.writeBytes( byte );
		fileStream.close();
		
		var indexData:Vector.<uint> = Vector.<uint>([
			0, 1, 2
		]);
		byte = BaseStage3D.createIndexData( indexData );
		file = File.desktopDirectory;
		file = file.resolvePath("ver.stage3dindex");
		fileStream = new FileStream();
		fileStream.open(file, FileMode.UPDATE);
		fileStream.writeBytes( byte );
		fileStream.close();
		
		var vagalcode:String = "mov op, va0\n" +
			"mov v0, va1";
		byte = BaseStage3D.createVAGAL(vagalcode)
			
		file = File.desktopDirectory;
		file = file.resolvePath("ver.stage3dvagal");
		fileStream = new FileStream();
		fileStream.open(file, FileMode.UPDATE);
		fileStream.writeBytes( byte );
		fileStream.close();
			
		var fagalcode:String = "mov oc, v0";
		byte = BaseStage3D.createFAGAL(fagalcode)
			
		file = File.desktopDirectory;
		file = file.resolvePath("ver.stage3dfagal");
		fileStream = new FileStream();
		fileStream.open(file, FileMode.UPDATE);
		fileStream.writeBytes( byte );
		fileStream.close();
	}
	

	private function loadFile( url:String ):void
	{
		var data:URLLoader = new URLLoader();
		data.dataFormat = URLLoaderDataFormat.BINARY;
		data.addEventListener(Event.COMPLETE, dataload_complate_handler );
		data.load( new URLRequest(url) );
	}
	
	private var files:Array = ["ver.stage3dvertex", "ver.stage3dindex",
		"ver.stage3dvagal", "ver.stage3dfagal"];
	private var bytes:Array = [];
	private var filesIndex:uint = 0;

	private var vdr:VertexDataRead = new VertexDataRead();
	private var idr:IndexDataRead = new IndexDataRead();
	private var vagal:ByteArray;
	private var fagal:ByteArray;
	private function dataload_complate_handler(evt:Event):void
	{
		var byte:ByteArray = evt.target.data;
		byte.endian = Endian.LITTLE_ENDIAN;
		bytes.push( byte );
		filesIndex++;
		if( filesIndex < files.length )
		{
			loadFile( files[ filesIndex ] );
		}
		else
		{
			updateAll();
		}
	}
	private function updateAll():void
	{
		vdr.read( bytes[0] );
		idr.read( bytes[1] );
		vagal = bytes[2] ;
		fagal = bytes[3];
		addTriangle3();
	}
	private function addTriangle3():void
	{
		_vb = _context3d.createVertexBuffer( vdr.numVertices, vdr.data32PerVertex );
		_vb.uploadFromByteArray( vdr.data, 0, 0, vdr.numVertices );
		_ib = _context3d.createIndexBuffer( idr.numVertices );
		_ib.uploadFromByteArray( idr.data, 0, 0, idr.numVertices );
		_pm = _context3d.createProgram();
		_pm.upload( vagal, fagal );
		_context3d.setVertexBufferAt( 0, _vb, 0, Context3DVertexBufferFormat.FLOAT_2 );
		_context3d.setVertexBufferAt( 1, _vb, 2, Context3DVertexBufferFormat.FLOAT_3 );
		_context3d.setProgram( _pm );
		
		_stage.addEventListener(Event.ENTER_FRAME, draw3 );

	}
	private function draw3(evt:Event):void
	{
		_context3d.clear( 0, 0, 0);
		_context3d.drawTriangles( _ib );
		_context3d.present();
	}
	//_______________________________________STAGE 3D______________________________________________________
	
	
	
	
	public function get DisplayLayer():Sprite
	{
		return displayLayer;
	}
	private var _stage:Stage
	
	private var bgLayer:Sprite;
	
	private var displayLayer:Sprite;
	
	private var maskLayer:Sprite;

	private var dlgLayer:Sprite
	public function setStage(stage:Stage):void
	{
		_stage = stage;
		
		bgLayer = new Sprite();
		displayLayer = new Sprite();
		maskLayer = new Sprite();
		dlgLayer = new Sprite();
		
		_stage.addChild(bgLayer);
		_stage.addChild(displayLayer);
		_stage.addChild(maskLayer);

		_stage.addChild(dlgLayer);

		_stage.addChild(new Stats());
		
	}
	
	public function addToBG(dim:DisplayObject):void
	{
		bgLayer.addChild(dim);
	}
	
	public function addToDisplay(dim:DisplayObject):void
	{
		displayLayer.addChild(dim);
	}
	
	public function addToMask(dim:DisplayObject):void
	{
		maskLayer.addChild(dim);
	}
	
	public function addToDlg(dim:DisplayObject):void
	{
		dlgLayer.addChild(dim);
	}
	
	
	public function removeToDisplay(dim:DisplayObject):void
	{
		displayLayer.removeChild(dim);
	}
	
	public function removeToBG(dim:DisplayObject):void
	{
		bgLayer.removeChild(dim);
	}
	
	public function removeToMask(dim:DisplayObject):void
	{
		maskLayer.removeChild(dim);
	}
	
	public function removeToDlg(dim:DisplayObject):void
	{
		dlgLayer.removeChild(dim);
	}
	
	
	public function addMask():void
	{
		
	}
	
	public function removeMask():void
	{
		
	}
	
	public function stageMode_TopLeft_Exactfit():void
	{
		_stage.align		=	StageAlign.TOP_LEFT;
		_stage.scaleMode	=	StageScaleMode.EXACT_FIT;
	}
	
	
	public function setEasyDraw(dim:Sprite):void
	{
		dim.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		dim.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	public function stopEastDraw(dim:Sprite):void
	{
		dim.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		dim.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	
	protected function onMouseDown(event:Event):void
	{
		//if (_dragable)
		{
			
			event.currentTarget.startDrag();
		}
	}
	
	protected function onMouseUp(event:MouseEvent):void
	{
		//if (_dragable)
		{
			event.currentTarget.stopDrag();
		}
	}
	
}
}


class instanceClass{}