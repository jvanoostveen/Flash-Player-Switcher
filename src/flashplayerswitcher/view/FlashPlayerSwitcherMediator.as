package flashplayerswitcher.view
{
	import flashplayerswitcher.FlashPlayerSwitcher;
	import flashplayerswitcher.controller.events.ProgressBarPopupEvent;
	import flashplayerswitcher.controller.events.ShowHelpEvent;
	import flashplayerswitcher.controller.events.ShowPluginDownloadListEvent;
	import flashplayerswitcher.controller.events.ShowPluginStorageListEvent;

	import org.robotlegs.mvcs.Mediator;

	import mx.managers.PopUpManager;

	import flash.events.MouseEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashPlayerSwitcherMediator extends Mediator
	{
		[Inject]
		public var view:FlashPlayerSwitcher;
		
		private var _progressPopUp:ProgressBarPopup;
		
		override public function onRegister():void
		{
			addContextListener(ShowPluginDownloadListEvent.SHOW, showDownloadList, ShowPluginDownloadListEvent);
			addContextListener(ShowPluginStorageListEvent.SHOW, showStorageList, ShowPluginStorageListEvent);
			addContextListener(ProgressBarPopupEvent.SHOW, addProgressBarPopup, ProgressBarPopupEvent, false, 100);
			
			eventMap.mapListener(view.helpButton, MouseEvent.CLICK, onHelpButtonClick, MouseEvent);
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
		
		private function addProgressBarPopup(event:ProgressBarPopupEvent):void
		{
			if (!_progressPopUp)
			{
				_progressPopUp = new ProgressBarPopup();
				mediatorMap.createMediator(_progressPopUp);
				
				PopUpManager.addPopUp(_progressPopUp, contextView, true);
				PopUpManager.centerPopUp(_progressPopUp);
				
				dispatch(event.clone());
			}
		}
		
		private function onHelpButtonClick(event:MouseEvent):void
		{
			dispatch(new ShowHelpEvent());
		}
	}
}
