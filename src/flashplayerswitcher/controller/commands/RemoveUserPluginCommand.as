package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.model.StateModel;
	import flashplayerswitcher.model.values.InternetPlugins;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import org.robotlegs.mvcs.Command;

	import mx.controls.Alert;

	/**
	 * @author Joeri van Oostveen
	 */
	public class RemoveUserPluginCommand extends Command
	{
		[Inject]
		public var pluginLocations:InternetPlugins;
		
		[Inject]
		public var state:StateModel;
		
		override public function execute():void
		{
			var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
			plugin.search(pluginLocations.user);
			if (plugin.exists)
				plugin.remove();
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
			
			state.alert = Alert.show(resource("SYSTEM_PLUGIN_ACTIVE_ALERT"), resource("PLUGIN_REMOVED"));
		}
	}
}
