package sdk.net
{
	import flash.net.URLVariables;

	public class GameHttpMgr
	{
		private var depends:IGameHttpDepends;
		public function GameHttpMgr(depends:IGameHttpDepends)
		{
			this.depends=depends;
		}
		/**
		 * 
		 * @param mod 模块名
		 * @param act 方法名
		 * @param args 参数
		 * @param callback 回调函数function(msg:Object,response:Object):void
		 * 
		 */		
		public function post(args:Object,callback:Function=null):void
		{
			var uidSn:int=depends.getUidSn();
			var auth_key:String=depends.getAuthKey();
			var parameter:String=JSON.stringify([args]);
			var auth_time:int=depends.getAuthTime();
			//$randkey = encryptMD5($requests['parameter'],strval($requests['auth_time']).$gAuthKeyAuth)
			var randkey:String=depends.sign(parameter+auth_time+auth_key);
			var uid:String=depends.getUid();
			var version:String=depends.getVersion();
			
			var vars:URLVariables=new URLVariables();
			vars.uid_sn=uidSn;
			vars.auth_key=auth_key;
			vars.parameter=parameter;
			vars.auth_time=auth_time;
			vars.randkey=randkey;
			vars.uid=uid;
			vars.ver=version;
			vars.pf="lm";
			vars.from=1001;
			
			new GameHttp(depends.getGateUrl(),vars,callback).post();
		}
	}
}