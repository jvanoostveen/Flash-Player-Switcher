package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ApplicationActivateEvent extends Event
	{
		public static const ACTIVATE:String = "application_activate";
		
		public function ApplicationActivateEvent()
		{
			super(ACTIVATE);
		}

		override public function clone():Event
		{
			return new ApplicationActivateEvent();
		}
	}
}
