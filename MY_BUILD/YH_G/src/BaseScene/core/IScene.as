package BaseScene.core
{
	public interface IScene
	{
		function EnterScene(data:* = null):void
		function LeaveScence():void
		function initScence():void
	}
}