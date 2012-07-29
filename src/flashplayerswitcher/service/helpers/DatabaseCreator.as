package flashplayerswitcher.service.helpers
{
	import flashplayerswitcher.model.ConfigModel;
	import flashplayerswitcher.service.events.DatabaseReadyEvent;

	import com.probertson.data.QueuedStatement;

	import org.robotlegs.mvcs.Actor;

	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;

    public class DatabaseCreator extends Actor
    {
		[Inject]
		public var config:ConfigModel;
		
		public function createDatabaseStructure():void
		{
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements.push(new QueuedStatement(CREATE_FLASHPLAYERS_SQL));
			statements.push(new QueuedStatement(CREATE_PLUGINSETS_SQL));

            config.sqlrunner.executeModify(statements, executeBatchCompleteHandler, executeBatchErrorHandler, null);
		}

		private function executeBatchCompleteHandler(results:Vector.<SQLResult>):void
		{
			dispatch(new DatabaseReadyEvent());
		}

		private function executeBatchErrorHandler(error:SQLError):void
		{
			dispatch(new SQLErrorEvent(SQLErrorEvent.ERROR, false, false, error));
		}

		// ------- SQL statements -------
		
		[Embed(source="flashplayerswitcher/sql/create/CreateTableFlashplayers.sql", mimeType="application/octet-stream")]
		private static const CreateFlashplayersStatementText:Class;
		public static const CREATE_FLASHPLAYERS_SQL:String = new CreateFlashplayersStatementText();
		
		[Embed(source="flashplayerswitcher/sql/create/CreateTablePluginsets.sql", mimeType="application/octet-stream")]
		private static const CreatePluginsetsText:Class;
		public static const CREATE_PLUGINSETS_SQL:String = new CreatePluginsetsText();
	}
}
