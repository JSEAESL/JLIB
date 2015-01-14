package BaseMusic
{
	

import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;    

public class OSpectrumRect extends Sprite{
	private var s:Sprite; //柱状体
	private var z:Sprite; //柱状体上的小方块
	private var timer:Timer;
	private var h:Number;
	
	public function OSpectrumRect(_width:Number,_height:Number,color:uint = 0xFFFFFF){
		s = new Sprite();
		
		//画柱状体
		s.graphics.beginFill(color);
		s.graphics.drawRect(0,0,_width,_height);
		s.graphics.endFill();
		
		//旋转180度柱体才会从上往下降
		s.rotation = 180;
		s.height = 0;
		s.y = _height;
		addChild(s);
		
		h = _height;//记录最高长度
		
		var zHeight:Number = 2;//块状体高
		z = new Sprite();
		z.graphics.beginFill(0x2AEAEB);
		z.graphics.drawRect(0,0,_width,zHeight);
		z.graphics.endFill();
		z.y = _height - zHeight;
		z.rotation = 180;
		addChild(z);
		
		timer = new Timer(40);
		timer.addEventListener(TimerEvent.TIMER,onTimer);
		timer.start();
	}       
	
	private function onTimer(e:TimerEvent):void{
		if(s.height > 0){
			var speed:Number = 0.02 * h;//柱状体下降的速度
			if(speed > s.height)s.height = 0;
			else s.height -= speed;        
		}
		if(z.y + z.height >= h - s.height){
			z.y = h - s.height - z.height;
		}
		else{
			var zspeed:Number = 0.01 * h;
			z.y += zspeed;
		}
		
	}    
	//更新柱体的高度,仅只当设置的高度比当前的高度还要高的时候才更新.
	public function update(percent:Number):void{
		if(percent>1.0) percent = 1.0;        
		
		if(s.height < h * percent){
			s.height = h * percent;
			if(z.y + z.height >= h - s.height){
				z.y = h - s.height - z.height;
			}
		}        
	}
}
}