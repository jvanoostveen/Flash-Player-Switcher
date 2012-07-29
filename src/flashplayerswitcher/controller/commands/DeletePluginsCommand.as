package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.DeletePluginsEvent;
	import flashplayerswitcher.locale.Locale;
	import flashplayerswitcher.model.StateModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.service.IFlashplayersService;
	import flashplayerswitcher.service.growl.IGrowlService;
	import flashplayerswitcher.service.growl.NotificationName;

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
		[Inject] public var growl:IGrowlService;
		
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
					service.deletePluginSetForVersion(plugin.version);
					plugin.remove();
				}
				
				growl.notify(NotificationName.PLUGIN_DELETED, resource("PLUGIN_DELETED_NOTIFICATION_TITLE", Locale.GROWL), resource("PLUGIN_DELETED_NOTITICATION_MESSAGE", Locale.GROWL));
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
