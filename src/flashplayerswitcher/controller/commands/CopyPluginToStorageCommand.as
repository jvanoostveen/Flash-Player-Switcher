package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.service.IFlashplayersService;
	import flashplayerswitcher.service.ITrackerService;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CopyPluginToStorageCommand extends Command
	{
		[Inject]
		public var event:CopyPluginToStorageEvent;
		
		[Inject]
		public var service:IFlashplayersService;
		
		[Inject]
		public var tracker:ITrackerService;
		
		override public function execute():void
		{
			var plugin:FlashPlayerPlugin = event.plugin;
			
			var storage:File = File.applicationStorageDirectory.resolvePath("plugins");
			if (!storage.exists)
				storage.createDirectory();
			
			var pluginDirectory:File = storage.resolvePath(plugin.hash);
			if (!pluginDirectory.exists)
				pluginDirectory.createDirectory();
			
			plugin.plugin.copyTo(pluginDirectory.resolvePath(plugin.plugin.name), true);
			plugin.xpt.copyTo(pluginDirectory.resolvePath(plugin.xpt.name), true);
			
			service.storePlugin(plugin);
			
			tracker.track("/storage/" + plugin.version + "/" + (plugin.debugger ? "debugger" : "release") + "/");
		}
	}
}
