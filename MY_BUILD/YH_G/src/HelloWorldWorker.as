package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	
	public class HelloWorldWorker extends Sprite
	{
		protected var mainToWorkeChannel:MessageChannel;
		protected var workerToMainChannel:MessageChannel;
		
		protected var worker:Worker;
		
		public function HelloWorldWorker()
		{
			
			if(Worker.current.isPrimordial){
				
				worker = WorkerDomain.current.createWorker(this.loaderInfo.bytes);
				

				mainToWorkeChannel = Worker.current.createMessageChannel(worker);
				workerToMainChannel = worker.createMessageChannel(Worker.current);
				
				worker.setSharedProperty("input", mainToWorkeChannel);
				worker.setSharedProperty("output", workerToMainChannel);
				workerToMainChannel.addEventListener(Event.CHANNEL_MESSAGE, onWorkerToMain);
				stage.addEventListener(MouseEvent.MOUSE_DOWN,clickStage);
				worker.start();
			} 
			else {
				mainToWorkeChannel = Worker.current.getSharedProperty("input");
				workerToMainChannel = Worker.current.getSharedProperty("output");
				mainToWorkeChannel.addEventListener(Event.CHANNEL_MESSAGE, onMainToWorker);
			}
		}
		//main to worker,run on the worker side;
		protected function onMainToWorker(event:Event):void {
			
			var msg:* = mainToWorkeChannel.receive();
			workerToMainChannel.send("I KNOW WHAT YOU \n"+msg);
			
		}
		
		//Worker to Main,run on the main side;
		protected function onWorkerToMain(event:Event):void {
			var mes:* =        workerToMainChannel.receive();                         trace(mes);
		}
		private function clickStage(e:MouseEvent):void
		{
			mainToWorkeChannel.send("I CLICKED THE STAGE");
			trace("SEND A MESSAGE TO WORKER,WAITTING FOR A RESPONSE》》");
		}
	}
}