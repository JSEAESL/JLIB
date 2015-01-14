package BaseWorker
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class BaseWorkerManager extends Sprite
	{
		
		private static var ins:BaseWorkerManager;
		public static function getInstance():BaseWorkerManager
		{
			if(null == ins)
			{
				ins = new BaseWorkerManager(new insClass())
			}
			return ins;
		}
		public function BaseWorkerManager(cs:insClass)
		{
			initClass();
		}
		private var workSwfDic:Dictionary;
		private function initClass():void
		{	
			workSwfDic = new Dictionary();
		}
		
		public function resSwfAndKey(key:String,swf:ByteArray,mesBack:Function):void
		{
			//KEY First
			workSwfDic[key] = {"KEY":key,"SWF":swf,"mesBack":mesBack};
		}
		
		public function init():void
		{

			if(Worker.current.isPrimordial)
			{
				for (var key:String in workSwfDic)
				{
					creatWork(workSwfDic[key])
				}
			}
		}
		
		
		private  function creatWork(data:Object):void
		{
			var otherWork:Worker = WorkerDomain.current.createWorker(data.SWF);
			var mainToOtherChannel:MessageChannel = Worker.current.createMessageChannel(otherWork);
			
			var otherToMailChannel:MessageChannel = otherWork.createMessageChannel(Worker.current);
			otherToMailChannel.addEventListener(Event.CHANNEL_MESSAGE,data.mesBack);
			//otherToMailChannel.addEventListener(Event.CHANNEL_MESSAGE,mesCallBack);
			//First
			otherWork.setSharedProperty(data.KEY + WorkConst.TO_WORK ,mainToOtherChannel);
			otherWork.setSharedProperty(data.KEY +  WorkConst.TO_MAIN ,otherToMailChannel);
			
			data.otherToMail = 	otherToMailChannel;
			data.mainToOther = mainToOtherChannel;
			workSwfDic[data.KEY] = data;

			otherWork.start();
		}
		
		private function mesCallBack(e:Event):void
		{
			var mes:* = BaseWorkerManager.getInstance().getToMailChannel("First").receive();     
			trace("mesCallBack:" + mes);
		}
		
		public function getToMailChannel(key:String):MessageChannel
		{
			return 	workSwfDic[key].otherToMail;
		}
		
		public function getToOtherChannel(key:String):MessageChannel
		{
			return 	workSwfDic[key].mainToOther;
		}
	}
}
class insClass{}




