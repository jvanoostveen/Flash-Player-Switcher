package flashplayerswitcher.model
{
	import flashplayerswitcher.controller.events.BundlesUpdatedEvent;
	import flashplayerswitcher.controller.events.InstalledBundleUpdatedEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import org.robotlegs.mvcs.Actor;

	import mx.collections.ArrayCollection;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InstalledBundlesModel extends Actor
	{
		private var _system:FlashPlayerPlugin;
		private var _user:FlashPlayerPlugin;
		
		private var _bundles:ArrayCollection;
		
		public function set bundles(value:ArrayCollection):void
		{
			_bundles = value;
			dispatch(new BundlesUpdatedEvent(BundlesUpdatedEvent.UPDATED, _bundles));
		}
		
		public function get bundles():ArrayCollection
		{
			return _bundles ||= new ArrayCollection();
		}
		
		public function get system():FlashPlayerPlugin
		{
			return _system;
		}

		public function set system(bundle:FlashPlayerPlugin):void
		{
			_system = bundle;
			
			dispatch(new InstalledBundleUpdatedEvent(InstalledBundleUpdatedEvent.SYSTEM, _system));
		}
		
		public function get user():FlashPlayerPlugin
		{
			return _user;
		}

		public function set user(bundle:FlashPlayerPlugin):void
		{
			_user = bundle;
			
			dispatch(new InstalledBundleUpdatedEvent(InstalledBundleUpdatedEvent.USER, _user));
		}
	}
}
