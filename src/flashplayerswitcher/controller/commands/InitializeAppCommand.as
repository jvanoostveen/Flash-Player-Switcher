package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckForUpdateEvent;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.model.vo.InternetPlugins;
	import flashplayerswitcher.service.ITrackerService;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InitializeAppCommand extends Command
	{
		[Inject]
		public var tracker:ITrackerService;
		
		override public function execute():void
		{
			tracker.init(contextView);
			tracker.track("/");
			
			// TODO: refactor to RobotLegs ways...
			InternetPlugins.SYSTEM = (File.getRootDirectories()[0] as File).resolvePath("Library/Internet Plug-Ins");
			InternetPlugins.USER = File.userDirectory.resolvePath("Library/Internet Plug-Ins");
			
			dispatch(new CheckForUpdateEvent());
			
			dispatch(new LoadPluginsEvent());
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.SYSTEM));
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
		}
	}
}
