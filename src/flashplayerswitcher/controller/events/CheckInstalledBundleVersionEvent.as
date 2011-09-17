package flashplayerswitcher.controller.events
{
	import flash.events.Event;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class CheckInstalledBundleVersionEvent extends Event
	{
		public static const SYSTEM:String = "CheckInstalledBundleVersionEvent.SYSTEM";
		public static const USER:String = "CheckInstalledBundleVersionEvent.USER";
		
		public function CheckInstalledBundleVersionEvent(type:String)
		{
			super(type);
		}

	}
}
