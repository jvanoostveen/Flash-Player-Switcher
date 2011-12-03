package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.controller.events.InstalledPluginUpdatedEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.controller.events.RemoveUserPluginEvent;
	import flashplayerswitcher.controller.events.StorageAllowEditingChangedEvent;
	import flashplayerswitcher.model.ConfigModel;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.values.InternetPlugins;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.MouseEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InstalledVersionListingMediator extends Mediator
	{
		[Inject]
		public var view:InstalledVersionListing;
		
		[Inject]
		public var plugins:PluginsModel;

		[Inject]
		public var pluginLocations:InternetPlugins;
		
		[Inject]
		public var config:ConfigModel;
		
		override public function onRegister():void
		{
			addContextListener(InstalledPluginUpdatedEvent.SYSTEM, systemPluginUpdated);
			addContextListener(InstalledPluginUpdatedEvent.USER, userPluginUpdated);
			addContextListener(PluginsUpdatedEvent.UPDATED, knownPluginsUpdated);
			addContextListener(StorageAllowEditingChangedEvent.CHANGED, onAllowEditingChanged, StorageAllowEditingChangedEvent);
			
			eventMap.mapListener(view.copySystemPluginButton, MouseEvent.CLICK, onCopyPluginClick);
			addViewListener(RemoveUserPluginEvent.REMOVE, dispatch);
		}
		
		private function knownPluginsUpdated(event:PluginsUpdatedEvent):void
		{
			// check if copy system plugin button should be visible
			checkSystemPluginInstall();
		}

		private function onAllowEditingChanged(event:StorageAllowEditingChangedEvent):void
		{
			view.copySystemPluginButton.visible = event.allowEditing;
			
			checkSystemPluginInstall();
		}
		
		private function checkSystemPluginInstall():void
		{
			view.copySystemPluginButton.visible = false;
			if (config.storageAllowEditing && plugins.system && !plugins.contains(plugins.system))
			{
				view.copySystemPluginButton.visible = true;
			}
		}
		
		private function systemPluginUpdated(event:InstalledPluginUpdatedEvent):void
		{
			if (event.plugin)
				view.systemInstalledVersion.text = event.plugin.name + " (" + event.plugin.version + ")";
			else
				view.systemInstalledVersion.text = resource("INSTALLED_NONE");
			
			checkSystemPluginInstall();
		}
		
		private function userPluginUpdated(event:InstalledPluginUpdatedEvent):void
		{
			if (event.plugin)
				view.userInstalledVersion.text = event.plugin.name + " (" + event.plugin.version + ")";
			else
				view.userInstalledVersion.text = resource("INSTALLED_NONE");
			
			view.removeUserPluginButton.visible = (event.plugin ? true : false);
		}
		
		private function onCopyPluginClick(event:MouseEvent):void
		{
			var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
			plugin.search(pluginLocations.system);
			
			dispatch(new CopyPluginToStorageEvent(plugin));
		}
	}
}
