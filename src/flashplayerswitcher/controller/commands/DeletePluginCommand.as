package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.DeletePluginEvent;
	import flashplayerswitcher.service.IFlashplayersService;

	import org.robotlegs.mvcs.Command;

	import mx.controls.Alert;
	import mx.events.CloseEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DeletePluginCommand extends Command
	{
		[Inject]
		public var event:DeletePluginEvent;
		
		[Inject]
		public var service:IFlashplayersService;
		
		override public function execute():void
		{
			commandMap.detain(this);
			Alert.show("This will delete the plugin from the storage.", "Delete plugin", Alert.CANCEL | Alert.OK, null, onAlertConfirm);
		}
		
		private function onAlertConfirm(evt:CloseEvent):void
		{
			if (evt.detail == Alert.OK)
			{
				service.deletePlugin(event.plugin);
				event.plugin.remove();
			}
			commandMap.release(this);
		}
	}
}
