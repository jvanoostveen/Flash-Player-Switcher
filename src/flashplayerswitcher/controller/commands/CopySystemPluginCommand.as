package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.InternetPlugins;
	import flashplayerswitcher.service.IFlashplayersService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CopySystemPluginCommand extends Command
	{
		[Inject]
		public var service:IFlashplayersService;
		
		override public function execute():void
		{
			// copy system plugin files to storage
			var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
			plugin.search(InternetPlugins.SYSTEM);
			
			dispatch(new CopyPluginToStorageEvent(plugin));
			
			service.storePlugin(plugin);
			
//			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.SYSTEM));
		}
	}
}
