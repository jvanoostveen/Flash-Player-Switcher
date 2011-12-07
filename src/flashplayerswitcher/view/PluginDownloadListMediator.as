package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.DownloadListDataErrorEvent;
	import flashplayerswitcher.controller.events.DownloadPluginEvent;
	import flashplayerswitcher.controller.events.DownloadPluginsUpdatedEvent;
	import flashplayerswitcher.controller.events.ShowPluginDownloadListEvent;
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
		}
		
		private function onShowList(event:ShowPluginDownloadListEvent):void
		{
			view.downloadButton.enabled = false;
			
			view.listing.selectedIndex = -1;
			view.listing.dataProvider = null;
			
			view.message.show(resource("LOADING_DATA"));
		}
		
		private function onPluginsUpdated(event:DownloadPluginsUpdatedEvent):void
		{
			view.message.hide();
			view.listing.dataProvider = event.plugins;
			
			if (event.plugins.length == 0)
				view.message.show(resource("NO_PLUGINS_AVAILABLE"));
		}
		
		private function onDataError(event:DownloadListDataErrorEvent):void
		{
			view.message.show(resource("PLUGIN_DATA_ERROR"));
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
			var plugins:Vector.<FlashPlayerPlugin> = new Vector.<FlashPlayerPlugin>();
			for each (var plugin:FlashPlayerPlugin in view.listing.selectedItems)
			{
				plugins.push(plugin);
			}
			
			dispatch(new DownloadPluginEvent(plugins));
		}
	}
}
