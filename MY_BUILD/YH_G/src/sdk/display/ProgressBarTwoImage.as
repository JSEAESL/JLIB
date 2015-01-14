package sdk.display
{
	import flash.geom.Rectangle;
	
	import feathers.core.FeathersControl;
	
	import starling.display.Image;
	
	public class ProgressBarTwoImage extends FeathersControl
	{
		private var bg:Image;
		private var value:Image;
		private var valueContainer:FeathersControl;
		private var ratio:Number=0;
		
		private var leftSpan:int;
		private var rightSpan:int;
		public function ProgressBarTwoImage(bg:Image,value:Image,leftSpan:int=0,rightSpan:int=0)
		{
			super();
			this.bg=bg;
			this.value=value;
			this.leftSpan=leftSpan;
			this.rightSpan=rightSpan;
		}
		override protected function initialize():void
		{
			super.initialize();
			valueContainer=new FeathersControl();
			if(this.bg!=null)
			{
				addChild(bg);
				this.setSizeInternal(bg.width,bg.height,false);
				valueContainer.addChild(value);
				valueContainer.x=(bg.width-value.width)/2;
				valueContainer.y=(bg.height-value.height)/2;
			}
			else
			{
				this.setSizeInternal(value.width,value.height,false);
				valueContainer.addChild(value);
			}
			addChild(valueContainer);
			setRatio(this.ratio);
		}
		
		override protected function draw():void
		{
			// TODO Auto Generated method stub
			super.draw();
		}
		
		public function setRatio(ratio:Number):void
		{
			if(ratio==1)
			{
				valueContainer.clipRect=null;
			}
			else
			{
				valueContainer.clipRect=new Rectangle(0,0,int(Math.max(2,int((value.width-leftSpan-rightSpan)*ratio+leftSpan))),int(value.height));
			}
		}
		public function setValue(cur:int,max:int):void
		{
			if(max==0) setRatio(1);
			else if(cur>=max) setRatio(1);
			else this.setRatio(cur*1.0/max);
		}
	}
}