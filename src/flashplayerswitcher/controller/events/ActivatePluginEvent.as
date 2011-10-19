package flashplayerswitcher.controller.events
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ActivatePluginEvent extends Event
	{
		public static const ACTIVATE:String = "activate_plugin";
		
		public var plugin:FlashPlayerPlugin;
		
		public function ActivatePluginEvent(plugin:FlashPlayerPlugin)
		{
			super(ACTIVATE);
			
			this.plugin = plugin;
		}

		override public function clone():Event
		{
			return new ActivatePluginEvent(plugin);
		}
	}
}
