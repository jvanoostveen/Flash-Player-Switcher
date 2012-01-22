package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.DeletePluginsEvent;
	import flashplayerswitcher.model.StateModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.service.IFlashplayersService;

	import org.robotlegs.mvcs.Command;

	import mx.controls.Alert;
	import mx.events.CloseEvent;

	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DeletePluginsCommand extends Command
	{
		[Inject] public var event:DeletePluginsEvent;
		[Inject] public var service:IFlashplayersService;
		[Inject] public var state:StateModel;
		
		override public function execute():void
		{
			commandMap.detain(this);
			state.alert = Alert.show(resource("DELETE_PLUGIN_ALERT"), resource("DELETE_PLUGIN"), Alert.CANCEL | Alert.OK, null, onAlertConfirm);
			state.alert.addEventListener(Event.REMOVED_FROM_STAGE, onAlertRemoved);
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
		}

		private function onAlertRemoved(event:Event):void
		{
			commandMap.release(this);
			
			var alert:Alert = event.currentTarget as Alert;
			alert.removeEventListener(Event.CLOSE, onAlertConfirm);
			alert.removeEventListener(Event.REMOVED_FROM_STAGE, onAlertRemoved);
		}
	}
}
