package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.BundlesUpdatedEvent;
	import flashplayerswitcher.controller.events.CopySystemPluginEvent;
	import flashplayerswitcher.controller.events.InstalledPluginUpdatedEvent;
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
			addContextListener(InstalledPluginUpdatedEvent.SYSTEM, systemPluginUpdated);
			addContextListener(InstalledPluginUpdatedEvent.USER, userPluginUpdated);
			addContextListener(BundlesUpdatedEvent.UPDATED, knownPluginsUpdated);
			
			addViewListener(RemoveUserPluginEvent.REMOVE, dispatch);
			addViewListener(CopySystemPluginEvent.COPY, dispatch);
		}
		
		private function knownPluginsUpdated(event:BundlesUpdatedEvent):void
		{
			// check if copy system plugin button should be visible
		}
		
		private function systemPluginUpdated(event:InstalledPluginUpdatedEvent):void
		{
			if (event.plugin)
				view.systemInstalledVersion.text = event.plugin.name + " (" + event.plugin.version + ")";
			else
				view.systemInstalledVersion.text = "<none>";
			
		}
		
		private function userPluginUpdated(event:InstalledPluginUpdatedEvent):void
		{
			if (event.plugin)
				view.userInstalledVersion.text = event.plugin.name + " (" + event.plugin.version + ")";
			else
				view.userInstalledVersion.text = "<none>";
			
			view.removeUserPluginButton.visible = (event.plugin ? true : false);
		}
	}
}
