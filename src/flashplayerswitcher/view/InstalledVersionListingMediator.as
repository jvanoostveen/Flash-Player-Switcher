package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.InstalledBundleUpdatedEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class InstalledVersionListingMediator extends Mediator
	{
		[Inject]
		public var view:InstalledVersionListing;

		override public function onRegister():void
		{
			addContextListener(InstalledBundleUpdatedEvent.SYSTEM, systemBundleUpdated);
			addContextListener(InstalledBundleUpdatedEvent.USER, userBundleUpdated);
		}
		
		private function systemBundleUpdated(event:InstalledBundleUpdatedEvent):void
		{
			if (event.bundle)
				view.systemInstalledVersion.text = event.bundle.name + " (" + event.bundle.version + ")";
			else
				view.systemInstalledVersion.text = "<none>";
		}
		
		private function userBundleUpdated(event:InstalledBundleUpdatedEvent):void
		{
			if (event.bundle)
			{
				view.userInstalledVersion.text = event.bundle.name + " (" + event.bundle.version + ")";
			} else {
				view.userInstalledVersion.text = "<none>";
			}
		}
	}
}
