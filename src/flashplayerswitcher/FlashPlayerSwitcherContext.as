package flashplayerswitcher
{
	import flashplayerswitcher.controller.commands.CheckForUpdateCommand;
	import flashplayerswitcher.controller.commands.CheckInstalledSystemPluginVersionCommand;
	import flashplayerswitcher.controller.commands.CheckInstalledUserPluginVersionCommand;
	import flashplayerswitcher.controller.commands.ConfigureDatabaseCommand;
	import flashplayerswitcher.controller.commands.CopyPluginToStorageCommand;
	import flashplayerswitcher.controller.commands.DeletePluginCommand;
	import flashplayerswitcher.controller.commands.DownloadPluginCommand;
	import flashplayerswitcher.controller.commands.InitializeAppCommand;
	import flashplayerswitcher.controller.commands.ActivatePluginCommand;
	import flashplayerswitcher.controller.commands.LoadDownloadPluginsCommand;
	import flashplayerswitcher.controller.commands.LoadPluginsCommand;
	import flashplayerswitcher.controller.commands.RemoveUserPluginCommand;
	import flashplayerswitcher.controller.events.CheckForUpdateEvent;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.controller.events.DeletePluginEvent;
	import flashplayerswitcher.controller.events.DownloadPluginEvent;
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.controller.events.RemoveUserPluginEvent;
	import flashplayerswitcher.controller.events.ShowPluginDownloadListEvent;
	import flashplayerswitcher.model.DownloadPluginsModel;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.service.GoogleAnalyticsTrackerService;
	import flashplayerswitcher.service.IFlashplayersService;
	import flashplayerswitcher.service.IPluginDownloadService;
	import flashplayerswitcher.service.ITrackerService;
	import flashplayerswitcher.service.PluginDownloadService;
	import flashplayerswitcher.service.SQLFlashplayersService;
	import flashplayerswitcher.service.events.DatabaseReadyEvent;
	import flashplayerswitcher.view.FlashPlayerSwitcherMediator;
	import flashplayerswitcher.view.InstalledVersionListing;
	import flashplayerswitcher.view.InstalledVersionListingMediator;
	import flashplayerswitcher.view.PluginDownloadList;
	import flashplayerswitcher.view.PluginDownloadListMediator;
	import flashplayerswitcher.view.PluginStorageListing;
	import flashplayerswitcher.view.PluginStorageListingMediator;
	import flashplayerswitcher.view.ProgressBarPopup;
	import flashplayerswitcher.view.ProgressBarPopupMediator;

	import org.robotlegs.mvcs.Context;

	import mx.events.FlexEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashPlayerSwitcherContext extends Context
	{
		override public function startup():void
		{
			mediatorMap.mapView(FlashPlayerSwitcher, FlashPlayerSwitcherMediator);
			mediatorMap.mapView(InstalledVersionListing, InstalledVersionListingMediator);
			mediatorMap.mapView(PluginStorageListing, PluginStorageListingMediator);
			mediatorMap.mapView(PluginDownloadList, PluginDownloadListMediator);
			mediatorMap.mapView(ProgressBarPopup, ProgressBarPopupMediator, null, false, false);
			
			injector.mapSingletonOf(IFlashplayersService, SQLFlashplayersService);
			injector.mapSingletonOf(IPluginDownloadService, PluginDownloadService);
			injector.mapSingletonOf(ITrackerService, GoogleAnalyticsTrackerService);
			
			injector.mapSingleton(PluginsModel);
			injector.mapSingleton(DownloadPluginsModel);
			
			commandMap.mapEvent(FlexEvent.APPLICATION_COMPLETE, ConfigureDatabaseCommand);
			commandMap.mapEvent(DatabaseReadyEvent.READY, InitializeAppCommand);
			commandMap.mapEvent(LoadPluginsEvent.LOAD_PLUGINS, LoadPluginsCommand, LoadPluginsEvent);
			commandMap.mapEvent(CheckInstalledPluginVersionEvent.SYSTEM, CheckInstalledSystemPluginVersionCommand);
			commandMap.mapEvent(CheckInstalledPluginVersionEvent.USER, CheckInstalledUserPluginVersionCommand);
			commandMap.mapEvent(RemoveUserPluginEvent.REMOVE, RemoveUserPluginCommand, RemoveUserPluginEvent);
			commandMap.mapEvent(CopyPluginToStorageEvent.COPY_PLUGIN_TO_STORAGE, CopyPluginToStorageCommand, CopyPluginToStorageEvent);
			commandMap.mapEvent(ActivatePluginEvent.ACTIVATE, ActivatePluginCommand, ActivatePluginEvent);
			commandMap.mapEvent(CheckForUpdateEvent.CHECK_FOR_UPDATE, CheckForUpdateCommand);
			commandMap.mapEvent(DeletePluginEvent.DELETE, DeletePluginCommand, DeletePluginEvent);
			commandMap.mapEvent(ShowPluginDownloadListEvent.SHOW, LoadDownloadPluginsCommand, ShowPluginDownloadListEvent);
			commandMap.mapEvent(DownloadPluginEvent.DOWNLOAD, DownloadPluginCommand, DownloadPluginEvent);
			
			super.startup();
		}
	}
}
