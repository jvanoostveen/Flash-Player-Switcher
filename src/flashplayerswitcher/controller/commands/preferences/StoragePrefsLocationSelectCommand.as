package flashplayerswitcher.controller.commands.preferences
{
	import flashplayerswitcher.controller.events.preferences.StoragePrefsLocationSelectEvent;
	import flashplayerswitcher.service.IConfigService;

	import org.robotlegs.mvcs.Command;

	import flash.events.Event;
	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StoragePrefsLocationSelectCommand extends Command
	{
		[Inject]
		public var event:StoragePrefsLocationSelectEvent;
		
		[Inject]
		public var config:IConfigService;
		
		private var _browse:File;
		
		override public function execute():void
		{
			if (!event.directory)
			{
				commandMap.detain(this);
				
				_browse = new File();
				_browse.browseForDirectory("Please select a directory...");
				_browse.addEventListener(Event.SELECT, onDirectorySelected);
				_browse.addEventListener(Event.CANCEL, onDirectoryCancel);
			} else {
				config.saveStorageDirectory(event.directory);
			}
		}

		private function onDirectorySelected(event:Event):void
		{
			config.saveStorageDirectory(_browse);
			
			clean();
		}
		
		private function onDirectoryCancel(event:Event):void
		{
			// set selected index of storage preferences dropdown back to previous index
			dispatch(new StoragePrefsLocationSelectEvent(StoragePrefsLocationSelectEvent.CANCEL));
			
			clean();
		}

		private function clean():void
		{
			_browse.removeEventListener(Event.SELECT, onDirectorySelected);
			_browse.removeEventListener(Event.CANCEL, onDirectoryCancel);
			_browse = null;
			
			commandMap.release(this);
		}
	}
}
