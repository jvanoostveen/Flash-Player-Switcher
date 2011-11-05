package flashplayerswitcher.service
{
	import flashplayerswitcher.service.ITrackerService;

	import flash.display.DisplayObject;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DummyTrackerService implements ITrackerService
	{
		public function init(display:DisplayObject):void
		{
		}

		public function track(pageURL:String):void
		{
			trace("Track: " + pageURL);
		}
	}
}
