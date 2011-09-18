package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.service.IFlashplayersService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class LoadFlashplayersCommand extends Command
	{
		[Inject]
		public var flashplayers:IFlashplayersService;
		
		override public function execute():void
		{
			flashplayers.loadFlashplayers();
		}
	}
}
