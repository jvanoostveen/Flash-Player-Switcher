package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.values.InternetPlugins;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import org.robotlegs.mvcs.Command;


	/**
	 * @author Joeri van Oostveen
	 */
	public class CheckInstalledUserPluginVersionCommand extends Command
	{
		[Inject]
		public var installedPlugins:PluginsModel;
		
		[Inject]
		public var pluginLocations:InternetPlugins;
		
		override public function execute():void
		{
			try
			{
				var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
				plugin.search(pluginLocations.user);
				if (plugin.exists)
				{
					installedPlugins.user = plugin;
				} else {
					installedPlugins.user = null;
				}
			} catch (e:Error)
			{
				installedPlugins.user = null;
			}
		}
	}
}
