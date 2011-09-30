package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class LoadPluginsEvent extends Event
	{
		public static const LOAD_PLUGINS:String = "load_plugins";
		
		public function LoadPluginsEvent()
		{
			super(LOAD_PLUGINS);
		}
	}
}
