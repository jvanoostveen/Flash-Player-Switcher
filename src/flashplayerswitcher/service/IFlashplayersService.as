package flashplayerswitcher.service
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.PluginSet;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public interface IFlashplayersService
	{
		function loadPlugins():void;
		function storePlugin(plugin:FlashPlayerPlugin):void;
		function deletePlugin(plugin:FlashPlayerPlugin):void;
		function loadPluginSets():void;
		function storePluginSet(pluginSet:PluginSet):void;
		function deletePluginSet(pluginSet:PluginSet):void;
		function deletePluginSetForVersion(version:String):void;
	}
}
