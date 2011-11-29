package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ConfigReadyEvent extends Event
	{
		public static const READY:String = "ConfigReady";
		
		public function ConfigReadyEvent()
		{
			super(READY);
		}

		override public function clone():Event
		{
			return new ConfigReadyEvent();
		}
	}
}
