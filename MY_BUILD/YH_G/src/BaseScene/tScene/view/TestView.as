package BaseScene.tScene.view
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import BaseRes.JBaseBMPCache;
	import BaseRes.BaseLoad.JBaseByteLoad;
	import BaseRes.BaseLoad.JBaseLoadInfo;
	
	import BaseScene.tScene.AView;
	import BaseScene.tScene.IView;
	import BaseScene.tScene.startMc.StartMc;
	
	import BaseUI.BaseSprite;
	import BaseUI.JAutoLayout;
	import BaseUI.old.JAButton;
	import BaseUI.old.JButtonDeco;
	
	import BaseWorker.BaseWorkerManager;
	import BaseWorker.WorkConst;
	
	public class TestView extends AView implements IView
	{
		public function TestView()
		{
			super();
		}
		private var drawBg:BaseSprite
		private var mc:StartMc;
		override protected function initView():void
		{
			
			drawBg = BaseSprite.creatSprite(0xf0f0f0)
			addChild(drawBg);
			
			//线程注册
			//线程回调
			//BaseWorkerManager.getInstance().resSwfAndKey("First",Workers.BaseWorker_OtherWorker,BackFun)
			//线程初始化
			//BaseWorkerManager.getInstance().init();


			var btn:JButtonDeco =  new JButtonDeco("JSEA",new JAButton(loadRes));
			JAutoLayout.oneBestCenter(btn);
			addChild(btn);
			
			
			//画六边形相关
/*			mc  = new StartMc();
			JAutoLayout.twoBestCenter(mc);
			addChild(mc)

*/
			
		}
		

		private function loadRes():void
		{
			BaseWorkerManager.getInstance().getToOtherChannel("First").send("send Mes")
				
				//.send("..........")

			//画六边形相关
			//mc.update();
			
			//JBaseBMPCache.getInstance().cleanDirectory("aa")
			//return;
			//var f:File = new File();
			//f.browseForDirectory("请选择文件夹");
			//f.addEventListener(Event.SELECT,onOpenSelected);
		}
		
		private function BackFun(event:Event):void
		{
			var mes:* = BaseWorkerManager.getInstance().getToMailChannel(WorkConst.FIRST).receive();     
			trace("BackFun:  " + mes);

		}

		
		private var loadLen:uint = 0;
		private function onOpenSelected(e:Event):void
		{
			var list:Array =  e.target.getDirectoryListing();
			loadLen = list.length;
			if(loadLen)
			{
				loadList(list);
			}
		}
		
		private function loadList(filelist:Array):void
		{
			//var J:JBaseByteLoad =  JBaseByteLoad.creartFileLoad(filelist[0]);
			//J.toLoadFile();
			//return;
			for each(var f:File in filelist)
			{
				
				//m_loadInfo = new JBaseLoadInfo()	
				//m_loadInfo.type = JBaseLoadInfo.BMP_TYPE;
				//m_loadInfo.url = m_file.url;
				//m_loadInfo.callBack = callBack 
				//m_loadInfo.caller= caller

				
				var J:JBaseByteLoad =  JBaseByteLoad.creartFileLoad(f,JBaseLoadInfo.creatInfo(f.url,JBaseLoadInfo.BMP_TYPE,"0",this,checkFun));
				J.toLoadFile();
			}
		}
		
		private function checkFun(count:Number):void
		{
			trace("count " + count )
			trace("loadLen " + loadLen)
			if(count == loadLen)
			{
				trace("complete")
				JBaseBMPCache.getInstance().saveBySize(loadLen);
			}
		}
		
		
		private function onFileError(e:IOErrorEvent):void
		{
			trace("!!!!!" + e)
		}
		private function onFileLoaded(e:Event):void
		{
			var _fileStream:FileStream=FileStream(e.currentTarget);
			var _byteArr:ByteArray=new ByteArray();
			_fileStream.readBytes(_byteArr, 0, _fileStream.bytesAvailable);
			_fileStream.close();
			var _loader:Loader;
		}
		
		

		
		private static var View:TestView;
		public static function creatView():TestView
		{
			if(null == View)
			{
				View = new TestView();				
			}
			return View;
		}
		
		override public function toShow():void
		{
			addEvent();
			
		}
		private function addEvent():void
		{
			addEventListener(MouseEvent.CLICK,onClick);
		}
		private function removeEvent():void
		{
			removeEventListener(MouseEvent.CLICK,onClick);
		}
		//private var showBit:Bitmap;
		private function onClick(e:MouseEvent):void
		{
			//showBit = new Bitmap()
		}
		
		
		override public function toSleep():void
		{
			
		}
		
		override public function toHide():void
		{
			
		}
		
		override public function destroy():void
		{
			
		}
	}
}