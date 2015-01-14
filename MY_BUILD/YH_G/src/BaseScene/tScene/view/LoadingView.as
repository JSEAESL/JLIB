package BaseScene.tScene.view
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import BaseScene.tScene.AView;
	import BaseScene.tScene.IView;
	
	import BaseUI.BaseSprite;
	import BaseUI.JAutoLayout;
	import BaseUI.old.JButtonValue;
	
	public class LoadingView extends AView implements IView
	{
		public function LoadingView()
		{
			super();
		}
		
		
		private static var View:LoadingView;
		public static function creatView():LoadingView
		{
			if(null == View)
			{
				View = new LoadingView();
			}
			return View;
		}
		
		private var drawBg:BaseSprite
		
		private var sampValue:JButtonValue
		
		private var tf:TextField;
		private var tfdes:TextField;
		override protected function initView():void
		{
			drawBg = BaseSprite.creatSprite(0xFFFFf0)
			addChild(drawBg);
			tf = new TextField()
			tf.text = "0%"
			tf.type = TextFieldType.DYNAMIC;
			tf.width = 600
			JAutoLayout.oneCenter(tf)

			addChild(tf)
			
			tfdes = new TextField()
			tfdes.text = "nil"
			tfdes.type = TextFieldType.DYNAMIC;

			JAutoLayout.oneCenter(tfdes)
			tfdes.y = tfdes.y - 50;
	
			addChild(tfdes);
		}
		
		private var m_name:String;
		private var m_pro:Number;
		public function setPro(name:String,pro:Number):void
		{
			m_name = name;
			m_pro = pro;
			tf.text = m_name;
			tfdes.text = pro*100 + "%"
		}

		override public function toHide():void
		{
			
		}
		
		override public function toShow():void
		{
			
		}
		
		override public function toSleep():void
		{
			
		}
		
		override public function destroy():void
		{
			
		}

			
	}
}