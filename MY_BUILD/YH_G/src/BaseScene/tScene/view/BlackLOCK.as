package BaseScene.tScene.view
{
	import flash.display.Sprite;
	
	import Const.BaseConst;

	public class BlackLOCK extends Sprite
	{
		private var m_SP:Sprite;
		private var m_offx:Number;
		private var m_offy:Number;
		public function BlackLOCK(offX:Number = 30,offY:Number = 30)
		{
			m_offx = offX;
			m_offy = offY;
			drawX = 0;
			drawY = 0;
			//draw();
			drawlock()
		}

		private var drawX:Number;
		private var drawY:Number;
		private function draw():void
		{
			//while(drawX<BaseConst.FULL_WIDTHT&& drawY<BaseConst.FULL_HEIGHT)
			//{
			//}
			var draw:Sprite = new Sprite();
			draw.graphics.lineStyle(1,0xFFFFFF);
			for(var m_x:Number = 0; m_x<=BaseConst.FULL_WIDTHT; m_x += m_offx)
			{
				for(var m_y:Number = 0; m_y<=BaseConst.FULL_HEIGHT; m_y += m_offy)
				{
					draw.graphics.moveTo(m_x,0);
					draw.graphics.lineTo(m_x,m_y);
					draw.graphics.moveTo(0,m_y);
					draw.graphics.lineTo(m_x,m_y);
				}

			}
			addChild(draw);
		}
		
		private function drawlock():void
		{
			for(var m_x:Number = 0; m_x<BaseConst.FULL_WIDTHT; m_x += m_offx)
			{
				for(var m_y:Number = 0; m_y<BaseConst.FULL_HEIGHT; m_y += m_offy)
				{
					Lock.creatLock(m_x,m_y,this)
				}	
			}
			trace("drawlock  " + Lock.lockCount)
		}
	}
}