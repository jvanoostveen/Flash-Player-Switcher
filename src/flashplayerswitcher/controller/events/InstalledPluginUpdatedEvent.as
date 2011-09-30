package flashplayerswitcher.controller.events
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InstalledPluginUpdatedEvent extends Event
	{
		public static const SYSTEM:String = "InstalledPluginUpdatedEvent.SYSTEM";
		public static const USER:String = "InstalledPluginUpdatedEvent.USER";
		
		public var plugin:FlashPlayerPlugin;
		
		public function InstalledPluginUpdatedEvent(type:String, plugin:FlashPlayerPlugin)
		{
			super(type);
			
			this.plugin = plugin;
		}
	}
}
