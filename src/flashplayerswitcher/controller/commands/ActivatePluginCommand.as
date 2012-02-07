package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.service.growl.NotificationName;
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.locale.Locale;
	import flashplayerswitcher.model.StateModel;
	import flashplayerswitcher.model.values.InternetPlugins;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.service.ITrackerService;
	import flashplayerswitcher.service.growl.IGrowlService;

	import org.robotlegs.mvcs.Command;

	import mx.controls.Alert;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ActivatePluginCommand extends Command
	{
		[Inject] public var event:ActivatePluginEvent;
		
		[Inject] public var tracker:ITrackerService;
		[Inject] public var pluginLocations:InternetPlugins;
		[Inject] public var state:StateModel;
		[Inject] public var growl:IGrowlService;
		
		override public function execute():void
		{
			var plugins:File = pluginLocations.user;
			if (!plugins.exists)
				plugins.createDirectory();
			
			var plugin:FlashPlayerPlugin = event.plugin;
			plugin.plugin.copyTo(plugins.resolvePath(plugin.plugin.name), true);
			plugin.xpt.copyTo(plugins.resolvePath(plugin.xpt.name), true);
			
			tracker.track("/activate/" + plugin.version + "/" + (plugin.debugger ? "debugger" : "release") + "/");
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.SYSTEM));
			
			state.alert = Alert.show(resource('PLUGIN_ACTIVATED_FEEDBACK', Locale.MAIN, [plugin.name + " " + plugin.version]), resource('PLUGIN_ACTIVATED'));
			
			growl.notify(NotificationName.PLUGIN_ACTIVATED, resource("PLUGIN_ACTIVATED_NOTIFICATION_TITLE", Locale.GROWL), resource("PLUGIN_ACTIVATED_NOTITICATION_MESSAGE", Locale.GROWL, [plugin.name + " " + plugin.version]));
		}
	}
}
