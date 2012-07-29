package flashplayerswitcher.model
{
	import flashplayerswitcher.controller.events.InstalledPluginUpdatedEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.PluginSet;

	import org.robotlegs.mvcs.Actor;

	import mx.collections.ArrayCollection;

	import flash.utils.Dictionary;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginsModel extends Actor
	{
		private var _system:FlashPlayerPlugin;
		private var _user:FlashPlayerPlugin;
		
		private var _plugins:ArrayCollection;
		private var _sortedPlugins:ArrayCollection;
		
		public function set plugins(value:ArrayCollection):void
		{
			_plugins = value;
			
			var sortedPlugins:Array = new Array();
			var tmp:Dictionary = new Dictionary(true);
			for each (var plugin:FlashPlayerPlugin in _plugins)
			{
				var pluginSet:PluginSet = tmp[plugin.version];
				if (!pluginSet)
				{
					pluginSet = new PluginSet();
					tmp[plugin.version] = pluginSet;
					sortedPlugins.push(pluginSet);
				}
				
				pluginSet.addPlugin(plugin);
			}
			
			_sortedPlugins = new ArrayCollection(sortedPlugins);
			
//			dispatch(new PluginsUpdatedEvent(PluginsUpdatedEvent.UPDATED, plugins));
		}
		
		public function get plugins():ArrayCollection
		{
			return _plugins ||= new ArrayCollection();
		}
		
		public function get sortedPlugins():ArrayCollection
		{
			return _sortedPlugins ||= new ArrayCollection();
		}
		
		public function get system():FlashPlayerPlugin
		{
			return _system;
		}

		public function set system(plugin:FlashPlayerPlugin):void
		{
			_system = plugin;
			
			dispatch(new InstalledPluginUpdatedEvent(InstalledPluginUpdatedEvent.SYSTEM, _system));
		}
		
		public function get user():FlashPlayerPlugin
		{
			return _user;
		}

		public function set user(plugin:FlashPlayerPlugin):void
		{
			_user = plugin;
			
			dispatch(new InstalledPluginUpdatedEvent(InstalledPluginUpdatedEvent.USER, _user));
		}
		
		public function dispatchUpdate():void
		{
			dispatch(new PluginsUpdatedEvent(PluginsUpdatedEvent.UPDATED, plugins));
		}
		
		public function contains(plugin:FlashPlayerPlugin):Boolean
		{
			for each (var p:FlashPlayerPlugin in _plugins)
			{
				if (plugin.hash == p.hash)
					return true;
			}
			
			return false;
		}
	}
}
