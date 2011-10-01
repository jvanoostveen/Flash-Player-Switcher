package flashplayerswitcher.controller.events
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InstallPluginEvent extends Event
	{
		public static const INSTALL:String = "install_plugin";
		
		public var plugin:FlashPlayerPlugin;
		
		public function InstallPluginEvent(plugin:FlashPlayerPlugin)
		{
			super(INSTALL);
			
			this.plugin = plugin;
		}

		override public function clone():Event
		{
			return new InstallPluginEvent(plugin);
		}
	}
}
