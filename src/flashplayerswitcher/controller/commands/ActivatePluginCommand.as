package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.InternetPlugins;
	import flashplayerswitcher.service.ITrackerService;

	import org.robotlegs.mvcs.Command;

	import mx.controls.Alert;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ActivatePluginCommand extends Command
	{
		[Inject]
		public var event:ActivatePluginEvent;
		
		[Inject]
		public var tracker:ITrackerService;
		
		override public function execute():void
		{
			var plugins:File = InternetPlugins.USER;
			if (!plugins.exists)
				plugins.createDirectory();
			
			var plugin:FlashPlayerPlugin = event.plugin;
			plugin.plugin.copyTo(plugins.resolvePath(plugin.plugin.name), true);
			plugin.xpt.copyTo(plugins.resolvePath(plugin.xpt.name), true);
			
			tracker.track("/activate/" + plugin.version + "/" + (plugin.debugger ? "debugger" : "release") + "/");
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
			
			Alert.show(plugin.name + " " + plugin.version + " is now activated. Please restart any open browsers.", "Plugin activated");
		}
	}
}
