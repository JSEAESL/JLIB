package sdk.net
{
	/**
	 * 游戏Http依赖内容 
	 * @author Terry
	 * 
	 */	
	public interface IGameHttpDepends
	{
		/**
		 * 游戏的版本，字符串类型
		 * @return 
		 * 
		 */		
		function getVersion():String;
		/**
		 * 对一个内容签名
		 * @param content
		 * @return 
		 * 
		 */		
		function sign(content:String):String;
		/**
		 * 取从服务器获得的令牌
		 * @return 
		 * 
		 */		
		function getAuthKey():String;
		/**
		 * 取用户的ID 
		 * @return 
		 * 
		 */		
		function getUid():String;
		/**
		 * 取得网关地址
		 * @return 
		 * 
		 */		
		function getGateUrl():String;
		function getUidSn():int;
		function getAuthTime():int;
	}
}