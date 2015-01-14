package sdk.util
{
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class MouseUtil
	{
		public function MouseUtil()
		{
		}
		/**
		 * 
		 * @param obj
		 * @param callback function callback(target:Object):void;
		 * 
		 */		
		public static function addMouseDownEventHandler(obj:DisplayObject,callback:Function):void
		{
			var fun:Function=function(evt:TouchEvent):void
			{
				var touch:Touch=evt.getTouch(evt.currentTarget as DisplayObject,TouchPhase.BEGAN);
				if(touch==null) return;
				if(callback.length==0) callback();
				else callback(evt.currentTarget);
			};
			obj.addEventListener(TouchEvent.TOUCH,fun);
		}
		/**
		 * 
		 * @param obj
		 * @param callback function callback(target:Object):void;
		 * 
		 */		
		public static function addMouseUpEventHandler(obj:DisplayObject,callback:Function):void
		{
			var fun:Function=function(evt:TouchEvent):void
			{
				var touch:Touch=evt.getTouch(evt.currentTarget as DisplayObject,TouchPhase.ENDED);
				if(touch==null) return;
				if(callback.length==0) callback();
				else callback(evt.currentTarget);
			};
			obj.addEventListener(TouchEvent.TOUCH,fun);
		}
	}
}