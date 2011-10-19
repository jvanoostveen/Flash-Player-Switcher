package flashplayerswitcher.service
{
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;

	import flash.display.DisplayObject;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class GoogleAnalyticsTrackerService implements ITrackerService
	{
		private var _tracker:AnalyticsTracker;

		public function init(display:DisplayObject):void
		{
			// FIXME: move account id to config
			_tracker = new GATracker(display, "UA-26342584-3", "AS3");
		}

		public function track(pageURL:String):void
		{
			_tracker.trackPageview(pageURL);
		}
	}
}
