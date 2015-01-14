package BaseScene.tScene.startMc
{
	import flash.display.Shape;
	import flash.display.Sprite;

	public class StartMc extends Sprite
	{
		private var proList:Array;
		private var colourList:Array;
		private var MAX_LAN:Number = 300
		private var half_lan:Number = Math.sqrt(1)/2;
		private var half3_lan:Number = Math.sqrt(3)/2;

		private var line_Big:Number = 1;
		public function StartMc()
		{
			initClass();
			draw();
		}
		private function initClass():void
		{
			proList = [MAX_LAN*0.3,MAX_LAN*0.4,MAX_LAN*0.5,MAX_LAN*0.6,MAX_LAN*0.7,MAX_LAN*0.2];
			colourList = [0xff0000,0xff0000,0xff0000,0xff0000,0xff0000,0xff0000,]
			LineList = [];
			sideLineList = [];
			coreLineList = [];
			coreSideList = [];
			coreMcSideList = [];
		}

		private  function creatLine():Shape
		{
			var shap:Shape = new Shape();
			//shap.graphics.beginFill(0x666666,1);
			shap.graphics.lineStyle(0,0x666666);
			shap.graphics.lineTo(MAX_LAN,0);
			return shap;
		}
		
		private function creatSide():Shape
		{
			var sideLine:Shape = new Shape();
			sideLine.graphics.lineStyle(10,0x666666);
			sideLine.graphics.moveTo(MAX_LAN,0);
			sideLine.graphics.lineTo(half_lan*MAX_LAN,half3_lan*MAX_LAN);
			return sideLine;
		}
		
		private function creatCoreLine(index:Number):Shape
		{
			var shap:Shape = new Shape();
			shap.graphics.lineStyle(3,colourList[index]);
			shap.graphics.lineTo(proList[index],0);
			return shap;
		}
		
		private function creatCoreSide(index:Number):Shape
		{
			var startIndex:Number = index;
			var endIndex:Number = (index + 1)==proList.length ? 0:index + 1 ;
			
			var sideLine:Shape = new Shape();
			sideLine.graphics.lineStyle(3,0x666666);
			sideLine.graphics.moveTo(proList[startIndex] ,0);
			sideLine.graphics.lineTo(half_lan*proList[endIndex],half3_lan*proList[endIndex]);
			return sideLine;
		}
		
		private function creatCoreMC(index:Number):Shape
		{
			var startIndex:Number = index;
			var endIndex:Number = (index + 1)==proList.length ? 0:index + 1 ;
			var sideLine:Shape = new Shape();
			sideLine.graphics.beginFill(0x666666,0.8);
			sideLine.graphics.lineTo(proList[startIndex] ,0);
			sideLine.graphics.lineTo(half_lan*proList[endIndex],half3_lan*proList[endIndex]);
			sideLine.graphics.endFill();
			return sideLine;
		}

		private var LineList:Array;
		private var sideLineList:Array;
		private var coreLineList:Array;
		private var coreSideList:Array;
		private var coreMcSideList:Array;
		private function draw():void
		{
			
			var coreShap:Shape = new Shape();
			for(var i:Number = 0;i<6; i++)
			{
				var line:Shape = creatLine();
				line.rotation = 60*i;
				LineList.push(line);
				addChild(line);
				
				var sideLine:Shape = creatSide();
				sideLine.rotation = 60*i;
				sideLineList.push(sideLine)
				addChild(sideLine);
				
				var coreLine:Shape = creatCoreLine(i);
				coreLine.rotation = 60*i;
				coreLineList.push(coreLine);
				addChild(coreLine);

			}
			
			for(i = 0;i<6;i++)
			{
				
				var coreSide:Shape = creatCoreSide(i);
				coreSide.rotation = 60*i;
				coreSideList.push(coreSide);
				addChild(coreSide);
				
				var coreMcSide:Shape = creatCoreMC(i);
				coreMcSide.rotation = 60*i;	
				coreMcSideList.push(coreMcSide);

				addChild(coreMcSide);
			}
		}
		
		public function update():void
		{
			for(var i:Number = 0;i<6;i++)
			{
				LineList[i].graphics.clear()
				sideLineList[i].graphics.clear()
				coreLineList[i].graphics.clear()
				coreSideList[i].graphics.clear()
				coreMcSideList[i].graphics.clear()
			}
			LineList.splice(0);
			sideLineList.splice(0);
			coreLineList.splice(0);
			coreSideList.splice(0);
			coreMcSideList.splice(0);

			proList = [MAX_LAN*Math.random(),MAX_LAN*Math.random(),MAX_LAN*Math.random(),MAX_LAN*Math.random(),MAX_LAN*Math.random(),MAX_LAN*Math.random()];
			draw()
		}
		
	}
}