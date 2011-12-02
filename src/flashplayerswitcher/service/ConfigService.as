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
		
		public function saveStorageDirectory(directory:File):void
		{
			_config.data["storage"] = directory.nativePath;
			_config.flush();
			
			model.storageDirectory = directory;
		}
		
		public function saveAllowEditing(value:Boolean):void
		{
			_config.data["allowEditing"] = value;
			_config.flush();
			
			model.storageAllowEditing = value;
		}

		public function readConfig():void
		{
			model.storageDirectory = getStorageDirectory();
			model.storageAllowEditing = getAllowEditing();
		}
		
		private function getStorageDirectory():File
		{
			var dir:File = new File();
			
			if (_config.data.hasOwnProperty("storage"))
				dir.nativePath = _config.data["storage"];
			else
				dir.nativePath = File.applicationStorageDirectory.nativePath;
			
			return dir;
		}
		
		private function getAllowEditing():Boolean
		{
			var allow:Boolean = true;
			
			if (_config.data.hasOwnProperty("allowEditing"))
				allow = _config.data["allowEditing"];
			
			return allow;
		}
	}
}
