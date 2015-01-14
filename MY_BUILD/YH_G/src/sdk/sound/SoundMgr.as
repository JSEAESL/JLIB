package sdk.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import sdk.Asset;
	import sdk.LasyLoader;

	public class SoundMgr
	{
		private static var _inst:SoundMgr=null;
		public static function inst():SoundMgr
		{
			if(_inst==null)
			{
				new SoundMgr();
			}
			return _inst;
		}
		public function SoundMgr()
		{
			if(_inst!=null)
			{
				throw new Error("SoundMgr is a singleton.");
			}
			_inst=this;
		}
		private var sounds:Dictionary=new Dictionary();
		private var bgmChannel:SoundChannel=null;
		private var bgmUrl:String=null;
		
		private var _enable:Boolean=true;
		private var soundLoaded:Boolean=false;
		private var unplayedBgm:String=null;
		
		private function getSound(url:String):Sound
		{
			if(sounds[url]==null)
			{
				var snd:Sound=new Sound();
				var bytes:ByteArray=Asset.getByteArray(url);
				snd.loadCompressedDataFromByteArray(bytes,bytes.length);
				sounds[url]=snd;
			}
			return sounds[url];
		}
		public function playBgm(url:String):void
		{
			if(soundLoaded)
			{
				//如果声音加载完了
				if(bgmUrl==url) return;
				bgmUrl=url;
				if(bgmChannel!=null)
				{
					bgmChannel.stop();
					bgmChannel=null;
				}
				if(_enable)
				{
					var sound:Sound=getSound(url);
					bgmChannel=sound.play(0,9999);
				}
			}
			else
			{
				//如果声音没有加载完
				unplayedBgm=url;
			}
		}
		public function stopBgm():void
		{
			//关闭声音
			if(bgmChannel!=null)
			{
				bgmChannel.stop();
				bgmChannel=null;
			}
		}
		public function playEffect(url:String):void
		{
			if(!soundLoaded) return;
			if(_enable)
			{
				var sound:Sound=getSound(url);
				sound.play();
			}
		}
		public function get enable():Boolean
		{
			return _enable;
		}
		public function set enable(value:Boolean):void
		{
			if(value==_enable) return;
			_enable=value;
			if(value)
			{
				//打开声音
				if(bgmUrl==null)
				{
					//如果原来没有背景音乐
					return;
				}
				else
				{
					//如果原来有背景音乐
					bgmChannel=getSound(bgmUrl).play(0,9999);
				}
			}
			else
			{
				//关闭声音
				if(bgmChannel!=null)
				{
					bgmChannel.stop();
					bgmChannel=null;
				}
			}
		}
	
		private var loader:LasyLoader;
		public function startLoad(url:String):void
		{
			loader=new LasyLoader(url,onLoadSoundComplete);
			loader.start();
		}
		private function onLoadSoundComplete():void
		{
			soundLoaded=true;
			if(unplayedBgm!=null) playBgm(unplayedBgm);
		}
	}
}