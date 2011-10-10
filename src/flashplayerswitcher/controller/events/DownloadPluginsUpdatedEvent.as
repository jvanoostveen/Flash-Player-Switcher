package flashplayerswitcher.controller.events
{
	import mx.collections.ArrayCollection;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DownloadPluginsUpdatedEvent extends Event
	{
		public static const UPDATED:String = "download_plugins_updated";
		
		public var plugins:ArrayCollection;
		
		public function DownloadPluginsUpdatedEvent(plugins:ArrayCollection)
		{
			super(UPDATED);
			
			this.plugins = plugins;
		}
	}
}
