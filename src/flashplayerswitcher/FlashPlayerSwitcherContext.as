package flashplayerswitcher
{
	import flashplayerswitcher.controller.commands.CheckInstalledSystemBundleVersionCommand;
	import flashplayerswitcher.controller.commands.CheckInstalledUserBundleVersionCommand;
	import flashplayerswitcher.controller.commands.ConfigureDatabaseCommand;
	import flashplayerswitcher.controller.commands.InitializeAppCommand;
	import flashplayerswitcher.controller.events.CheckInstalledBundleVersionEvent;
	import flashplayerswitcher.model.InstalledBundlesModel;
	import flashplayerswitcher.service.events.DatabaseReadyEvent;
	import flashplayerswitcher.view.InstalledVersionListing;
	import flashplayerswitcher.view.InstalledVersionListingMediator;

	import org.robotlegs.mvcs.Context;

	import mx.events.FlexEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashPlayerSwitcherContext extends Context
	{
		override public function startup():void
		{
			mediatorMap.mapView(InstalledVersionListing, InstalledVersionListingMediator);
			
			injector.mapSingleton(InstalledBundlesModel);
			
			commandMap.mapEvent(FlexEvent.APPLICATION_COMPLETE, ConfigureDatabaseCommand);
			commandMap.mapEvent(DatabaseReadyEvent.READY, InitializeAppCommand);
			commandMap.mapEvent(CheckInstalledBundleVersionEvent.SYSTEM, CheckInstalledSystemBundleVersionCommand);
			commandMap.mapEvent(CheckInstalledBundleVersionEvent.USER, CheckInstalledUserBundleVersionCommand);
			
			super.startup();
		}
	}
}
