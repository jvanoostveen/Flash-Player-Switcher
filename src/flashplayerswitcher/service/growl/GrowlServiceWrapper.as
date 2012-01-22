package flashplayerswitcher.service.growl
{
	import flashplayerswitcher.model.values.GrowlApplication;

	import com.adobe.growl.GrowlService;
	import com.adobe.growl.Notification;
	import com.adobe.growl.NotificationType;

	import org.robotlegs.mvcs.Actor;

	import flash.events.IOErrorEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class GrowlServiceWrapper extends Actor implements IGrowlService
	{
		[Inject] public var application:GrowlApplication;
		
		private var _service:GrowlService;
		
		[PostConstruct]
		public function setup():void
		{
			_service = new GrowlService(application);
			_service.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}

		private function onIOError(event:IOErrorEvent):void
		{
			trace("IOError: " + event.text);
		}
		
		/**
		 * Register application with Growl.
		 */
		public function register():void
		{
			var pluginActivated:NotificationType = new NotificationType();
			pluginActivated.enabled = true;
			pluginActivated.name = NotificationName.PLUGIN_ACTIVATED;
			pluginActivated.displayName = "Plugin has been activated"; // for Growl preferences
			
			_service.register([pluginActivated]);
		}

		/**
		 * Send notification.
		 */
		public function notify(type:String, title:String, text:String):void
		{
			var notification:Notification = new Notification();
			notification.name = type;
			notification.title = title;
			notification.text = text;
			notification.sticky = false;
			
			_service.notify(notification);
		}
	}
}
