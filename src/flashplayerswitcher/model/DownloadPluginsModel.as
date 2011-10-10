package flashplayerswitcher.model
{
	import flashplayerswitcher.controller.events.DownloadPluginsUpdatedEvent;

	import org.robotlegs.mvcs.Actor;

	import mx.collections.ArrayCollection;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DownloadPluginsModel extends Actor
	{
		private var _plugins:ArrayCollection;

		public function get plugins():ArrayCollection
		{
			return _plugins ||= new ArrayCollection();
		}

		public function set plugins(value:ArrayCollection):void
		{
			_plugins = value;
			
			dispatch(new DownloadPluginsUpdatedEvent(_plugins));
		}
	}
}
