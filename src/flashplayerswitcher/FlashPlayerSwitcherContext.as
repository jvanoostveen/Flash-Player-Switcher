package flashplayerswitcher
{
	import flashplayerswitcher.controller.commands.ActivatePluginCommand;
	import flashplayerswitcher.controller.commands.CheckForUpdateCommand;
	import flashplayerswitcher.controller.commands.CheckInstalledSystemPluginVersionCommand;
	import flashplayerswitcher.controller.commands.CheckInstalledUserPluginVersionCommand;
	import flashplayerswitcher.controller.commands.ConfigureDatabaseCommand;
	import flashplayerswitcher.controller.commands.CopyPluginToStorageCommand;
	import flashplayerswitcher.controller.commands.DeletePluginsCommand;
	import flashplayerswitcher.controller.commands.DownloadPluginCommand;
	import flashplayerswitcher.controller.commands.InitializeAppCommand;
	import flashplayerswitcher.controller.commands.LoadDownloadPluginsCommand;
	import flashplayerswitcher.controller.commands.LoadPluginsCommand;
	import flashplayerswitcher.controller.commands.PluginStoredCommand;
	import flashplayerswitcher.controller.commands.ProvideFeedbackCommand;
	import flashplayerswitcher.controller.commands.ReadConfigCommand;
	import flashplayerswitcher.controller.commands.RemoveUserPluginCommand;
	import flashplayerswitcher.controller.commands.ShowHelpCommand;
	import flashplayerswitcher.controller.commands.ShowPreferencesCommand;
	import flashplayerswitcher.controller.commands.StorageDirectoryChangedCommand;
	import flashplayerswitcher.controller.commands.preferences.StoragePrefsAllowEditingChangeCommand;
	import flashplayerswitcher.controller.commands.preferences.StoragePrefsLocationSelectCommand;
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.CheckForUpdateEvent;
	import flashplayerswitcher.controller.events.CheckInstalledPluginVersionEvent;
	import flashplayerswitcher.controller.events.ConfigReadyEvent;
	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.controller.events.DeletePluginsEvent;
	import flashplayerswitcher.controller.events.DownloadPluginEvent;
	import flashplayerswitcher.controller.events.LoadPluginsEvent;
	import flashplayerswitcher.controller.events.PluginStoredEvent;
	import flashplayerswitcher.controller.events.ProvideFeedbackEvent;
	import flashplayerswitcher.controller.events.RemoveUserPluginEvent;
	import flashplayerswitcher.controller.events.ShowHelpEvent;
	import flashplayerswitcher.controller.events.ShowPluginDownloadListEvent;
	import flashplayerswitcher.controller.events.ShowPreferencesEvent;
	import flashplayerswitcher.controller.events.StorageDirectoryChangedEvent;
	import flashplayerswitcher.controller.events.preferences.StoragePrefsAllowEditingChangeEvent;
	import flashplayerswitcher.controller.events.preferences.StoragePrefsLocationSelectEvent;
	import flashplayerswitcher.model.ConfigModel;
	import flashplayerswitcher.model.DownloadPluginsModel;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.StateModel;
	import flashplayerswitcher.model.values.DatabaseFilename;
	import flashplayerswitcher.model.values.GoogleAnalyticsAccount;
	import flashplayerswitcher.model.values.InternetPlugins;
	import flashplayerswitcher.model.values.PluginDownloadURL;
	import flashplayerswitcher.service.ConfigService;
	import flashplayerswitcher.service.DummyTrackerService;
	import flashplayerswitcher.service.FlashplayersService;
	import flashplayerswitcher.service.GoogleAnalyticsTrackerService;
	import flashplayerswitcher.service.IConfigService;
	import flashplayerswitcher.service.IFlashplayersService;
	import flashplayerswitcher.service.IPluginDownloadService;
	import flashplayerswitcher.service.ITrackerService;
	import flashplayerswitcher.service.PluginDownloadService;
	import flashplayerswitcher.service.events.DatabaseReadyEvent;
	import flashplayerswitcher.view.ApplicationMenuMediator;
	import flashplayerswitcher.view.DockIconMediator;
	import flashplayerswitcher.view.FlashPlayerSwitcherMediator;
	import flashplayerswitcher.view.InstalledVersionListing;
	import flashplayerswitcher.view.InstalledVersionListingMediator;
	import flashplayerswitcher.view.MoreOptions;
	import flashplayerswitcher.view.MoreOptionsMediator;
	import flashplayerswitcher.view.PluginDownloadList;
	import flashplayerswitcher.view.PluginDownloadListMediator;
	import flashplayerswitcher.view.PluginStorageListing;
	import flashplayerswitcher.view.PluginStorageListingMediator;
	import flashplayerswitcher.view.PreferencesWindow;
	import flashplayerswitcher.view.PreferencesWindowMediator;
	import flashplayerswitcher.view.ProgressBarPopup;
	import flashplayerswitcher.view.ProgressBarPopupMediator;

	import org.robotlegs.mvcs.Context;

	import mx.events.FlexEvent;

	import flash.desktop.DockIcon;
	import flash.display.NativeMenu;

	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashPlayerSwitcherContext extends Context
	{
		override public function startup():void
		{
			injector.mapValue(InternetPlugins, new InternetPlugins());
			injector.mapValue(GoogleAnalyticsAccount, new GoogleAnalyticsAccount("UA-26342584-3"));
			injector.mapValue(PluginDownloadURL, new PluginDownloadURL("http://www.webdebugger.nl/flashplayerswitcher/plugins.xml"));
			injector.mapValue(DatabaseFilename, new DatabaseFilename("flashplayers.db"));
			
			mediatorMap.mapView(FlashPlayerSwitcher, FlashPlayerSwitcherMediator);
			mediatorMap.mapView(InstalledVersionListing, InstalledVersionListingMediator);
			mediatorMap.mapView(PluginStorageListing, PluginStorageListingMediator);
			mediatorMap.mapView(PluginDownloadList, PluginDownloadListMediator);
			mediatorMap.mapView(ProgressBarPopup, ProgressBarPopupMediator, null, false, false);
			mediatorMap.mapView(NativeMenu, ApplicationMenuMediator);
			mediatorMap.mapView(DockIcon, DockIconMediator);
			mediatorMap.mapView(PreferencesWindow, PreferencesWindowMediator);
			mediatorMap.mapView(MoreOptions, MoreOptionsMediator);
			
			injector.mapSingletonOf(IFlashplayersService, FlashplayersService);
			injector.mapSingletonOf(IPluginDownloadService, PluginDownloadService);
			injector.mapSingletonOf(IConfigService, ConfigService);
			
			IF::DEV
			{
				injector.mapSingletonOf(ITrackerService, DummyTrackerService);
			}
			
			IF::RELEASE
			{
				injector.mapSingletonOf(ITrackerService, GoogleAnalyticsTrackerService);
			}
			
			injector.mapSingleton(PluginsModel);
			injector.mapSingleton(DownloadPluginsModel);
			injector.mapSingleton(ConfigModel);
			injector.mapSingleton(StateModel);
			
			commandMap.mapEvent(FlexEvent.APPLICATION_COMPLETE, ReadConfigCommand);
			commandMap.mapEvent(ConfigReadyEvent.READY, ConfigureDatabaseCommand);
			commandMap.mapEvent(DatabaseReadyEvent.READY, InitializeAppCommand, DatabaseReadyEvent, true);
			commandMap.mapEvent(LoadPluginsEvent.LOAD_PLUGINS, LoadPluginsCommand, LoadPluginsEvent);
			commandMap.mapEvent(CheckInstalledPluginVersionEvent.SYSTEM, CheckInstalledSystemPluginVersionCommand);
			commandMap.mapEvent(CheckInstalledPluginVersionEvent.USER, CheckInstalledUserPluginVersionCommand);
			commandMap.mapEvent(RemoveUserPluginEvent.REMOVE, RemoveUserPluginCommand, RemoveUserPluginEvent);
			commandMap.mapEvent(CopyPluginToStorageEvent.COPY_PLUGIN_TO_STORAGE, CopyPluginToStorageCommand, CopyPluginToStorageEvent);
			commandMap.mapEvent(ActivatePluginEvent.ACTIVATE, ActivatePluginCommand, ActivatePluginEvent);
			commandMap.mapEvent(CheckForUpdateEvent.CHECK_FOR_UPDATE, CheckForUpdateCommand);
			commandMap.mapEvent(DeletePluginsEvent.DELETE, DeletePluginsCommand, DeletePluginsEvent);
			commandMap.mapEvent(ShowPluginDownloadListEvent.SHOW, LoadDownloadPluginsCommand, ShowPluginDownloadListEvent);
			commandMap.mapEvent(DownloadPluginEvent.DOWNLOAD, DownloadPluginCommand, DownloadPluginEvent);
			commandMap.mapEvent(ShowHelpEvent.SHOW, ShowHelpCommand, ShowHelpEvent);
			commandMap.mapEvent(PluginStoredEvent.STORED, PluginStoredCommand, PluginStoredEvent);
			commandMap.mapEvent(ProvideFeedbackEvent.PROVIDE_FEEDBACK, ProvideFeedbackCommand, ProvideFeedbackEvent);
			commandMap.mapEvent(ShowPreferencesEvent.SHOW, ShowPreferencesCommand, ShowPreferencesEvent);
			commandMap.mapEvent(StorageDirectoryChangedEvent.CHANGED, StorageDirectoryChangedCommand, StorageDirectoryChangedEvent);
			
			// preferences
			commandMap.mapEvent(StoragePrefsLocationSelectEvent.CHANGE, StoragePrefsLocationSelectCommand, StoragePrefsLocationSelectEvent);
			commandMap.mapEvent(StoragePrefsAllowEditingChangeEvent.CHANGE, StoragePrefsAllowEditingChangeCommand, StoragePrefsAllowEditingChangeEvent);
			
			super.startup();
		}
	}
}
