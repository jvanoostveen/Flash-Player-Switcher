package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
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
		
		override public function execute():void
		{
			var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
			plugin.search(pluginLocations.user);
			if (plugin.exists)
				plugin.remove();
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
			
			Alert.show("System plugin is now active.\nPlease restart your browser(s).", "Plugin removed");
		}
	}
}
