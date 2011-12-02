package flashplayerswitcher.model
{
	import flashplayerswitcher.controller.events.StorageAllowEditingChangedEvent;
	import flashplayerswitcher.controller.events.StorageDirectoryChangedEvent;

	import com.probertson.data.SQLRunner;

	import org.robotlegs.mvcs.Actor;

	import flash.filesystem.File;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class ConfigModel extends Actor
	{
		private var _sqlrunner:SQLRunner;
		
		private var _storageDirectory:File;
		private var _storageAllowEditing:Boolean = true;

		public function get storageDirectory():File
		{
			return _storageDirectory;
		}

		public function set storageDirectory(directory:File):void
		{
			var oldStorageDirectory:File = _storageDirectory;
			
			_storageDirectory = directory;
			
			if (oldStorageDirectory)
				dispatch(new StorageDirectoryChangedEvent(oldStorageDirectory, _storageDirectory));
		}

		public function get sqlrunner():SQLRunner
		{
			return _sqlrunner;
		}
		
		public function set sqlrunner(sqlrunner:SQLRunner):void
		{
			_sqlrunner = sqlrunner;
		}
		
		public function get storageAllowEditing():Boolean
		{
			return _storageAllowEditing;
		}

		public function set storageAllowEditing(value:Boolean):void
		{
			_storageAllowEditing = value;
			
			dispatch(new StorageAllowEditingChangedEvent(_storageAllowEditing));
		}
	}
}
