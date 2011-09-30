package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.InstalledBundlesModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.InternetPlugins;

	import org.robotlegs.mvcs.Command;

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
				var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
				plugin.search(InternetPlugins.SYSTEM);
				if (plugin.exists)
				{
					installedBundlesModel.system = plugin;
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
