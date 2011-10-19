package flashplayerswitcher.service
{
	import flash.display.DisplayObject;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public interface ITrackerService
	{
		function init(display:DisplayObject):void;
		function track(pageURL:String):void;
	}
}
