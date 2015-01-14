package BaseRes
{
	import flash.display.BitmapData;
	import BaseRes.BaseLoad.JBaseLoad;
	import BaseRes.BaseLoad.JBaseLoadInfo;

	public class JBaseResManager
	{
		private static var _instance:JBaseResManager;
		public static function getInstance():JBaseResManager
		{
			if(null == _instance)
			{
				_instance = new JBaseResManager();
			}
			return _instance;
		}

		public function JBaseResManager()
		{
			initClass();
		}

		private var BaseLoad:JBaseLoad; 
		private function initClass():void
		{
			BaseLoad = new JBaseLoad();

		}

		public function firstLoad():void
		{
			BaseLoad.setLoadData(JBaseLoadInfo.creatInfo("res/baseRes.xml",JBaseLoadInfo.XML_TYPE,"1",this,fristComFun))
			BaseLoad.load();
		}

		private function fristComFun(data:Object,type:String,load:*):void
		{
			var xml:XML = data as XML;
			getAttributesXml(xml,xml);
		}

		private function getAttributesXml(xml:XML,orgXml:XML):void
		{
			var xmlname:String = xml.@xmlName;
			var isRes:Boolean = Number(xml.@isRes);
			var hasRes:Boolean = Number(xml.@hasRes);
			var newXml:XML;
			if(xmlname)
			{
				var dimXml:XML = hasRes? xml:orgXml;
				var resNode:XMLList = dimXml.elements(xmlname)
				for each(var i:XML in resNode)
				{
					getAttributesXml(i,orgXml);
				}
			}
			if(isRes)
			{
				loadResXml(xml)
			}

		}

		private function loadResXml(xml:XML):void
		{
			var id:String = xml.@id;
			var url:String = xml.@url;
			var type:String = xml.@type;
			BaseLoad.setLoadData(JBaseLoadInfo.creatInfo(url,type,id,this,getCallBackFun(type) ))
			BaseLoad.load();
		}

		public function getCallBackFun(type:String):Function
		{
			var result:Function;
			switch(type)
			{
				case JBaseLoadInfo.XML_TYPE:
					result = xmlLoadComFun;
				break;
				case JBaseLoadInfo.IMG_TYPE:
					result = imgLoadComFun;
				break;
				case JBaseLoadInfo.MP3_TYPE:
					result = map3LoadComFun;
				break;
			}
			return result
		}

		private function xmlLoadComFun(data:Object,type:String,load:*):void
		{
			var xml:XML = data as XML;
			trace("!!!!!!!!!!!!!XML加载完成!!!!!!!!!" + load.url)

			getAttributesXml(xml,xml);
		}

		private function map3LoadComFun(data:Object,type:String,load:*):void
		{
			if(data)
			{
				trace("!!!!!!!!!!!!!MP3加载完成!!!!!!!!!" + load.url)
				return;
			}
			trace("!!!!!!!!!!!!!MP3加载完成!!!!!!!!!" + load.url)
		}

		private function imgLoadComFun(data:BitmapData,type:String,load:*):void
		{
			trace("!!!!!!!!!!!!!img加载完成!!!!!!!!!" + load.url)
			JBaseCacheManager.getInatsnce().pushNewBitmapData(load.id,data)
		}


	}
}