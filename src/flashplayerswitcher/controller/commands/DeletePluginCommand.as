package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.DeletePluginEvent;
	import flashplayerswitcher.service.IFlashplayersService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DeletePluginCommand extends Command
	{
		[Inject]
		public var event:DeletePluginEvent;
		
		[Inject]
		public var service:IFlashplayersService;
		
		override public function execute():void
		{
			service.deletePlugin(event.plugin);
			
			event.plugin.remove();
		}
	}
}
