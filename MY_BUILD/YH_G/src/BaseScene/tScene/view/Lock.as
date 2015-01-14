package BaseScene.tScene.view
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class Lock 	
	{
		private var m_x:Number;
		private var m_y:Number;
		private var m_lock:Sprite;
		private var m_father:Sprite
		
		private static var LockList:Dictionary = new Dictionary()
		public static var lockCount:Number = 0;
		
		public function Lock(x:Number,y:Number,father:Sprite)
		{
			m_x = x;
			m_y = y;
			m_father = father;
			init();
			draw();
		}
		
		private function init():void
		{
			
		}
		private function draw():void
		{
			m_lock = new Sprite();
			m_lock.graphics.lineStyle(1,0xffffff);
			m_lock.graphics.drawRect(m_x,m_y,30,30)
			LockList[m_x +"_" + m_y] = this;
			m_father.addChild(m_lock);
		}
		public static function creatLock(x:Number,y:Number,father:Sprite):Lock
		{
			if(!LockList[x +"_" + y])
			{
				lockCount++;

				return new Lock(x,y,father);
			}	
			return LockList[x +"_" + y]
		}
	}
}