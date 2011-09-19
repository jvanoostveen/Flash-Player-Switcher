package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.BundlesUpdatedEvent;
	import flashplayerswitcher.controller.events.CopySystemPluginEvent;
	import flashplayerswitcher.controller.events.InstalledBundleUpdatedEvent;
	import flashplayerswitcher.controller.events.RemoveUserPluginEvent;

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
			addContextListener(BundlesUpdatedEvent.UPDATED, knownBundlesUpdated);
			
			addViewListener(RemoveUserPluginEvent.REMOVE, dispatch);
			addViewListener(CopySystemPluginEvent.COPY, dispatch);
		}
		
		private function knownBundlesUpdated(event:BundlesUpdatedEvent):void
		{
			// check if copy system bundle button should be visible
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
				view.userInstalledVersion.text = event.bundle.name + " (" + event.bundle.version + ")";
			else
				view.userInstalledVersion.text = "<none>";
			
			view.removeUserPluginButton.visible = (event.bundle ? true : false);
		}
	}
}
