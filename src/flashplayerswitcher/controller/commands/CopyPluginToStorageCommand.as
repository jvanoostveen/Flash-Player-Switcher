package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CopyPluginToStorageCommand extends Command
	{
		[Inject]
		public var event:CopyPluginToStorageEvent;
		
		override public function execute():void
		{
			var storage:File = File.applicationStorageDirectory.resolvePath("plugins");
			if (!storage.exists)
				storage.createDirectory();
			
			var plugin:FlashPlayerPlugin = event.plugin;
			
			var pluginDirectory:File = storage.resolvePath(plugin.hash);
			if (!pluginDirectory.exists)
				pluginDirectory.createDirectory();
			
			plugin.plugin.copyTo(pluginDirectory.resolvePath(plugin.plugin.name), true);
			plugin.xpt.copyTo(pluginDirectory.resolvePath(plugin.xpt.name), true);
		}
	}
}
