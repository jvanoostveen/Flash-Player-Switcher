package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.InternetPlugins;
	import flashplayerswitcher.service.IFlashplayersService;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CopyPluginToStorageCommand extends Command
	{
		[Inject]
		public var service:IFlashplayersService;
		
		override public function execute():void
		{
			var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
			plugin.search(InternetPlugins.SYSTEM);
			
			var storage:File = File.applicationStorageDirectory.resolvePath("plugins");
			if (!storage.exists)
				storage.createDirectory();
			
			var pluginDirectory:File = storage.resolvePath(plugin.hash);
			if (!pluginDirectory.exists)
				pluginDirectory.createDirectory();
			
			plugin.plugin.copyTo(pluginDirectory.resolvePath(plugin.plugin.name), true);
			plugin.xpt.copyTo(pluginDirectory.resolvePath(plugin.xpt.name), true);
			
			service.storePlugin(plugin);
		}
	}
}
