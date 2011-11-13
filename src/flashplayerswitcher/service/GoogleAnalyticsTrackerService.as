package flashplayerswitcher.service
{
	import flashplayerswitcher.model.values.GoogleAnalyticsAccount;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;

	import flash.display.DisplayObject;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class GoogleAnalyticsTrackerService implements ITrackerService
	{
		private var _tracker:AnalyticsTracker;
		
		[Inject]
		public var account:GoogleAnalyticsAccount;
		
		public function init(display:DisplayObject):void
		{
			// FIXME: move account id to config
			_tracker = new GATracker(display, account.toString(), "AS3");
		}

		public function track(pageURL:String):void
		{
			_tracker.trackPageview(pageURL);
		}
	}
}
