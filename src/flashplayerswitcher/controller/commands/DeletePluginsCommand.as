package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.controller.events.DeletePluginsEvent;
	import flashplayerswitcher.service.IFlashplayersService;

	import org.robotlegs.mvcs.Command;

	import mx.controls.Alert;
	import mx.events.CloseEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DeletePluginsCommand extends Command
	{
		[Inject]
		public var event:DeletePluginsEvent;
		
		[Inject]
		public var service:IFlashplayersService;
		
		override public function execute():void
		{
			commandMap.detain(this);
			Alert.show(resource("DELETE_PLUGIN_ALERT"), resource("DELETE_PLUGIN"), Alert.CANCEL | Alert.OK, null, onAlertConfirm);
		}
		
		private function onAlertConfirm(evt:CloseEvent):void
		{
			if (evt.detail == Alert.OK)
			{
				for each (var plugin:FlashPlayerPlugin in event.plugins)
				{
					service.deletePlugin(plugin);
					plugin.remove();
				}
			}
			commandMap.release(this);
		}
	}
}
