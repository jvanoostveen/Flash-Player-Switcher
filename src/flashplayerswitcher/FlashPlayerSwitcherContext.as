package flashplayerswitcher
{
	import flashplayerswitcher.controller.commands.CheckInstalledSystemPluginVersionCommand;
	import flashplayerswitcher.controller.commands.CheckInstalledUserPluginVersionCommand;
	import flashplayerswitcher.controller.commands.ConfigureDatabaseCommand;
	import flashplayerswitcher.controller.commands.CopySystemPluginCommand;
	import flashplayerswitcher.controller.commands.InitializeAppCommand;
	import flashplayerswitcher.controller.commands.RemoveUserPluginCommand;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.CopySystemPluginEvent;
	import flashplayerswitcher.controller.events.RemoveUserPluginEvent;
	import flashplayerswitcher.model.InstalledPluginsModel;
	import flashplayerswitcher.service.IFlashplayersService;
	import flashplayerswitcher.service.SQLFlashplayersService;
	import flashplayerswitcher.service.events.DatabaseReadyEvent;
	import flashplayerswitcher.view.FlashplayerListing;
	import flashplayerswitcher.view.FlashplayerListingMediator;
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
			mediatorMap.mapView(FlashplayerListing, FlashplayerListingMediator);
			
			injector.mapSingletonOf(IFlashplayersService, SQLFlashplayersService);
			
			injector.mapSingleton(InstalledPluginsModel);
			
			commandMap.mapEvent(FlexEvent.APPLICATION_COMPLETE, ConfigureDatabaseCommand);
			commandMap.mapEvent(DatabaseReadyEvent.READY, InitializeAppCommand);
			commandMap.mapEvent(CheckInstalledPluginVersionEvent.SYSTEM, CheckInstalledSystemPluginVersionCommand);
			commandMap.mapEvent(CheckInstalledPluginVersionEvent.USER, CheckInstalledUserPluginVersionCommand);
			commandMap.mapEvent(CopySystemPluginEvent.COPY, CopySystemPluginCommand, CopySystemPluginEvent);
			commandMap.mapEvent(RemoveUserPluginEvent.REMOVE, RemoveUserPluginCommand, RemoveUserPluginEvent);
			
			super.startup();
		}
	}
}
