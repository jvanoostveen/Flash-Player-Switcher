package flashplayerswitcher.service
{
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.model.ConfigModel;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.PluginSet;
	import com.probertson.data.QueuedStatement;
	import org.robotlegs.mvcs.Actor;
	import mx.collections.ArrayCollection;
	import flash.data.SQLResult;
	import flash.errors.SQLError;

	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashplayersService extends Actor implements IFlashplayersService
	{
        [Inject]
		public var installedPlugins:PluginsModel;

		[Inject]
		public var config:ConfigModel;
		
		public function loadPlugins():void
		{
			installedPlugins.plugins = new ArrayCollection([]);
			
			config.sqlrunner.execute(LOAD_ALL_PLUGINS_SQL, null, onAllPluginsLoaded, FlashPlayerPlugin, fault);
		}
		
		private function onAllPluginsLoaded(result:SQLResult):void
		{
			for each (var plugin:FlashPlayerPlugin in result.data)
			{
				plugin.search(config.storageDirectory.resolvePath("plugins").resolvePath(plugin.hash), false);
			}
			
			// initial sort on version number, ascending
			result.data.sortOn(["major", "minor", "revision", "build"], Array.NUMERIC);
			installedPlugins.plugins = new ArrayCollection(result.data);
			
			loadPluginSets();
		}

		public function storePlugin(plugin:FlashPlayerPlugin):void
		{
            var params:Object = new Object();
            params["name"] = plugin.name;
			params["version"] = plugin.version;
			params["debugger"] = plugin.debugger;
			params["hash"] = plugin.hash;

            config.sqlrunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(INSERT_PLUGIN_SQL, params)]), onPluginStored, fault);
		}
		
		private function onPluginStored(results:Vector.<SQLResult>):void
		{
			dispatch(new LoadPluginsEvent());
//			dispatch(new PluginStoredEvent());
		}

		public function deletePlugin(plugin:FlashPlayerPlugin):void
		{
			var params:Object = new Object();
			params["hash"] = plugin.hash;
			
			config.sqlrunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(DELETE_PLUGIN_SQL, params)]), onPluginDeleted, fault);
		}
		
		private function onPluginDeleted(results:Vector.<SQLResult>):void
		{
			dispatch(new LoadPluginsEvent());
		}
		
		public function loadPluginSets():void
		{
			config.sqlrunner.execute(LOAD_ALL_PLUGINSETS_SQL, null, onAllPluginSetsLoaded, PluginSet, fault);
		}
		
		private function onAllPluginSetsLoaded(result:SQLResult):void
		{
			for each (var pluginSet:PluginSet in result.data)
			{
				for each (var sortedPluginSet:PluginSet in installedPlugins.sortedPlugins)
				{
					if (sortedPluginSet.version == pluginSet.version)
						sortedPluginSet.name = pluginSet.name;
				}
			}
			
			installedPlugins.dispatchUpdate();
		}
		
		public function deletePluginSet(pluginSet:PluginSet):void
		{
			var params:Object = new Object();
			params["version"] = pluginSet.version;
			
			config.sqlrunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(DELETE_PLUGINSET_SQL, params)]), onPluginSetDeleted, fault);
		}
		
		public function deletePluginSetForVersion(version:String):void
		{
			var params:Object = new Object();
			params["version"] = version;
			
			config.sqlrunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(DELETE_PLUGINSET_SQL, params)]), onPluginSetDeleted, fault);
		}
		
		private function onPluginSetDeleted(results:Vector.<SQLResult>):void
		{
			dispatch(new LoadPluginsEvent());
		}
		
		public function storePluginSet(pluginSet:PluginSet):void
		{
			var params:Object = new Object();
			params["version"] = pluginSet.version;
			params["name"] = pluginSet.name;
			
			config.sqlrunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(INSERT_OR_REPLACE_PLUGINSET_SQL, params)]), onPluginSetStored, fault);
		}
		
		private function onPluginSetStored(results:Vector.<SQLResult>):void
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
		
		[Embed(source="flashplayerswitcher/sql/pluginsets/LoadAllPluginSets.sql", mimeType="application/octet-stream")]
		private static var LoadAllPluginSetsStatementText:Class;
		public static const LOAD_ALL_PLUGINSETS_SQL:String = new LoadAllPluginSetsStatementText();
		
		[Embed(source="flashplayerswitcher/sql/pluginsets/InsertOrReplacePluginSet.sql", mimeType="application/octet-stream")]
		private static var InsertOrReplacePluginSetStatementText:Class;
		public static const INSERT_OR_REPLACE_PLUGINSET_SQL:String = new InsertOrReplacePluginSetStatementText();
		
		[Embed(source="flashplayerswitcher/sql/pluginsets/DeletePluginSet.sql", mimeType="application/octet-stream")]
		private static var DeletePluginSetStatementText:Class;
		public static const DELETE_PLUGINSET_SQL:String = new DeletePluginSetStatementText();
	}
}
