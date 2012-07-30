package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.locale.Locale;
	import flashplayerswitcher.model.ConfigModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.service.IFlashplayersService;
	import flashplayerswitcher.service.growl.IGrowlService;
	import flashplayerswitcher.service.growl.NotificationName;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CopyPluginToStorageCommand extends Command
	{
		[Inject] public var event:CopyPluginToStorageEvent;
		
		[Inject] public var service:IFlashplayersService;
		[Inject] public var config:ConfigModel;
		[Inject] public var growl:IGrowlService;
		
		override public function execute():void
		{
			var plugin:FlashPlayerPlugin = event.plugin;
			
			var storage:File = config.storageDirectory.resolvePath("plugins");
			if (!storage.exists)
				storage.createDirectory();
			
			var pluginDirectory:File = storage.resolvePath(plugin.hash);
			if (!pluginDirectory.exists)
				pluginDirectory.createDirectory();
			
			plugin.plugin.copyTo(pluginDirectory.resolvePath(plugin.plugin.name), true);
			plugin.xpt.copyTo(pluginDirectory.resolvePath(plugin.xpt.name), true);
			
			service.storePlugin(plugin);
			
			growl.notify(NotificationName.PLUGIN_INSTALLED, resource("PLUGIN_INSTALLED_NOTIFICATION_TITLE", Locale.GROWL), resource("PLUGIN_INSTALLED_NOTITICATION_MESSAGE", Locale.GROWL, [plugin.name + " " + plugin.version]));
		}
	}
}
