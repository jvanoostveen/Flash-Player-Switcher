package flashplayerswitcher.model
{
	import org.robotlegs.mvcs.Actor;

	import mx.controls.Alert;
	import mx.managers.PopUpManager;

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StateModel extends Actor
	{
		private var _alert:Alert;

		public function get alert():Alert
		{
			return _alert;
		}

		public function set alert(alert:Alert):void
		{
			if (_alert)
				PopUpManager.removePopUp(_alert);
			
			_alert = alert;
			
			if (_alert)
				_alert.addEventListener(Event.REMOVED_FROM_STAGE, onAlertRemoved);
		}

		private function onAlertRemoved(event:Event):void
		{
			(event.currentTarget as IEventDispatcher).removeEventListener(event.type, onAlertRemoved);
			
			_alert = null;
		}
	}
}
