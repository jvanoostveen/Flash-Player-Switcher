package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.controller.events.InstalledPluginUpdatedEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.controller.events.RemoveUserPluginEvent;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.InternetPlugins;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.MouseEvent;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InstalledVersionListingMediator extends Mediator
	{
		[Inject]
		public var view:InstalledVersionListing;
		
		[Inject]
		public var plugins:PluginsModel;

		override public function onRegister():void
		{
			addContextListener(InstalledPluginUpdatedEvent.SYSTEM, systemPluginUpdated);
			addContextListener(InstalledPluginUpdatedEvent.USER, userPluginUpdated);
			addContextListener(PluginsUpdatedEvent.UPDATED, knownPluginsUpdated);
			
			eventMap.mapListener(view.copySystemPluginButton, MouseEvent.CLICK, onCopyPluginClick);
			addViewListener(RemoveUserPluginEvent.REMOVE, dispatch);
		}
		
		private function knownPluginsUpdated(event:PluginsUpdatedEvent):void
		{
			// check if copy system plugin button should be visible
			checkSystemPluginInstall();
		}

		private function checkSystemPluginInstall():void
		{
			view.copySystemPluginButton.visible = false;
			if (plugins.system && !plugins.contains(plugins.system))
			{
				view.copySystemPluginButton.visible = true;
			}
		}
		
		private function systemPluginUpdated(event:InstalledPluginUpdatedEvent):void
		{
			if (event.plugin)
				view.systemInstalledVersion.text = event.plugin.name + " (" + event.plugin.version + ")";
			else
				view.systemInstalledVersion.text = "<none>";
			
			checkSystemPluginInstall();
		}
		
		private function userPluginUpdated(event:InstalledPluginUpdatedEvent):void
		{
			if (event.plugin)
				view.userInstalledVersion.text = event.plugin.name + " (" + event.plugin.version + ")";
			else
				view.userInstalledVersion.text = "<none>";
			
			view.removeUserPluginButton.visible = (event.plugin ? true : false);
		}
		
		private function onCopyPluginClick(event:MouseEvent):void
		{
			var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
			plugin.search(InternetPlugins.SYSTEM);
			
			dispatch(new CopyPluginToStorageEvent(plugin));
		}
	}
}
