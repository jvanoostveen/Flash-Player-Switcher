package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CopySystemPluginEvent extends Event
	{
		public static const COPY:String = "copy";
		
		public function CopySystemPluginEvent()
		{
			super(COPY);
		}

		override public function clone():Event
		{
			return new CopySystemPluginEvent();
		}

	}
}
