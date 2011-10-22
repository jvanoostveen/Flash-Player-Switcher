package flashplayerswitcher.service
{
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.controller.events.PluginStoredEvent;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.service.helpers.ISQLRunnerDelegate;

	import com.probertson.data.QueuedStatement;

	import org.robotlegs.mvcs.Actor;

	import mx.collections.ArrayCollection;

	import flash.data.SQLResult;
	import flash.errors.SQLError;

	/**
	 * @author Joeri van Oostveen
	 */
	public class SQLFlashplayersService extends Actor implements IFlashplayersService
	{
        [Inject]
        public var sqlRunner:ISQLRunnerDelegate;

        [Inject]
		public var installedPlugins:PluginsModel;

		public function loadPlugins():void
		{
			sqlRunner.execute(LOAD_ALL_PLUGINS_SQL, null, onAllPluginsLoaded, FlashPlayerPlugin, fault);
		}
		
		private function onAllPluginsLoaded(result:SQLResult):void
		{
			for each (var plugin:FlashPlayerPlugin in result.data)
			{
				plugin.searchStorage();
			}
			
			// initial sort on version number, ascending
			result.data.sortOn(["major", "minor", "revision", "build"], Array.NUMERIC);
			installedPlugins.plugins = new ArrayCollection(result.data);
		}

		public function storePlugin(plugin:FlashPlayerPlugin):void
		{
            var params:Object = new Object();
            params["name"] = plugin.name;
			params["version"] = plugin.version;
			params["debugger"] = plugin.debugger;
			params["hash"] = plugin.hash;

            sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(INSERT_PLUGIN_SQL, params)]), onPluginStored, fault);
		}
		
		private function onPluginStored(results:Vector.<SQLResult>):void
		{
			dispatch(new LoadPluginsEvent());
			dispatch(new PluginStoredEvent());
		}

		public function deletePlugin(plugin:FlashPlayerPlugin):void
		{
			var params:Object = new Object();
			params["hash"] = plugin.hash;
			
			sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(DELETE_PLUGIN_SQL, params)]), onPluginDeleted, fault);
		}
		
		private function onPluginDeleted(results:Vector.<SQLResult>):void
		{
			dispatch(new LoadPluginsEvent());
		}
		
		private function fault(error:SQLError):void
		{
			trace(error.message);
			trace(error.details);
		}
		
		[Embed(source="flashplayerswitcher/sql/flashplayers/LoadAllFlashplayers.sql", mimeType="application/octet-stream")]
		private static var LoadAllFlashplayersStatementText:Class;
		public static const LOAD_ALL_PLUGINS_SQL:String = new LoadAllFlashplayersStatementText();
		
		[Embed(source="flashplayerswitcher/sql/flashplayers/InsertPlugin.sql", mimeType="application/octet-stream")]
		private static var InsertPluginStatementText:Class;
		public static const INSERT_PLUGIN_SQL:String = new InsertPluginStatementText();
		
		[Embed(source="flashplayerswitcher/sql/flashplayers/DeletePlugin.sql", mimeType="application/octet-stream")]
		private static var DeletePluginStatementText:Class;
		public static const DELETE_PLUGIN_SQL:String = new DeletePluginStatementText();
	}
}
