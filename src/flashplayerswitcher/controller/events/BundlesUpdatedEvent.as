package flashplayerswitcher.controller.events
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class BundlesUpdatedEvent extends Event
	{
		public static const UPDATED:String = "BundlesUpdatedEvent.UPDATED";
		
		public var bundles:ArrayCollection;
		
		public function BundlesUpdatedEvent(type:String, bundles:ArrayCollection)
		{
			super(type);
			
			this.bundles = bundles;
		}
	}
}
