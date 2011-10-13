package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.DownloadListDataErrorEvent;
	import flashplayerswitcher.controller.events.DownloadPluginEvent;
	import flashplayerswitcher.controller.events.DownloadPluginsUpdatedEvent;
	import flashplayerswitcher.controller.events.ShowPluginDownloadListEvent;
	import flashplayerswitcher.controller.events.ShowPluginStorageListEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import spark.events.GridSelectionEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.MouseEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginDownloadListMediator extends Mediator
	{
		[Inject]
		public var view:PluginDownloadList;
		
		override public function onRegister():void
		{
			addContextListener(ShowPluginDownloadListEvent.SHOW, onShowList, ShowPluginDownloadListEvent);
			addContextListener(DownloadPluginsUpdatedEvent.UPDATED, onPluginsUpdated, DownloadPluginsUpdatedEvent);
			addContextListener(DownloadListDataErrorEvent.ERROR, onDataError, DownloadListDataErrorEvent);
			
			eventMap.mapListener(view.listing, GridSelectionEvent.SELECTION_CHANGE, onSelectionChange);
			eventMap.mapListener(view.downloadButton, MouseEvent.CLICK, onDownloadButtonClick);
			eventMap.mapListener(view.storageButton, MouseEvent.CLICK, onStorageButtonClick);
		}
		
		private function onShowList(event:ShowPluginDownloadListEvent):void
		{
			view.downloadButton.enabled = false;
			
			view.listing.selectedIndex = -1;
			view.listing.dataProvider = null;
			
			view.message.show("Loading data");
		}
		
		private function onPluginsUpdated(event:DownloadPluginsUpdatedEvent):void
		{
			view.message.hide();
			view.listing.dataProvider = event.plugins;
			
			if (event.plugins.length == 0)
				view.message.show("No plugins available");
		}
		
		private function onDataError(event:DownloadListDataErrorEvent):void
		{
			view.message.show("Plugin data could not be retrieved");
		}
		
		private function onSelectionChange(event:GridSelectionEvent):void
		{
			view.downloadButton.enabled = false;
			
			if (view.listing.selectedIndex != -1)
			{
				view.downloadButton.enabled = true;
			}
		}
		
		private function onDownloadButtonClick(event:MouseEvent):void
		{
			dispatch(new DownloadPluginEvent(view.listing.selectedItem as FlashPlayerPlugin));
		}
		
		private function onStorageButtonClick(event:MouseEvent):void
		{
			dispatch(new ShowPluginStorageListEvent());
		}
	}
}
