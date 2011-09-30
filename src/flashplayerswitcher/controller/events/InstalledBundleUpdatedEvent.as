package flashplayerswitcher.controller.events
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class InstalledBundleUpdatedEvent extends Event
	{
		public static const SYSTEM:String = "InstalledBundleUpdatedEvent.SYSTEM";
		public static const USER:String = "InstalledBundleUpdatedEvent.USER";
		
		public var bundle:FlashPlayerPlugin;
		
		public function InstalledBundleUpdatedEvent(type:String, bundle:FlashPlayerPlugin)
		{
			super(type);
			
			this.bundle = bundle;
		}
	}
}
