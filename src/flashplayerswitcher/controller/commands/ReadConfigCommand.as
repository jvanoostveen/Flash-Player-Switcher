package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.ConfigReadyEvent;
	import flashplayerswitcher.service.IConfigService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ReadConfigCommand extends Command
	{
		[Inject]
		public var configService:IConfigService;
		
		override public function execute():void
		{
			configService.readConfig();
			
			dispatch(new ConfigReadyEvent());
		}
	}
}
