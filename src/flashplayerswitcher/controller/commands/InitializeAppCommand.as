package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckForUpdateEvent;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.service.growl.IGrowlService;
	import flashplayerswitcher.view.ApplicationMenu;

	import org.robotlegs.mvcs.Command;

	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InitializeAppCommand extends Command
	{
		[Inject] public var growl:IGrowlService;
		
		override public function execute():void
		{
			growl.register();
			
			new ApplicationMenu();
			mediatorMap.createMediator(NativeApplication.nativeApplication.menu);
			
			(NativeApplication.nativeApplication.icon as DockIcon).menu = new NativeMenu();
			mediatorMap.createMediator(NativeApplication.nativeApplication.icon);
			
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
