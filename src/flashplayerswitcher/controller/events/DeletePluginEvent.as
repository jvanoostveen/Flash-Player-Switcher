package flashplayerswitcher.controller.events
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DeletePluginEvent extends Event
	{
		public static const DELETE:String = "DeletePluginEvent.DELETE";
		
		public var plugin:FlashPlayerPlugin;
		
		public function DeletePluginEvent(plugin:FlashPlayerPlugin)
		{
			super(DELETE);
			
			this.plugin = plugin;
		}

		override public function clone():Event
		{
			return new DeletePluginEvent(plugin);
		}
	}
}
