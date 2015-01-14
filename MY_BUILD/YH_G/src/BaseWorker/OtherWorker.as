package BaseWorker
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	
	public class OtherWorker extends Sprite
	{
		public function OtherWorker()
		{
			init();
		}
		
		private var _mainToWorker:MessageChannel ;
		private var _workerToMain:MessageChannel ;
		private function init():void
		{
			//if(!Worker.current.isPrimordial)
			try
			{
				_mainToWorker=Worker.current.getSharedProperty(WorkConst.FIRST  +  WorkConst.TO_WORK );
				_mainToWorker.addEventListener(Event.CHANNEL_MESSAGE, onMainToBack);
				
				//使用backToMain
				_workerToMain=Worker.current.getSharedProperty(WorkConst.FIRST  + WorkConst.TO_MAIN );
			}
			catch (error:Error)
			{
				//trace(error)
				//init();
			}
		}
		
		private function onMainToBack(e:Event):void
		{
			if(_mainToWorker.messageAvailable)
			{
				var msg:* = _mainToWorker.receive()
				trace("onMainToBack  " + msg)
				_workerToMain.send("First get Msg")
			}
		}
		
		
		
	}
}