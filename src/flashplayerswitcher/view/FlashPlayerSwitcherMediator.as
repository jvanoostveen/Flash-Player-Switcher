package flashplayerswitcher.view
{
	import flashplayerswitcher.FlashPlayerSwitcher;
	import flashplayerswitcher.controller.events.ShowPluginDownloadListEvent;
	import flashplayerswitcher.controller.events.ShowPluginStorageListEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashPlayerSwitcherMediator extends Mediator
	{
		[Inject]
		public var view:FlashPlayerSwitcher;
		
		override public function onRegister():void
		{
			addContextListener(ShowPluginDownloadListEvent.SHOW, showDownloadList, ShowPluginDownloadListEvent);
			addContextListener(ShowPluginStorageListEvent.SHOW, showStorageList, ShowPluginStorageListEvent);
		}
		
		private function showDownloadList(event:ShowPluginDownloadListEvent):void
		{
			view.download.visible = true;
			view.storage.visible = false;
		}
		
		private function showStorageList(event:ShowPluginStorageListEvent):void
		{
			view.download.visible = false;
			view.storage.visible = true;
		}
	}
}
