package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckInstalledBundleVersionEvent;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class RemoveUserPluginCommand extends Command
	{
		override public function execute():void
		{
			var plugin:File = File.userDirectory.resolvePath("Library/Internet Plug-Ins/Flash Player.plugin");
			if (plugin.exists)
				plugin.deleteDirectory(true);
			
			var xpt:File = File.userDirectory.resolvePath("Library/Internet Plug-Ins/flashplayer.xpt");
			if (xpt.exists)
				xpt.deleteFile();
			
			dispatch(new CheckInstalledBundleVersionEvent(CheckInstalledBundleVersionEvent.USER));
		}
	}
}
