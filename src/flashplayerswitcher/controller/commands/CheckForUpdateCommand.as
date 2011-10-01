package flashplayerswitcher.controller.commands
{
	import air.update.events.StatusUpdateEvent;
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;

	import org.robotlegs.mvcs.Command;

	import flash.events.ErrorEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CheckForUpdateCommand extends Command
	{
		private var _appUpdater:ApplicationUpdaterUI;
		
		override public function execute():void
		{
			commandMap.detain(this);
			
			_appUpdater = new ApplicationUpdaterUI();
			_appUpdater.updateURL = "https://raw.github.com/jvanoostveen/Flash-Player-Switcher/master/release/update.xml";
			_appUpdater.isCheckForUpdateVisible = false;
			_appUpdater.addEventListener(UpdateEvent.INITIALIZED, onInitialized);
			_appUpdater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, onStatus);
			_appUpdater.addEventListener(ErrorEvent.ERROR, onError);
			_appUpdater.initialize();
		}
		
		private function onInitialized(event:UpdateEvent):void
		{
			_appUpdater.checkNow();
		}
		
		private function onStatus(event:StatusUpdateEvent):void
		{
			clear();
			
			commandMap.release(this);
		}
		
		private function onError(event:ErrorEvent):void
		{
			trace("error: " + event.text);
		}

		private function clear():void
		{
			_appUpdater.removeEventListener(UpdateEvent.INITIALIZED, onInitialized);
			_appUpdater.removeEventListener(StatusUpdateEvent.UPDATE_STATUS, onStatus);
			_appUpdater.removeEventListener(ErrorEvent.ERROR, onError);
			
			_appUpdater = null;
		}
	}
}
