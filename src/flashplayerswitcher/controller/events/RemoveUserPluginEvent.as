package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class RemoveUserPluginEvent extends Event
	{
		public static const REMOVE:String = "remove";
		
		public function RemoveUserPluginEvent()
		{
			super(REMOVE);
		}

		override public function clone():Event
		{
			return new RemoveUserPluginEvent();
		}
	}
}
