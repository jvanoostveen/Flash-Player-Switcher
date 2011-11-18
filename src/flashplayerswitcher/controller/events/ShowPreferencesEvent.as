package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ShowPreferencesEvent extends Event
	{
		public static const SHOW:String = "showpreferences";
		
		public function ShowPreferencesEvent()
		{
			super(SHOW);
		}

		override public function clone():Event
		{
			return new ShowPreferencesEvent();
		}
	}
}
