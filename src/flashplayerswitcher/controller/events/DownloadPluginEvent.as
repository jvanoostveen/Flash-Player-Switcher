package flashplayerswitcher.controller.events
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DownloadPluginEvent extends Event
	{
		public static const DOWNLOAD:String = "download_plugin";
		
		public var plugins:Vector.<FlashPlayerPlugin>;
		
		public function DownloadPluginEvent(plugins:Vector.<FlashPlayerPlugin>)
		{
			super(DOWNLOAD);
			
			this.plugins = plugins;
		}
	}
}
