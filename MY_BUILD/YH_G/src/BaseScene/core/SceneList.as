package BaseScene.core
{

	public class SceneList 
	{
		
		private var List:Array;
		public function SceneList()
		{
			List = [];
		}
		
		public function push(scene:IScene):void
		{
			while(List.length>5)
			{
				List.shift();
			}
			List.push(scene);
		}
		
		public function getLastScene():AScene
		{
			return List.pop();
		}
		
		public function length():uint
		{
			return List.length;
		}
	}
}