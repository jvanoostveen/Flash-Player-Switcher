package flashplayerswitcher.service.helpers
{
	import flashplayerswitcher.service.events.DatabaseReadyEvent;

	import com.probertson.data.QueuedStatement;

	import org.robotlegs.mvcs.Actor;

	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;

    public class DatabaseCreator extends Actor
    {
        [Inject]
        public var sqlRunner:ISQLRunnerDelegate;

        public function createDatabaseStructure():void
        {
            var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
            statements[statements.length] = new QueuedStatement(CREATE_FLASHPLAYERS_SQL);

            sqlRunner.executeModify(statements, executeBatchCompleteHandler, executeBatchErrorHandler, null);
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
    }
}