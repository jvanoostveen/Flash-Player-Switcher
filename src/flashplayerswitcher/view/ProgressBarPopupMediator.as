package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ProgressBarPopupEvent;

	import org.robotlegs.mvcs.Mediator;

	import mx.controls.ProgressBarMode;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ProgressBarPopupMediator extends Mediator
	{
		[Inject]
		public var view:ProgressBarPopup;
		
		override public function onRegister():void
		{
			addContextListener(ProgressBarPopupEvent.SHOW, onShow, ProgressBarPopupEvent);
			addContextListener(ProgressBarPopupEvent.UPDATE, onUpdate, ProgressBarPopupEvent);
			addContextListener(ProgressBarPopupEvent.HIDE, onHide, ProgressBarPopupEvent);
		}
		
		private function onShow(event:ProgressBarPopupEvent):void
		{
			view.visible = true;
			
			view.progressbar.label = event.label;
			view.progressbar.indeterminate = event.indeterminate;
			view.progressbar.mode = ProgressBarMode.EVENT;
			view.progressbar.setProgress(event.value, event.total);
		}
		
		private function onUpdate(event:ProgressBarPopupEvent):void
		{
			view.progressbar.label = event.label;
			view.progressbar.mode = ProgressBarMode.MANUAL;
			view.progressbar.setProgress(event.value, event.total);
		}
		
		private function onHide(event:ProgressBarPopupEvent):void
		{
			view.visible = false;
		}
	}
}
