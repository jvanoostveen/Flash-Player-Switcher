package flashplayerswitcher.service
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public interface IFlashplayersService
	{
		function loadPlugins():void;
		function storePlugin(plugin:FlashPlayerPlugin):void;
		function deletePlugin(plugin:FlashPlayerPlugin):void;
	}
}
