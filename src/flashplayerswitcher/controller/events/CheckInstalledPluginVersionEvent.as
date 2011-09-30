package flashplayerswitcher.controller.events
{
	import flash.events.Event;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class CheckInstalledPluginVersionEvent extends Event
	{
		public static const SYSTEM:String = "CheckInstalledBundleVersionEvent.SYSTEM";
		public static const USER:String = "CheckInstalledBundleVersionEvent.USER";
		
		public function CheckInstalledPluginVersionEvent(type:String)
		{
			super(type);
		}

	}
}
