package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ShowPluginStorageListEvent extends Event
	{
		public static const SHOW:String = "show_plugin_storage";
		
		public function ShowPluginStorageListEvent()
		{
			super(SHOW);
		}

		override public function clone():Event
		{
			return new ShowPluginStorageListEvent();
		}

	}
}
