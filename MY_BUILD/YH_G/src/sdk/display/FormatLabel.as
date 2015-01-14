package sdk.display
{
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.text.TextFieldTextRenderer;
	
	public class FormatLabel extends TextFieldTextRenderer
	{
		public function FormatLabel(size:int=20,color:uint=0xFFFFFF,align:String=TextFormatAlign.LEFT,bold:Boolean=false,italic:Boolean=false,
			underline:Boolean=false)
		{
			super();
			var tf:TextFormat=new TextFormat("Microsoft YaHei",size,color,bold,italic,underline,null,null,align);
			this.textFormat=tf;
			
			/*this._textField = new TextField();
			this._textField.mouseEnabled = this._textField.mouseWheelEnabled = false;
			this._textField.selectable = false;
			this._textField.multiline = true;
			this._textField.antiAliasType = AntiAliasType.ADVANCED;
			this._textField.filters=[new GlowFilter(0xFF0000)];*/
		}
		public function glow(color:uint=16711680,alpha:Number=1.0,blurX:Number=6.0,blurY:Number=6.0,strength:Number=2.0,quality:int=1,inner:Boolean=false,knockout:Boolean=false):FormatLabel
		{
			if(this.textField==null)
			{
				this.textField = new TextField();
				this.textField.mouseEnabled = this.textField.mouseWheelEnabled = false;
				this.textField.selectable = false;
				this.textField.multiline = true;
				this.textField.antiAliasType = AntiAliasType.ADVANCED;
			}
			this.textField.filters=[new GlowFilter(color,alpha,blurX,blurY,strength,quality,inner,knockout)];
			return this;
		}
	}
}