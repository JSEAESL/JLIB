package sdk
{
	import flash.net.SharedObject;
	public class UserData
	{
		private static var _inst:UserData=null;
		public static function inst():UserData
		{
			if(_inst==null)
			{
				_inst=new UserData();
			}
			return _inst;
		}
		private var mSharedObject:SharedObject=null;
		public function UserData()
		{
			if(_inst!=null) throw new Error("UserData is a singleton.");
			_inst=this;
			mSharedObject=SharedObject.getLocal("haizei");
		}
		public function getBoolean(name:String,defaultValue:Boolean=false):Boolean
		{
			if(mSharedObject.data[name]==undefined) return defaultValue;
			return mSharedObject.data[name];
		}
		public function setBoolean(name:String,value:Boolean):void
		{
			mSharedObject.data[name]=value;
			mSharedObject.flush();
		}
		public function getInt(name:String):int
		{
			if(mSharedObject.data[name]==undefined) return 0;
			return mSharedObject.data[name];
		}
		public function setInt(name:String,value:int):void
		{
			mSharedObject.data[name]=value;
			mSharedObject.flush();
		}
		public function getString(name:String,defaultValue:String=null):String
		{
			if(mSharedObject.data[name]==undefined) return defaultValue;
			return mSharedObject.data[name];
		}
		public function setString(name:String,value:String):void
		{
			mSharedObject.data[name]=value;
			mSharedObject.flush();
		}
		public function getObject(name:String,defaultValue:Object=null):Object
		{
			if(mSharedObject.data[name]==undefined) return defaultValue;
			return mSharedObject.data[name];
		}
		public function setObject(name:String,value:Object):void
		{
			mSharedObject.data[name]=value;
			mSharedObject.flush();
		}
	}
}