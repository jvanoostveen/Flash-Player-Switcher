package flashplayerswitcher.controller.events
{
	import flashplayerswitcher.model.vo.PluginSet;

	import flash.events.Event;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class StorePluginSetEvent extends Event
	{
		public static const STORE_PLUGINSET:String = "store_pluginset";
		
		public var pluginSet:PluginSet;
		
		public function StorePluginSetEvent(pluginSet:PluginSet)
		{
			super(STORE_PLUGINSET);
			
			this.pluginSet = pluginSet;
		}
		
		override public function clone():Event
		{
			return new StorePluginSetEvent(pluginSet);
		}
	}
}
