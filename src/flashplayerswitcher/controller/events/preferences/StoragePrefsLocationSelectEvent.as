package flashplayerswitcher.controller.events.preferences
{
	import flash.events.Event;
	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StoragePrefsLocationSelectEvent extends Event
	{
		public static const CHANGE:String = "change";
		public static const CANCEL:String = "cancel";
		
		public var directory:File;
		
		public function StoragePrefsLocationSelectEvent(type:String, directory:File = null)
		{
			super(type);
			
			this.directory = directory;
		}

		override public function clone():Event
		{
			return new StoragePrefsLocationSelectEvent(type, directory);
		}
	}
}
