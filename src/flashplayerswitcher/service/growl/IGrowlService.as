package flashplayerswitcher.service.growl
{
	/**
	 * @author Joeri van Oostveen
	 */
	public interface IGrowlService
	{
		function register():void;
		function notify(type:String, title:String, text:String):void;
	}
}
