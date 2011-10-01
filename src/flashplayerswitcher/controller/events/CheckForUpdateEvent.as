package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CheckForUpdateEvent extends Event
	{
		public static const CHECK_FOR_UPDATE:String = "check_for_update";
		
		public function CheckForUpdateEvent()
		{
			super(CHECK_FOR_UPDATE);
		}
	}
}
