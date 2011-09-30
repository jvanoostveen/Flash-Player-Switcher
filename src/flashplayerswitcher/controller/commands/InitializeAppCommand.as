package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.model.vo.InternetPlugins;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InitializeAppCommand extends Command
	{
		override public function execute():void
		{
			// TODO: refactor to RobotLegs ways...
			InternetPlugins.SYSTEM = (File.getRootDirectories()[0] as File).resolvePath("Library/Internet Plug-Ins");
			InternetPlugins.USER = File.userDirectory.resolvePath("Library/Internet Plug-Ins");
			
			dispatch(new LoadPluginsEvent());
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.SYSTEM));
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
			
			
		}
	}
}
