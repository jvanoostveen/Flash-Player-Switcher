package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.InstalledBundlesModel;
	import flashplayerswitcher.model.vo.FlashPlayerBundle;

	import org.robotlegs.mvcs.Command;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class CheckInstalledSystemBundleVersionCommand extends Command
	{
		[Inject]
		public var installedBundlesModel:InstalledBundlesModel;
		
		override public function execute():void
		{
			try
			{
				var plugin:File = File.getRootDirectories()[0];
				plugin = plugin.resolvePath("Library/Internet Plug-Ins/Flash Player.plugin");
				
				if (plugin.exists)
				{
					var bundle:FlashPlayerBundle = new FlashPlayerBundle();
					bundle.parse(plugin);
					
					installedBundlesModel.system = bundle;
				} else {
					installedBundlesModel.system = null;
				}
			} catch (e:Error)
			{
				installedBundlesModel.system = null;
			}
		}
	}
}
