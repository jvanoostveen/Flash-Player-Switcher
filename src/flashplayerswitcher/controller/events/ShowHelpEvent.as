package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ShowHelpEvent extends Event
	{
		public static const SHOW:String = "show_help";
		
		public function ShowHelpEvent()
		{
			super(SHOW);
		}

		override public function clone():Event
		{
			return new ShowHelpEvent();
		}
	}
}
