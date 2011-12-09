package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.DeletePluginsEvent;
	import flashplayerswitcher.controller.events.InstalledPluginUpdatedEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.controller.events.StorageAllowEditingChangedEvent;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.PluginSet;

	import spark.events.GridSelectionEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.MouseEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginStorageListingMediator extends Mediator
	{
		[Inject]
		public var view:PluginStorageListing;

		[Inject]
		public var installed:PluginsModel;
		
		override public function onRegister():void
		{
			addContextListener(PluginsUpdatedEvent.UPDATED, onPluginsUpdated, PluginsUpdatedEvent);
			addContextListener(InstalledPluginUpdatedEvent.USER, onUserPluginUpdate, InstalledPluginUpdatedEvent);
			addContextListener(StorageAllowEditingChangedEvent.CHANGED, onAllowEditingChanged, StorageAllowEditingChangedEvent);
			
			eventMap.mapListener(view.listing, GridSelectionEvent.SELECTION_CHANGE, onSelectionChange);
			eventMap.mapListener(view.installButton, MouseEvent.CLICK, onInstallButtonClick);
			eventMap.mapListener(view.installDebuggerButton, MouseEvent.CLICK, onInstallButtonClick);
			eventMap.mapListener(view.deleteButton, MouseEvent.CLICK, onDeleteButtonClick);
		}
		
		private function onPluginsUpdated(event:PluginsUpdatedEvent):void
		{
			view.listing.dataProvider = installed.sortedPlugins;
			
			view.installButton.enabled = view.installDebuggerButton.enabled = false;
			view.deleteButton.enabled = false;
		}
		
		private function onUserPluginUpdate(event:InstalledPluginUpdatedEvent):void
		{
			var selected:FlashPlayerPlugin = view.listing.selectedItem as FlashPlayerPlugin;
			if (selected)
			{
				if (event.plugin && selected.hash == event.plugin.hash)
					view.installButton.enabled = view.installDebuggerButton.enabled = false;
				else
					view.installButton.enabled = view.installDebuggerButton.enabled = true;
			}
		}
		
		private function onAllowEditingChanged(event:StorageAllowEditingChangedEvent):void
		{
			view.deleteButton.visible = event.allowEditing;
		}
		
		private function onSelectionChange(event:GridSelectionEvent):void
		{
			view.installButton.enabled = view.installDebuggerButton.enabled = false;
			view.deleteButton.enabled = false;
			
			if (view.listing.selectedIndex != -1)
			{
				var pluginSet:PluginSet = view.listing.selectedItem as PluginSet;
				if (!installed.user)
				{
					if (pluginSet.release)
						view.installButton.enabled = true;
					if (pluginSet.debugger)
						view.installDebuggerButton.enabled = true;
				} else {
					if (pluginSet.release && pluginSet.release.hash != installed.user.hash)
						view.installButton.enabled = true;
					if (pluginSet.debugger && pluginSet.debugger.hash != installed.user.hash)
						view.installDebuggerButton.enabled = true;
				}
				
				view.deleteButton.enabled = true;
			}
		}
		
		private function onInstallButtonClick(event:MouseEvent):void
		{
			var pluginSet:PluginSet = view.listing.selectedItem as PluginSet;
			var plugin:FlashPlayerPlugin;
			if (event.currentTarget == view.installButton)
				plugin = pluginSet.release;
			if (event.currentTarget == view.installDebuggerButton)
				plugin = pluginSet.debugger;
			
			if (plugin)
				dispatch(new ActivatePluginEvent(plugin));
		}
		
		private function onDeleteButtonClick(event:MouseEvent):void
		{
			var pluginSet:PluginSet = view.listing.selectedItem as PluginSet;
			var plugins:Array = new Array();
			if (pluginSet.release)
				plugins.push(pluginSet.release);
			if (pluginSet.debugger)
				plugins.push(pluginSet.debugger);
			
			dispatch(new DeletePluginsEvent(plugins));
		}
	}
}
