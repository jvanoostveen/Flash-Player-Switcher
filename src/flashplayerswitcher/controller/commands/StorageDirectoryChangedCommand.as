package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.ConfigReadyEvent;
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.controller.events.StorageDirectoryChangedEvent;
	import flashplayerswitcher.model.ConfigModel;
	import flashplayerswitcher.model.values.DatabaseFilename;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StorageDirectoryChangedCommand extends Command
	{
		[Inject]
		public var event:StorageDirectoryChangedEvent;
		
		[Inject]
		public var database:DatabaseFilename;
		
		[Inject]
		public var config:ConfigModel;
		
		override public function execute():void
		{
			var oldLocation:File = event.oldLocation;
			var newLocation:File = event.newLocation;
			
			// check if database is present
			var db:File = newLocation.resolvePath(database.name);
			if (!db.exists)
			{
				// if not: copy database and plugins
				oldLocation.resolvePath(database.name).copyTo(db, true);
				if (db.exists)
					oldLocation.resolvePath(database.name).deleteFileAsync();
				
				var plugins:File = newLocation.resolvePath("plugins");
				if (!plugins.exists)
				{
					oldLocation.resolvePath("plugins").copyTo(plugins, true);
					if (plugins.exists)
						oldLocation.resolvePath("plugins").deleteDirectoryAsync(true);
				}
			}
			
			// close current database connection
			// open new database connection at new location
			commandMap.detain(this);
			config.sqlrunner.close(onDatabaseClosed);
		}
		
		private function onDatabaseClosed():void
		{
			dispatch(new ConfigReadyEvent());
			dispatch(new LoadPluginsEvent());
			
			commandMap.release(this);
		}
	}
}
