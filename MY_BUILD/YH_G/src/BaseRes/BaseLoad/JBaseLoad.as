package BaseRes.BaseLoad
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import BaseRes.JBaseCacheManager;
	
	import BaseScene.core.JSceneStateMachine;
	import BaseScene.tScene.scene.StartScene;
	import BaseScene.tScene.view.LoadingView;
	
	public class JBaseLoad extends EventDispatcher
	{
		public function JBaseLoad()
		{
			initClass()
		}
		private function initClass():void
		{
			proLoadList = [];
		}
		
		private var m_loadInfo:JBaseLoadInfo;
		
		private var proLoadList:Array;
		public function setLoadData(loadInfo:JBaseLoadInfo):void
		{
			if( JBaseCacheManager.getInatsnce().isLoad(loadInfo,loadInfo.url) )
			{
				trace(loadInfo.url + "已存在加载历史中，")
				return;
			}
			if(null == m_loadInfo)
			{
				m_loadInfo = loadInfo;				
			}else
			{
				proLoadList.push(loadInfo);
			}
			//m_byte = null;
			//m_urlLoad = null;
		}
		
		private var m_byte:ByteArray;
		private var m_urlLoad:URLLoader;
		private var m_loading:Boolean = false
		public function load():void
		{
			if(null == m_loadInfo || m_loading )
			{
				//trace("找不到m_loadInfo 或者正在加载中")
				return;
			}
			m_loading = true;
			m_urlLoad= new URLLoader();
			m_urlLoad.dataFormat = URLLoaderDataFormat.BINARY;
			addEvent()
			var urlReq:URLRequest = new URLRequest(m_loadInfo.url);
			m_urlLoad.load(urlReq);
		}
		
		private function addEvent():void
		{
			m_urlLoad.addEventListener(Event.COMPLETE, onDataLoaded);
			m_urlLoad.addEventListener(ProgressEvent.PROGRESS, onDataProgress);
			m_urlLoad.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onDataSecurityError);
			m_urlLoad.addEventListener(IOErrorEvent.IO_ERROR, onDataFailed);
		}
		
		private function removeEvent():void
		{
			m_urlLoad.removeEventListener(Event.COMPLETE, onDataLoaded);
			m_urlLoad.removeEventListener(ProgressEvent.PROGRESS, onDataProgress);
			m_urlLoad.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onDataSecurityError);
			m_urlLoad.removeEventListener(IOErrorEvent.IO_ERROR, onDataFailed);
		}

		private function onDataLoaded(e:Event):void
		{
			m_byte = m_urlLoad.data as ByteArray;
			m_byte.position = 0;
			trace(m_loadInfo.url  + "二进制加载完成")
			var byteLoad:JBaseByteLoad =  JBaseByteLoad.creatByteLoad(m_byte,m_loadInfo);
			byteLoad.toLoad();

			m_loading = false;
			if(proLoadList.length == 0)
			{
				m_loadInfo = null;
				JSceneStateMachine.getInstance().changeScene(StartScene.getInstance());
				removeEvent();		
			}else
			{
				m_loadInfo = proLoadList.shift();
				load();
			}
		}
		
		private function onDataProgress(e:ProgressEvent):void
		{
			LoadingView.creatView().setPro("预加载" + m_loadInfo.url , e.bytesLoaded/e.bytesTotal);
		}
		private function onDataSecurityError(e:SecurityErrorEvent):void
		{

		}
		private function onDataFailed(e:IOErrorEvent):void
		{

		}
	}
}