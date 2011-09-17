package flashplayerswitcher.model
{
	import flashplayerswitcher.controller.events.InstalledBundleUpdatedEvent;
	import flashplayerswitcher.model.vo.FlashPlayerBundle;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InstalledBundlesModel extends Actor
	{
		private var _system:FlashPlayerBundle;
		private var _user:FlashPlayerBundle;
		
		public function get system():FlashPlayerBundle
		{
			return _system;
		}

		public function set system(bundle:FlashPlayerBundle):void
		{
			_system = bundle;
			
			dispatch(new InstalledBundleUpdatedEvent(InstalledBundleUpdatedEvent.SYSTEM, _system));
		}
		
		public function get user():FlashPlayerBundle
		{
			return _user;
		}

		public function set user(bundle:FlashPlayerBundle):void
		{
			_user = bundle;
			
			dispatch(new InstalledBundleUpdatedEvent(InstalledBundleUpdatedEvent.USER, _user));
		}
	}
}
