package flashplayerswitcher.service
{
	import flashplayerswitcher.model.ConfigModel;

	import org.robotlegs.mvcs.Actor;

	import flash.filesystem.File;
	import flash.net.SharedObject;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ConfigService extends Actor implements IConfigService
	{
		private var _config:SharedObject;
		
		[Inject]
		public var model:ConfigModel;
		
		public function ConfigService()
		{
			_config = SharedObject.getLocal("config", "/");
		}
		
		public function getStorageDirectory():File
		{
			var dir:File = new File();
			
			if (_config.data.hasOwnProperty("storage"))
				dir.nativePath = _config.data["storage"];
			else
				dir.nativePath = File.applicationStorageDirectory.nativePath;
			
			return dir;
		}
		
		public function saveStorageDirectory(directory:File):void
		{
			trace("save storage directory: " + directory.nativePath);
			_config.data["storage"] = directory.nativePath;
			_config.flush();
			
			model.storageDirectory = directory;
		}

		public function readConfig():void
		{
			model.storageDirectory = getStorageDirectory();
		}
	}
}
