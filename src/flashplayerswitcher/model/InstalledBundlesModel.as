package flashplayerswitcher.model
{
	import flashplayerswitcher.controller.events.BundlesUpdatedEvent;
	import flashplayerswitcher.controller.events.InstalledBundleUpdatedEvent;
	import flashplayerswitcher.model.vo.FlashPlayerBundle;

	import org.robotlegs.mvcs.Actor;

	import mx.collections.ArrayCollection;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InstalledBundlesModel extends Actor
	{
		private var _system:FlashPlayerBundle;
		private var _user:FlashPlayerBundle;
		
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
