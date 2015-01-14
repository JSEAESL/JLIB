package BaseUI.old
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class JButtonDeco extends Sprite
	{
		private var _skin:Sprite;			
		private var _button:JAButton;
		private var txt:TextField;
		//var Jb:JButtonDeco = new JButtonDeco("JSEA",new JAButton(JFile.creat.browOpen),null,    onOpenMapFile, JFile.FILE_IMAGE);
		//var Jb:JButtonDeco = new JButtonDeco("JSEA",new JAButton(JFile.creat.browOpen),null);
		//this.addChild(Jb);		
		public function JButtonDeco(lable:String,button:JAButton,skin:Sprite = null)
		{
			_button = button;
			
			txt  = creatLabelSkin(lable);
			this.addChild(_button);
			
			_skin = skin;
			if(_skin == null)
			{
				_skin = creatButtonSkin();
			}
			_button.addChild(_skin);
		
			addChild(txt);
		}
		
		public function get Skin():Sprite
		{
			return _skin
		}
		private var wighth:int;
		private function creatLabelSkin(label:String):TextField
		{
			var labText:TextField = new TextField();
			labText.mouseEnabled = false;
			labText.autoSize = TextFieldAutoSize.LEFT;
			labText.text = label;
			labText.setTextFormat(new TextFormat("Arial",15,null,true));
			wighth = labText.width;
			return labText;
		}
		private function creatButtonSkin():Sprite
		{
			return Draw.creatRoundRect(0,0,wighth,20,10,10,0xAAAAAAAA,1);
		}
	}
}