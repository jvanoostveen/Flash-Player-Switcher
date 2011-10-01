package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CopyPluginToStorageEvent extends Event
	{
		public static const COPY_PLUGIN_TO_STORAGE:String = "copy_plugin_to_storage";
		
		public function CopyPluginToStorageEvent()
		{
			super(COPY_PLUGIN_TO_STORAGE);
		}
	}
}
