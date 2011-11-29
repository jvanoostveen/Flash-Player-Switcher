package flashplayerswitcher.model.vo
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashPlayerPlugin
	{
		private static const FLASH_PLAYER_PLUGIN:String = "Flash Player.plugin";
		private static const FLASH_PLAYER_XPT:String = "flashplayer.xpt";
		
		public var id:int;
		public var name:String;
		protected var _version:String;
		public var debugger:Boolean = false;
		public var hash:String;
		public var url:String;

		public var plugin:File; // essential file
		public var xpt:File; // optional, used for browser script access
		
		// detailed version info (for sorting etc).
		public var major:uint;
		public var minor:uint;
		public var revision:uint;
		public var build:uint;
		
		public function FlashPlayerPlugin()
		{
			
		}
		
		public function search(directory:File, parsePlugin:Boolean = true):void
		{
			plugin = directory.resolvePath(FLASH_PLAYER_PLUGIN);
			xpt = directory.resolvePath(FLASH_PLAYER_XPT);
			
			if (plugin.exists && parsePlugin)
				parse();
		}
		
		public function remove():void
		{
			if (plugin.exists)
				plugin.deleteDirectory(true);
			
			if (xpt.exists)
				xpt.deleteFile();
		}
		
		public function get exists():Boolean
		{
			return plugin ? plugin.exists : false;
		}
		
		private function parse():void
		{
			var infoPlist:File = plugin.resolvePath("Contents/Info.plist");
			
			if (!infoPlist.exists)
			{
				throw new Error("No Info.plist found inside Bundle.");
			}
			
			var fs:FileStream = new FileStream();
			fs.open(infoPlist, FileMode.READ);
			var data:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
			fs.close();
			
			for each (var key:XML in data.dict.key)
			{
				switch (key.toString())
				{
					case PListKeys.BUNDLE_NAME:
						name = key.parent().*[key.childIndex() + 1][0];
						
						if (name.toLowerCase().indexOf("debugger") > -1)
							debugger = true;
						
						break;
					case PListKeys.BUNDLE_VERSION:
						version = key.parent().*[key.childIndex() + 1][0];
						break;
				}
			}
			
			hash = version + "_" + (debugger ? "debugger" : "release");
		}

		public function get version():String
		{
			return _version;
		}

		public function set version(value:String):void
		{
			_version = value;
			
			var v:Array = _version.split(".");
			major = parseInt(v[0]);
			minor = parseInt(v[1]);
			revision = parseInt(v[2]);
			build = parseInt(v[3]);
		}
	}
}
