package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.StorePluginSetEvent;
	import flashplayerswitcher.service.IFlashplayersService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StorePluginSetCommand extends Command
	{
		[Inject] public var event:StorePluginSetEvent;
		
		[Inject] public var service:IFlashplayersService;
		
		override public function execute():void
		{
			service.storePluginSet(event.pluginSet);
		}
	}
}
