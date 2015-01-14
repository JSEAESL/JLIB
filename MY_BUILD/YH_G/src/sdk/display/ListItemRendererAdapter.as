package sdk.display
{
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import sdk.util.MouseUtil;
	
	import starling.events.Event;
	
	public class ListItemRendererAdapter extends FeathersControl implements IListItemRenderer
	{
		public function ListItemRendererAdapter()
		{
			super();
			MouseUtil.addMouseUpEventHandler(this,onClick);
		}
		protected function onClick():void
		{
			//this.owner.selectedIndex=-1;
			if(this.owner==null) return;
			if(this.owner.selectedIndex!=this.index)
			{
				this.dispatchEventWith(Event.CHANGE);
			}
			else
			{
				this.owner.dispatchEventWith(Event.CHANGE);
			}		
		}
		private var _selected:Boolean=false;
		public function get isSelected():Boolean
		{
			return _selected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			if(_selected==value) return;
			_selected=value;
			this.bindData(this.data);
		}
		private var _data:Object=null;
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			var changed:Boolean=(_data!=value);
			_data=value;
			if(changed) bindData(value);
		}
		protected function bindData(data:Object):void
		{
			
		}
		private var _index:int=-1;
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index=value;
		}
		private var _owner:List=null;
		public function get owner():List
		{
			return _owner;
		}
		
		public function set owner(value:List):void
		{
			_owner=value;
		}
		
	}
}