package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.InstalledBundlesModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.InternetPlugins;

	import org.robotlegs.mvcs.Command;

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
				var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
				plugin.search(InternetPlugins.USER);
				if (plugin.exists)
				{
					installedBundlesModel.user = plugin;
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
