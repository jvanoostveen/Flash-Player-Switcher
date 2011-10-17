package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.InternetPlugins;

	import org.robotlegs.mvcs.Command;

	import mx.controls.Alert;

	/**
	 * @author Joeri van Oostveen
	 */
	public class RemoveUserPluginCommand extends Command
	{
		override public function execute():void
		{
			var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
			plugin.search(InternetPlugins.USER);
			if (plugin.exists)
				plugin.remove();
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
			
			Alert.show("System plugin is now active.\nPlease restart your browser(s).", "Plugin removed");
		}
	}
}
