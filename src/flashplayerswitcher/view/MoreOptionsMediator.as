package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ShowHelpEvent;
	import flashplayerswitcher.controller.events.ShowPluginDownloadListEvent;
	import flashplayerswitcher.controller.events.ShowPluginStorageListEvent;
	import flashplayerswitcher.controller.events.StorageAllowEditingChangedEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.MouseEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class MoreOptionsMediator extends Mediator
	{
		[Inject]
		public var view:MoreOptions;
		
		override public function onRegister():void
		{
			addContextListener(StorageAllowEditingChangedEvent.CHANGED, onAllowEditingChanged, StorageAllowEditingChangedEvent);
			addContextListener(ShowPluginDownloadListEvent.SHOW, onShowPluginDownloadList, ShowPluginDownloadListEvent);
			addContextListener(ShowPluginStorageListEvent.SHOW, onShowPluginStorageList, ShowPluginStorageListEvent);
			
			addViewListener(ShowPluginDownloadListEvent.SHOW, dispatch, ShowPluginDownloadListEvent);
			addViewListener(ShowPluginStorageListEvent.SHOW, dispatch, ShowPluginStorageListEvent);
			eventMap.mapListener(view.helpButton, MouseEvent.CLICK, onHelpButtonClick, MouseEvent);
		}
		
		private function onAllowEditingChanged(event:StorageAllowEditingChangedEvent):void
		{
			view.downloadButton.visible = event.allowEditing;
		}
		
		private function onShowPluginDownloadList(event:ShowPluginDownloadListEvent):void
		{
			view.currentState = "download";
		}
		
		private function onShowPluginStorageList(event:ShowPluginStorageListEvent):void
		{
			view.currentState = "storage";
		}
		
		private function onHelpButtonClick(event:MouseEvent):void
		{
			dispatch(new ShowHelpEvent());
		}
	}
}
