package flashplayerswitcher.controller.events
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CopyPluginToStorageEvent extends Event
	{
		public static const COPY_PLUGIN_TO_STORAGE:String = "copy_plugin_to_storage";
		
		public var plugin:FlashPlayerPlugin;
		
		public function CopyPluginToStorageEvent(plugin:FlashPlayerPlugin)
		{
			super(COPY_PLUGIN_TO_STORAGE);
			
			this.plugin = plugin;
		}
	}
}
