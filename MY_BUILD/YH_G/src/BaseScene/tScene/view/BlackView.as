package BaseScene.tScene.view
{
	import BaseScene.tScene.AView;
	import BaseScene.tScene.IView;
	
	import BaseUI.BaseSprite;

	public class BlackView extends AView implements IView
	{
		public function BlackView()
		{
		}
		
		
		private static var View:BlackView;
		public static function creatView():BlackView
		{
			if(null == View)
			{
				View = new BlackView()
			}
			return View;
		}
		

		
		private var drawBg:BaseSprite;
		private var lock:BlackLOCK;
		override protected function initView():void
		{
			drawBg = BaseSprite.creatSprite(null)
			lock = new BlackLOCK();
			addChild(drawBg);
			addChild(lock);
			
		}
		
		override public function toShow():void
		{
		}
		
		override public function toHide():void
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