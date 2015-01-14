package BaseUI
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class ColourBg extends Sprite
	{	
		public function ColourBg()
		{
			super();
		}
		
		public static function creatColourBg(colour:Number,width:Number,height:Number,alpha:Number):ColourBg
		{
			var result:ColourBg = new ColourBg();
			result.setPro(colour,width,height,alpha)
			return result;
		}
		
		private var m_bg:Shape;
		
		private function cleanBg():void
		{
			if(m_bg)
			{
				this.removeChild(m_bg);
				m_bg = null;
			}

		}
		
		private function init(colour:Number,width:Number,height:Number,alpha:Number = 1):void
		{
			cleanBg();
			
			m_bg = new Shape();
			m_bg.graphics.lineStyle(0,0xFF0000,1)
			m_bg.graphics.beginFill(colour,alpha);
			m_bg.graphics.drawRect(0,0,width,height);
			m_bg.graphics.endFill();
			this.addChild(m_bg);
		}
		
		private var m_colour:Number;
		private var m_width:Number;
		private var m_height:Number;
		private var m_alpha:Number;
		public function setPro(colour:Number,width:Number,height:Number,alpha:Number = 1):void
		{
			m_colour = colour;
			m_width = width;
			m_height = height;
			m_alpha = alpha;
			init(m_colour,m_width,m_height,m_alpha);
			initShowTF(width,height);
		}
		
		private var m_showTF:TextField;
		private function initShowTF(width:Number,height:Number):void
		{
			m_showTF = new TextField();
			this.addChild(m_showTF);
			m_showTF.text = "是的是的顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶的"
			//m_showTF.set = TextInteractionMode.SELECTION;
				
			m_showTF.type = TextFieldType.INPUT;
			m_showTF.mouseEnabled = false;
			m_showTF.mouseWheelEnabled = false;

			m_showTF.width = width;
			m_showTF.height = height;
			m_showTF.multiline = true;
			m_showTF.wordWrap = true;
			m_showTF.autoSize = TextFieldAutoSize.LEFT;
			setTextFormat(ConstStr.TEST_FOUNT,ConstStr.TEST_SIZE,ConstStr.TEST_COLOR )
		}

		
		public function setTextFormat(font:String,size:Object,color:Object):void
		{
			var forMat:TextFormat = new TextFormat(font,size,color)
			m_showTF.setTextFormat(forMat)
		}

	}
}