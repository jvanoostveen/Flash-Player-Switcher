package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.view.PreferencesWindow;

	import spark.components.Window;

	import org.robotlegs.mvcs.Command;

	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.system.Capabilities;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ShowPreferencesCommand extends Command
	{
		override public function execute():void
		{
			var windows:Array = NativeApplication.nativeApplication.openedWindows;
			for each (var window:NativeWindow in windows)
			{
				// is there a better way to detect if this window is the same window?
				if (window.title == "Preferences")
				{
					window.activate();
					return;
				}
			}
			
			var w:Window = new PreferencesWindow();
			mediatorMap.createMediator(w);
			w.open();
			
			w.nativeWindow.x = Math.round((Capabilities.screenResolutionX - w.width) * 0.5);
			w.nativeWindow.y = 175;
		}
	}
}
