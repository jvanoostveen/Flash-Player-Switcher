package flashplayerswitcher.controller.events
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginsUpdatedEvent extends Event
	{
		public static const UPDATED:String = "BundlesUpdatedEvent.UPDATED";
		
		public var bundles:ArrayCollection;
		
		public function PluginsUpdatedEvent(type:String, bundles:ArrayCollection)
		{
			super(type);
			
			this.bundles = bundles;
		}
	}
}
