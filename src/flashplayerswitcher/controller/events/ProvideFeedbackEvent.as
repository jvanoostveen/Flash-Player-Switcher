package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ProvideFeedbackEvent extends Event
	{
		public static const PROVIDE_FEEDBACK:String = "provide_feedback";
		
		public function ProvideFeedbackEvent()
		{
			super(PROVIDE_FEEDBACK);
		}

		override public function clone():Event
		{
			return new ProvideFeedbackEvent();
		}
	}
}
