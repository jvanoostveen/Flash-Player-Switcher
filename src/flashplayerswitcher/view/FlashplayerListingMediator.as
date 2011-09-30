package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.model.PluginsModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Joeri van Oostveen
	 */
	public class FlashplayerListingMediator extends Mediator
	{
		[Inject]
		public var view:FlashplayerListing;

		[Inject]
		public var installed:PluginsModel;

		override public function onRegister():void
		{
			addContextListener(PluginsUpdatedEvent.UPDATED, onPluginsUpdated, PluginsUpdatedEvent);
		}
		
		private function onPluginsUpdated(event:PluginsUpdatedEvent):void
		{
			trace("plugins updated");
			trace(installed.plugins);
			
			view.listing.dataProvider = installed.plugins;
		}
	}
}
