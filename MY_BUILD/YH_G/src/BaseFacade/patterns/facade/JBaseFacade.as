package BaseFacade.patterns.facade
{
	import BaseFacade.core.JController;
	import BaseFacade.core.JModel;
	import BaseFacade.core.JView;
	import BaseFacade.interfaces.IController;
	import BaseFacade.interfaces.IFacade;
	import BaseFacade.interfaces.IMediator;
	import BaseFacade.interfaces.IModel;
	import BaseFacade.interfaces.IProxy;
	import BaseFacade.interfaces.IView;

	public class JBaseFacade implements IFacade
	{
		
		private static var _instanceList:Array = [];
		
		public function JBaseFacade(insClass:InstanceClass,key:String)
		{
			if( null == key) 
				throw new Error("not find key");
			initNotifer(key);
			initFacade();
			
			
		}
		
		private var m_key:String;
		public static function getInstance(key:String):JBaseFacade
		{
			if(null == _instanceList[key])	
			{
				_instanceList[key] = new JBaseFacade(new InstanceClass() ,key)
			}
			return _instanceList[key];
		}
		
		protected function initNotifer(key:String):void
		{
			m_key = key
		}
		
		protected function initFacade():void
		{
			initModel();
			initContrl();
			initView();
		}
		
		private var controller:IController;
		private var model:IModel;
		private var view:IView;
		
		protected function initModel():void
		{
			if(null == model )
			{
				model = JModel.getInstance(m_key);
			}
		}

		protected function initContrl():void
		{
			if(null == JController )
			{
				controller = JController.getInstance(m_key);
			}
		}

		protected function initView():void
		{
			if(null == JView)	
			{
				view = JView.getInstance(m_key);
			}
		}



		public function regProxy(Proxy:IProxy):void
		{
			model.registerProxy(Proxy);
		}
		
		public function regMediator(Mediator:IMediator):void
		{
			view.registerMediator(Mediator);
		}
		
		public function registerCommand( noteName : String, commandClassRef : Function ) : void
		{
			controller.registerCommand(noteName,commandClassRef);
		}
		
		
		public function retProxy(ProxyName:String):void
		{
		}
		
		public function retMediator(MediatorName:String):void
		{
		}
		
		public function sendNotifer(name:String, data:Object, key:String):void
		{
		}
	}
}
class InstanceClass{}