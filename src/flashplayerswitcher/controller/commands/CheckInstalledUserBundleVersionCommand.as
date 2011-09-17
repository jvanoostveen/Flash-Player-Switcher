package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.InstalledBundlesModel;
	import flashplayerswitcher.model.vo.FlashPlayerBundle;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class CheckInstalledUserBundleVersionCommand extends Command
	{
		[Inject]
		public var installedBundlesModel:InstalledBundlesModel;
		
		override public function execute():void
		{
			try
			{
				var plugin:File = File.userDirectory.resolvePath("Library/Internet Plug-Ins/Flash Player.plugin");
				if (plugin.exists)
				{
					var bundle:FlashPlayerBundle = new FlashPlayerBundle();
					bundle.parse(plugin);
					
					installedBundlesModel.user = bundle;
				} else {
					installedBundlesModel.user = null;
				}
			} catch (e:Error)
			{
				installedBundlesModel.user = null;
			}
		}
	}
}
