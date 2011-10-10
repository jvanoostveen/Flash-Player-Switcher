package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.DownloadPluginEvent;
	import flashplayerswitcher.controller.events.DownloadPluginsUpdatedEvent;
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
			addContextListener(DownloadPluginsUpdatedEvent.UPDATED, onPluginsUpdated, DownloadPluginsUpdatedEvent);
			
			eventMap.mapListener(view.listing, GridSelectionEvent.SELECTION_CHANGE, onSelectionChange);
			eventMap.mapListener(view.downloadButton, MouseEvent.CLICK, onDownloadButtonClick);
			eventMap.mapListener(view.storageButton, MouseEvent.CLICK, onStorageButtonClick);
		}
		
		private function onPluginsUpdated(event:DownloadPluginsUpdatedEvent):void
		{
			// TODO: filter already installed plugins
			
			view.listing.dataProvider = event.plugins;
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
