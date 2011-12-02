package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StorageAllowEditingChangedEvent extends Event
	{
		public static const CHANGED:String = "StorageAllowEditingChanged.CHANGED";
		
		public var allowEditing:Boolean;
		
		public function StorageAllowEditingChangedEvent(allowEditing:Boolean)
		{
			super(CHANGED);
			
			this.allowEditing = allowEditing;
		}
	}
}
