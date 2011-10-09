package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ShowPluginStorageListEvent;

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
			eventMap.mapListener(view.storageButton, MouseEvent.CLICK, onStorageButtonClick);
		}
		
		private function onStorageButtonClick(event:MouseEvent):void
		{
			dispatch(new ShowPluginStorageListEvent());
		}
	}
}
