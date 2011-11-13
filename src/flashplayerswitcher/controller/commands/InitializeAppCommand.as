package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckForUpdateEvent;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.service.ITrackerService;
	import flashplayerswitcher.view.ApplicationMenu;

	import org.robotlegs.mvcs.Command;

	import flash.desktop.NativeApplication;

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
			
			new ApplicationMenu();
			mediatorMap.createMediator(NativeApplication.nativeApplication.menu);
			
			IF::RELEASE
			{
				dispatch(new CheckForUpdateEvent());
			}
			
			dispatch(new LoadPluginsEvent());
			
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.SYSTEM));
			dispatch(new CheckInstalledPluginVersionEvent(CheckInstalledPluginVersionEvent.USER));
		}
	}
}
