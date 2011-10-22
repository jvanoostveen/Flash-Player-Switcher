package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.service.ITrackerService;
	import flashplayerswitcher.view.HelpWindow;

	import spark.components.Window;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ShowHelpCommand extends Command
	{
		[Inject]
		public var tracker:ITrackerService;
		
		override public function execute():void
		{
			tracker.track("/help/");
			
			var w:Window = new HelpWindow();
			w.title = "Flash Player Switcher - Help";
			w.name = "help_window";
			w.open();
		}
	}
}
