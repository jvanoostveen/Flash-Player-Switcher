package flashplayerswitcher.model
{
	import flashplayerswitcher.controller.events.InstalledPluginUpdatedEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import org.robotlegs.mvcs.Actor;

	import mx.collections.ArrayCollection;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginsModel extends Actor
	{
		private var _system:FlashPlayerPlugin;
		private var _user:FlashPlayerPlugin;
		
		private var _plugins:ArrayCollection;
		
		public function set plugins(value:ArrayCollection):void
		{
			_plugins = value;
			dispatch(new PluginsUpdatedEvent(PluginsUpdatedEvent.UPDATED, _plugins));
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
		
		public function get plugins():ArrayCollection
		{
			return _plugins ||= new ArrayCollection();
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
	}
}
