package flashplayerswitcher.controller.commands
{
	import org.robotlegs.mvcs.Command;

	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ProvideFeedbackCommand extends Command
	{
		override public function execute():void
		{
			navigateToURL(new URLRequest("https://github.com/jvanoostveen/Flash-Player-Switcher/issues/new"), "_blank");
		}
	}
}
