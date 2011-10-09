package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ShowPluginDownloadListEvent extends Event
	{
		public static const SHOW:String = "show_downloadable_plugins";
		
		public function ShowPluginDownloadListEvent()
		{
			super(SHOW);
		}

		override public function clone():Event
		{
			return new ShowPluginDownloadListEvent();
		}
	}
}
