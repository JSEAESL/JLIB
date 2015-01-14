package BaseScene.tScene
{
	public interface IView extends IDestroy
	{
		function toShow():void
		function toHide():void
		function toSleep():void
	}
}