package sdk.net
{
	public class GameNet
	{
		private static var _inst:GameNet=null;
		public static function inst():GameNet
		{
			if(_inst==null)
			{
				new GameNet();
			}
			return _inst;
		}
		
		private var mgr:GameHttpMgr;
		public function GameNet()
		{
			if(_inst!=null) throw new Error("GameNet is a singleton.");
			_inst=this;
		}
		public function init(depends:IGameHttpDepends):void
		{
			mgr=new GameHttpMgr(depends);
		}
		public function post(mod:String,act:String,args:Object=null,callback:Function=null):void
		{
			if(args==null) args=new Object;
			args.mod=mod;
			args.act=act;
			mgr.post(args,callback);
		}
	}
}