package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginStoredEvent extends Event
	{
		public static const STORED:String = "plugin_stored";
		
		public function PluginStoredEvent()
		{
			super(STORED);
		}

		override public function clone():Event
		{
			return new PluginStoredEvent();
		}
	}
}
