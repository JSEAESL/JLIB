package sdk.util
{
	import feathers.core.FeathersControl;
	
	import starling.display.DisplayObject;

	public class AutoLayout
	{
		private var current:Object=null;
		
		public function AutoLayout()
		{
			
		}
		public function begin(obj:DisplayObject,validate:Boolean=false):AutoLayout
		{
			this.current=obj;
			if(validate)
			{
				if(obj is FeathersControl) (obj as FeathersControl).validate();
			}
			return this;
		}
		public function begins(objs:Vector.<*>,validate:Boolean=false):AutoLayout
		{
			this.current=objs;
			if(validate)
			{
				for each(var obj:FeathersControl in objs)
				{
					if(obj!=null) obj.validate();
				}
			}
			return this;
		}
		public function left(value:int):AutoLayout
		{
			if(current is DisplayObject)
			{
				var obj:DisplayObject=this.current as DisplayObject;
				obj.x=value;
			}
			else
			{
				var objs:Vector.<*>=this.current as Vector.<*>;
				for each(obj in objs)
				{
					obj.x=value;
				}
			}
			return this;
		}
		public function top(value:int):AutoLayout
		{
			if(current is DisplayObject)
			{
				var obj:DisplayObject=this.current as DisplayObject;
				obj.y=value;
			}
			else
			{
				var objs:Vector.<*>=this.current as Vector.<*>;
				for each(obj in objs)
				{
					obj.y=value;
				}
			}
			return this;
		}
		public function right(value:int):AutoLayout
		{
			if(current is DisplayObject)
			{
				var obj:DisplayObject=this.current as DisplayObject;
				obj.x=obj.parent.width-obj.width-value;
			}
			else
			{
				var objs:Vector.<*>=this.current as Vector.<*>;
				for each(obj in objs)
				{
					obj.x=obj.parent.width-obj.width-value;
				}
			}
			return this;
		}
		public function bottom(value:int):AutoLayout
		{
			if(current is DisplayObject)
			{
				var obj:DisplayObject=this.current as DisplayObject;
				obj.y=obj.parent.height-obj.height-value;
			}
			else
			{
				var objs:Vector.<*>=this.current as Vector.<*>;
				for each(obj in objs)
				{
					obj.y=obj.parent.height-obj.height-value;
				}
			}
			return this;
		}
		public function horzCenter(value:int):AutoLayout
		{
			if(current is DisplayObject)
			{
				var obj:DisplayObject=this.current as DisplayObject;
				obj.x=obj.parent.width/2-obj.width/2+value;
			}
			else
			{
				var objs:Vector.<*>=this.current as Vector.<*>;
				for each(obj in objs)
				{
					obj.x=obj.parent.width/2-obj.width/2+value;
				}
			}
			return this;
		}
		public function vertCenter(value:int):AutoLayout
		{
			if(current is DisplayObject)
			{
				var obj:DisplayObject=this.current as DisplayObject;
				obj.y=obj.parent.height/2-obj.height/2+value;
			}
			else
			{
				var objs:Vector.<*>=this.current as Vector.<*>;
				for each(obj in objs)
				{
					obj.y=obj.parent.height/2-obj.height/2+value;
				}
			}
			return this;
		}
		public function collectionHorzFlow(gap:int):AutoLayout
		{
			var objs:Vector.<*>=this.current as Vector.<*>;
			var totalWidth:int=(objs.length-1)*gap;
			for each(var obj:DisplayObject in objs)
			{
				totalWidth+=obj.width;
			}
			var tx:int=0;
			for each(obj in objs)
			{
				obj.x=tx;
				tx+=obj.width;
				tx+=gap;
			}
			return this;
		}
		public function collectionSetX(start:int,step:int):AutoLayout
		{
			var objs:Vector.<*>=this.current as Vector.<*>;
			for(var i:int=0;i<objs.length;i++)
			{
				var obj:DisplayObject=objs[i];
				obj.x=start+step*i;
			}
			return this;
		}
		public function collectionSetY(start:int,step:int):AutoLayout
		{
			var objs:Vector.<*>=this.current as Vector.<*>;
			for(var i:int=0;i<objs.length;i++)
			{
				var obj:DisplayObject=objs[i];
				obj.y=start+step*i;
			}
			return this;
		}
		public function collectionHorzCenter(value:int):AutoLayout
		{
			var objs:Vector.<*>=this.current as Vector.<*>;
			var minX:int=int.MAX_VALUE;
			var maxX:int=int.MIN_VALUE;
			var parentWidth:int=0;
			for each(var obj:DisplayObject in objs)
			{
				parentWidth=obj.parent.width;
				if(obj.x<minX) minX=obj.x;
				if(obj.x+obj.width>maxX) maxX=obj.x+obj.width;
			}
			var offset:int=parentWidth/2-(maxX-minX)/2+value-minX;
			for each(obj in objs)
			{
				obj.x+=offset;
			}
			return this;
		}
	}
}