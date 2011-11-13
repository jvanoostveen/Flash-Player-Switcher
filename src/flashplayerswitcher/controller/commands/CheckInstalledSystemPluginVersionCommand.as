package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.values.InternetPlugins;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import org.robotlegs.mvcs.Command;


	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class CheckInstalledSystemPluginVersionCommand extends Command
	{
		[Inject]
		public var installedPluginsModel:PluginsModel;
		
		[Inject]
		public var pluginLocations:InternetPlugins;
		
		override public function execute():void
		{
			try
			{
				var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
				plugin.search(pluginLocations.system);
				if (plugin.exists)
				{
					installedPluginsModel.system = plugin;
				} else {
					installedPluginsModel.system = null;
				}
			} catch (e:Error)
			{
				installedPluginsModel.system = null;
			}
		}
	}
}
