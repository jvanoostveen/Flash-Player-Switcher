package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.service.ITrackerService;
	import flashplayerswitcher.view.HelpWindow;

	import spark.components.Window;

	import org.robotlegs.mvcs.Command;

	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.system.Capabilities;

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
			
			var windows:Array = NativeApplication.nativeApplication.openedWindows;
			for each (var window:NativeWindow in windows)
			{
				// is there a better way to detect if this window is the help window?
				// window is HelpWindow doesn't work...
				if (window.title == resource("HELP_WINDOW_TITLE"))
				{
					window.activate();
					return;
				}
			}
			
			var w:Window = new HelpWindow();
			w.title = resource("HELP_WINDOW_TITLE");
			w.name = "help_window";
			w.open();
			
			w.nativeWindow.x = Math.round((Capabilities.screenResolutionX - w.width) * 0.5);
			w.nativeWindow.y = 175;
		}
	}
}
