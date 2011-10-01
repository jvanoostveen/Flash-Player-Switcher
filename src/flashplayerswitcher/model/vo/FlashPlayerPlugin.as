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
		public var version:String;
		public var debugger:Boolean = false;
		public var hash:String;

		public var plugin:File; // essential file
		public var xpt:File; // optional, used for browser script access

		public function FlashPlayerPlugin()
		{
			
		}
		
		public function search(directory:File):void
		{
			plugin = directory.resolvePath(FLASH_PLAYER_PLUGIN);
			xpt = directory.resolvePath(FLASH_PLAYER_XPT);
			
			if (plugin.exists)
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
	}
}
