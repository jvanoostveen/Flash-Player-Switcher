package flashplayerswitcher
{
	import flashplayerswitcher.controller.commands.CheckInstalledSystemBundleVersionCommand;
	import flashplayerswitcher.controller.commands.CheckInstalledUserBundleVersionCommand;
	import flashplayerswitcher.controller.commands.ConfigureDatabaseCommand;
	import flashplayerswitcher.controller.commands.InitializeAppCommand;
	import flashplayerswitcher.controller.events.CheckInstalledBundleVersionEvent;
	import flashplayerswitcher.controller.events.ConfigureDatabaseEvent;
	import flashplayerswitcher.model.InstalledBundlesModel;
	import flashplayerswitcher.service.events.DatabaseReadyEvent;

	import org.robotlegs.mvcs.Context;

	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashPlayerSwitcherContext extends Context
	{
		override public function startup():void
		{
			injector.mapSingleton(InstalledBundlesModel);
			
			commandMap.mapEvent(ConfigureDatabaseEvent.CONFIGURE, ConfigureDatabaseCommand);
			commandMap.mapEvent(DatabaseReadyEvent.READY, InitializeAppCommand);
			commandMap.mapEvent(CheckInstalledBundleVersionEvent.SYSTEM, CheckInstalledSystemBundleVersionCommand);
			commandMap.mapEvent(CheckInstalledBundleVersionEvent.USER, CheckInstalledUserBundleVersionCommand);
			
			dispatchEvent(new ConfigureDatabaseEvent());
		}
	}
}
