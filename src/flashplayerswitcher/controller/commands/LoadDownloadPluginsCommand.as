package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.service.IPluginDownloadService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class LoadDownloadPluginsCommand extends Command
	{
		[Inject]
		public var service:IPluginDownloadService;
		
		override public function execute():void
		{
			service.loadPlugins();
		}
	}
}
