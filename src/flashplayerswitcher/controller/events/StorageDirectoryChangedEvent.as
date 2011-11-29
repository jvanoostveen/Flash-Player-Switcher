package flashplayerswitcher.controller.events
{
	import flash.events.Event;
	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StorageDirectoryChangedEvent extends Event
	{
		public static const CHANGED:String = "storage_directory_changed";
		
		public var oldLocation:File;
		public var newLocation:File;
		
		public function StorageDirectoryChangedEvent(oldLocation:File, newLocation:File)
		{
			super(CHANGED);
			
			this.oldLocation = oldLocation;
			this.newLocation = newLocation;
		}

		override public function clone():Event
		{
			return new StorageDirectoryChangedEvent(oldLocation, newLocation);
		}
	}
}
