package flashplayerswitcher.model
{
	import org.robotlegs.mvcs.Actor;

	import mx.controls.Alert;
	import mx.managers.PopUpManager;

	import flash.events.Event;

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
				_alert.addEventListener(Event.REMOVED_FROM_STAGE, onAlertRemoved, false, -10);
		}

		private function onAlertRemoved(event:Event):void
		{
			var alert:Alert = event.currentTarget as Alert;
			alert.removeEventListener(event.type, onAlertRemoved);
			
			if (alert == _alert)
				_alert = null;
		}
	}
}
