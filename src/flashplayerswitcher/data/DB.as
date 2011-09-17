package flashplayerswitcher.data
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flashplayerswitcher.model.vo.FlashPlayerBundle;
	import mx.collections.ArrayCollection;


	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class DB extends EventDispatcher
	{
		private var _db:SQLConnection;
		private var _query:SQLStatement;
		
		[Bindable]
		public var data:ArrayCollection = new ArrayCollection();
		
		public function DB()
		{
			super();
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("flashplayers.db");
			
			_query = new SQLStatement();
			_query.itemClass = FlashPlayerBundle;
			_query.addEventListener(SQLErrorEvent.ERROR, handleDatabaseCreatedError);
			
			_db = new SQLConnection();
			_db.addEventListener(SQLEvent.OPEN, handleDatabaseOpen);
			_db.addEventListener(SQLErrorEvent.ERROR, handleDatabaseError);
			
			_query.sqlConnection = _db;
			
			_db.open(dbFile);
			
		}

		private function handleDatabaseOpen(event:SQLEvent):void
		{
			_query.text = "CREATE TABLE IF NOT EXISTS flashplayers ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, version TEXT, beta BOOLEAN, debugger BOOLEAN, installed BOOLEAN )";
			_query.addEventListener(SQLEvent.RESULT, handleDatabaseCreated);
			_query.execute();
		}

		private function handleDatabaseCreated(event:SQLEvent):void
		{
			_query.removeEventListener(SQLEvent.RESULT, handleDatabaseCreated);
			
//			fill();
			
			fetchRows();
		}

		private function fill():void
		{
			_query.text = 'INSERT INTO flashplayers (name, version, beta, debugger, installed) VALUES ("Flash Player Debugger", "10.3.181.34", false, true, true)';
			_query.execute();
		}

		private function fetchRows():void
		{
			_query.text = "SELECT * FROM flashplayers";
			_query.addEventListener(SQLEvent.RESULT, handleFetchRows);
			_query.execute();
		}

		private function handleFetchRows(event:SQLEvent):void
		{
			_query.removeEventListener(SQLEvent.RESULT, handleFetchRows);
			
			var result:SQLResult = _query.getResult();
			if (result)
			{
				data.source = result.data;
			}
		}

		private function handleDatabaseCreatedError(event:SQLErrorEvent):void
		{
			trace("Error: " + event.text);
		}

		private function handleDatabaseError(event:SQLErrorEvent):void
		{
		}
	}
}
