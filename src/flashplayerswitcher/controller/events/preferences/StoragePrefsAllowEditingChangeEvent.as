package flashplayerswitcher.controller.events.preferences
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StoragePrefsAllowEditingChangeEvent extends Event
	{
		public static const CHANGE:String = "StoragePrefsAllowEditingChange.CHANGE";
		
		public var allowEditing:Boolean;
		
		public function StoragePrefsAllowEditingChangeEvent(allowEditing:Boolean)
		{
			super(CHANGE);
			
			this.allowEditing = allowEditing;
		}

		override public function clone():Event
		{
			return new StoragePrefsAllowEditingChangeEvent(allowEditing);
		}
	}
}
