package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DownloadListDataErrorEvent extends Event
	{
		public static const ERROR:String = "download_list_data_error";
		
		public var message:String;
		
		public function DownloadListDataErrorEvent(message:String)
		{
			super(ERROR);
			
			this.message = message;
		}
	}
}
