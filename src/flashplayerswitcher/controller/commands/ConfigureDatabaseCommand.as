package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.ConfigModel;
	import flashplayerswitcher.model.values.DatabaseFilename;
	import flashplayerswitcher.service.events.DatabaseReadyEvent;
	import flashplayerswitcher.service.helpers.DatabaseCreator;

	import com.probertson.data.SQLRunner;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	public class ConfigureDatabaseCommand extends Command
	{
		[Inject]
		public var config:ConfigModel;
		
		[Inject]
		public var database:DatabaseFilename;
		
		override public function execute():void
		{
			var file:File = config.storageDirectory.resolvePath(database.name);
			
			// previously used an injector.mapValue here, but the database could be closed and
			// when creating a new sqlrunner, the injections already taken place would fail to 
			// load any data.
			config.sqlrunner = new SQLRunner(file);
			
			if (!file.exists)
			{
				// We use the injector to instantiate the DatabaseCreator here because
				// we want to inject the SQLRunner that is mapped above. This works
				// well even though the DatabaseCreator is not a mapped object, we still
				// get access to injections from Robotlegs by creating it this way!
				var creator:DatabaseCreator = injector.instantiate(DatabaseCreator);
				creator.createDatabaseStructure();
			} else {
				dispatch(new DatabaseReadyEvent());
			}
		}
	}
}
