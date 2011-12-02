package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.DeletePluginEvent;
	import flashplayerswitcher.controller.events.InstalledPluginUpdatedEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.controller.events.ShowPluginDownloadListEvent;
	import flashplayerswitcher.controller.events.StorageAllowEditingChangedEvent;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

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
			eventMap.mapListener(view.deleteButton, MouseEvent.CLICK, onDeleteButtonClick);
			eventMap.mapListener(view.downloadButton, MouseEvent.CLICK, onDownloadButtonClick);
		}
		
		private function onPluginsUpdated(event:PluginsUpdatedEvent):void
		{
			view.listing.dataProvider = installed.plugins;
			
			view.installButton.enabled = false;
			view.deleteButton.enabled = false;
		}
		
		private function onUserPluginUpdate(event:InstalledPluginUpdatedEvent):void
		{
			var selected:FlashPlayerPlugin = view.listing.selectedItem as FlashPlayerPlugin;
			if (selected)
			{
				if (event.plugin && selected.hash == event.plugin.hash)
					view.installButton.enabled = false;
				else
					view.installButton.enabled = true;
			}
		}
		
		private function onAllowEditingChanged(event:StorageAllowEditingChangedEvent):void
		{
			view.downloadButton.visible = event.allowEditing;
			view.deleteButton.visible = event.allowEditing;
		}
		
		private function onSelectionChange(event:GridSelectionEvent):void
		{
			view.installButton.enabled = false;
			view.deleteButton.enabled = false;
			
			if (view.listing.selectedIndex != -1)
			{
				if (!installed.user || (view.listing.selectedItem as FlashPlayerPlugin).hash != installed.user.hash)
					view.installButton.enabled = true;
				view.deleteButton.enabled = true;
			}
		}
		
		private function onInstallButtonClick(event:MouseEvent):void
		{
			dispatch(new ActivatePluginEvent(view.listing.selectedItem as FlashPlayerPlugin));
		}
		
		private function onDeleteButtonClick(event:MouseEvent):void
		{
			dispatch(new DeletePluginEvent(view.listing.selectedItem as FlashPlayerPlugin));
		}
		
		private function onDownloadButtonClick(event:MouseEvent):void
		{
			dispatch(new ShowPluginDownloadListEvent());
		}
	}
}
