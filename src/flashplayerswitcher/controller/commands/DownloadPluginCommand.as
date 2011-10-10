package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.DownloadPluginEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DownloadPluginCommand extends Command
	{
		[Inject]
		public var event:DownloadPluginEvent;
		
		override public function execute():void
		{
//			commandMap.detain(this);
			
			// load zip
			// extract zip
			// extract specific files and assign them to FlashPlayerPlugin Files
			// dispatch CopyPluginToStorageEvent
		}
	}
}
