package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.InstallPluginEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.InternetPlugins;

	import org.robotlegs.mvcs.Command;

	import mx.controls.Alert;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InstallPluginCommand extends Command
	{
		[Inject]
		public var event:InstallPluginEvent;
		
		override public function execute():void
		{
			var plugins:File = InternetPlugins.USER;
			if (!plugins.exists)
				plugins.createDirectory();
			
			var plugin:FlashPlayerPlugin = event.plugin;
			plugin.plugin.copyTo(plugins.resolvePath(plugin.plugin.name), true);
			plugin.xpt.copyTo(plugins.resolvePath(plugin.xpt.name), true);
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
			
			Alert.show(plugin.name + " " + plugin.version + " is now installed. Please restart your browser(s).", "Plugin installed");
		}
	}
}
