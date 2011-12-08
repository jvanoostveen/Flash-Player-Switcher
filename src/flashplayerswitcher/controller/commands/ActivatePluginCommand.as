package flashplayerswitcher.controller.commands
{
	import mx.managers.SystemManager;
	import mx.managers.PopUpManagerChildList;
	import mx.managers.PopUpManager;
	import spark.components.Application;
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.locale.Locale;
	import flashplayerswitcher.model.values.InternetPlugins;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
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
		
		[Inject]
		public var pluginLocations:InternetPlugins;
		
		[Inject]
		public var sys:SystemManager;
		
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
			
			if(sys.numModalWindows > 0)
				sys.removeChildAt(2);
			Alert.show(resource('PLUGIN_ACTIVATED_FEEDBACK', Locale.MAIN, [plugin.name + " " + plugin.version]), resource('PLUGIN_ACTIVATED'));
		}
	}
}
