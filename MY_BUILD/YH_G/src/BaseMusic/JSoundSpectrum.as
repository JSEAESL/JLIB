package BaseMusic
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import BaseUI.JStageManager;
	
	public class JSoundSpectrum extends Sprite
	{
		public function JSoundSpectrum()
		{
			super();
			initClass();
		}
		
		public static  function creat():JSoundSpectrum
		{
			var result:JSoundSpectrum = new JSoundSpectrum();
			return result;
		}
		
		private var　rectDic:Dictionary;
		
		private var G:GSpectrumRect;
		private function initClass():void
		{
			
			JStageManager.instance.setEasyDraw(this);
	 		//G = new  GSpectrumRect()
			initOSpectrumRect(); //简易 频谱例子
			//initMixBP();
		}
		
		private var mixBD:BitmapData;
		private var mixBP:Bitmap;
		private var byteDic:Dictionary;
		private function initMixBP():void
		{	
			const PLOT_HEIGHT:int = PLOT_HEIGHT*H;//100
			const CHANNEL_LENGTH:int = CHANNEL_LENGTH;
			const PLOT_WEIGHT:Number = PLOT_WEIGHT*W;//1
			mixBD = new BitmapData(256,200,true,0);
			mixBP = new Bitmap(mixBD);
			mixBP.filters = [new BlurFilter(4, 4, 1)];
			addChild(mixBP);
			byteDic = new Dictionary();
		}
		
		private function initOSpectrumRect():void
		{
			rectDic = new Dictionary();
			var rectMain:Sprite = new Sprite();
			addChild(rectMain);
			var rect:OSpectrumRect;
			for(var index:int = 0; index<64; index++)
			{
				rect = new OSpectrumRect(5,128);
				rect.y = 0;
				rect.x = index*6;
				rectDic[index] = rect;
				rectMain.addChild(rect);
			}
		}
		
		public  function  start():void
		{
			
			//addEventListener(Event.ENTER_FRAME,G.onFrame);
			addEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME,onEnter);
		}
		
		private static var m_Channel:SoundChannel;
		public static function updataChannel(soundChannel:SoundChannel):void
		{
			m_Channel = soundChannel
			//m_Channel.addEventListener(Event.SOUND_COMPLETE,onPlaybackComplete);
		}
		
		private static var W:Number = 0.5;
		public static function setW(w:Number):void
		{
			W = w;
		}
		private static var H:Number = 2;
		public static function setH(h:Number):void
		{
			H = h;
		}
		private var PLOT_HEIGHT:int = 100;//200
		private var CHANNEL_LENGTH:int = 256;
		private var PLOT_WEIGHT:Number = 2;//1
		
		private function onEnter(e:Event):void
		{
			var bytes:ByteArray = new ByteArray();
			const PLOT_HEIGHT:int = PLOT_HEIGHT*H;//200
			const CHANNEL_LENGTH:int = CHANNEL_LENGTH;
			const PLOT_WEIGHT:Number = PLOT_WEIGHT*W;//1
			//SoundMixer.computeSpectrum(bytes, true, 0); // 频谱
			//SoundMixer.computeSpectrum(bytes, false, 0); // 波形图
			


			
			//var g:Graphics = this.graphics;
		
			//g.clear();
		
			defDrwaFun(bytes/*,PLOT_HEIGHT,CHANNEL_LENGTH,PLOT_WEIGHT*/); //as3.0 例子 波形图
			
			//defDrwaFun2(bytes,PLOT_HEIGHT,CHANNEL_LENGTH,PLOT_WEIGHT); //简易 频谱例子
			//defDrwaFun3(bytes,PLOT_HEIGHT,CHANNEL_LENGTH,PLOT_WEIGHT); //简易 频谱例子

		}
		

		
		private function defDrwaFun3(bytes:ByteArray,PLOT_HEIGHT:Number,CHANNEL_LENGTH:int,PLOT_WEIGHT:Number):void
		{
			mixBD.applyFilter(mixBD, new Rectangle(0, 0, mixBD.width, mixBD.height), new Point(), new BlurFilter(2, 2, 1));
			mixBD.colorTransform(new Rectangle(0, 0, mixBD.width, mixBD.height), new ColorTransform(1, 1, 1, 0.995));
			var max:int
			var color:uint = 0xFFd90101
			for (var i:int = 0; i < 128; i++) {

				max = PLOT_HEIGHT * byteDic[i*2];
				for (var w:int = 0 ; w < max ; w++) {
					mixBD.setPixel32(128-i, w, color);
				}
				mixBD.setPixel32(128 - i, max + 0, color);
			}
			for (var i:int = 129; i < 256; i++) {
				max = PLOT_HEIGHT * byteDic[i*2];
				for (var w:int = 0 ; w < max ; w++) {
					mixBD.setPixel32(i, w, color);
				}
				mixBD.setPixel32(i, max + 0, color);
			}
			//trace(bytes.readFloat())
			bytes.position = 0;
			for(var index:int = 0; index<512;index++)
			{
				byteDic[index] = bytes.readFloat();
			}
			bytes.position = 0;
		}

		private function defDrwaFun2(bytes:ByteArray,PLOT_HEIGHT:Number,CHANNEL_LENGTH:int,PLOT_WEIGHT:Number):void
		{
			bytes.position = 0
			for(var index:int = 0; index < 64; index++){
				var a:Number = 0.0;
				bytes.position = index * 16;//将指针移到左声道的相应位置
				a = bytes.readFloat() + bytes.readFloat() + bytes.readFloat() + bytes.readFloat();//读取4个连续的数据
				
				bytes.position = 1024 + index * 16;//将指针移到右声道的相应位置
				a += bytes.readFloat() + bytes.readFloat() + bytes.readFloat() + bytes.readFloat();//读取4个连续的数据                
				var r:OSpectrumRect = OSpectrumRect(rectDic[index]);
				r.update(a / 6);//更新柱体长度,除以一个平均因数,大家也许可以试着改一下6为其它的数字试试
			}
		}

		private function defDrwaFun(bytes:ByteArray/*,PLOT_HEIGHT:Number,CHANNEL_LENGTH:int,PLOT_WEIGHT:Number*/):void
		{

			const PLOT_HEIGHT:int = 200;
			const CHANNEL_LENGTH:int = 256;
			
			SoundMixer.computeSpectrum(bytes, false, 0);
			
			var g:Graphics = this.graphics;
			
			g.clear();
			
			g.lineStyle(0, 0x6600CC);
			g.beginFill(0x6600CC);
			g.moveTo(0, PLOT_HEIGHT);
			
			var n:Number = 0;
			
			for (var i:int = 0; i < CHANNEL_LENGTH; i++) {
				n = (bytes.readFloat() * PLOT_HEIGHT);
				g.lineTo(i * 2, PLOT_HEIGHT - n);
			}
			
			g.lineTo(CHANNEL_LENGTH * 2, PLOT_HEIGHT);
			g.endFill();
			
			g.lineStyle(0, 0xCC0066);
			g.beginFill(0xCC0066, 0.5);
			g.moveTo(CHANNEL_LENGTH * 2, PLOT_HEIGHT);
			
			for (i = CHANNEL_LENGTH; i > 0; i--) {
				n = (bytes.readFloat() * PLOT_HEIGHT);
				g.lineTo(i * 2, PLOT_HEIGHT - n);
			}
			
			g.lineTo(0, PLOT_HEIGHT);
			g.endFill();

			
			
			return;
			var g:Graphics = this.graphics;
			g.lineStyle(0, 0xFFFFFF);
			g.beginFill(0xFFFFFF);
			g.moveTo(0, PLOT_HEIGHT);
			
			var n:Number = 0;
			
			for (var i:int = 0; i < CHANNEL_LENGTH; i++) {
				n = (bytes.readFloat() * PLOT_HEIGHT);
				g.lineTo(i * PLOT_WEIGHT, PLOT_HEIGHT - n);
			}
			
			g.lineTo(CHANNEL_LENGTH * PLOT_WEIGHT, PLOT_HEIGHT);
			g.endFill();
			
			

			
			/*g.lineStyle(0, 0xCC0066);
			g.beginFill(0xCC0066, 0.5);
			g.moveTo(CHANNEL_LENGTH * PLOT_WEIGHT, PLOT_HEIGHT);
			
			for (i = CHANNEL_LENGTH; i > 0; i--) {
				n = (bytes.readFloat() * PLOT_HEIGHT);
				g.lineTo(i * PLOT_WEIGHT, PLOT_HEIGHT - n);
			}
			
			g.lineTo(0, PLOT_HEIGHT);
			g.endFill();*/
		}
		

	}
}