package flashplayerswitcher.view
{
	import flashplayerswitcher.view.preferences.StoragePreferencesMediator;
	import flashplayerswitcher.view.preferences.StoragePreferencesPanel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PreferencesWindowMediator extends Mediator
	{
		[Inject]
		public var view:PreferencesWindow;

		override public function onRegister():void
		{
			if (!mediatorMap.hasMapping(StoragePreferencesPanel))
				mediatorMap.mapView(StoragePreferencesPanel, StoragePreferencesMediator);
			mediatorMap.createMediator(view.storage);
		}

		override public function onRemove():void
		{
			mediatorMap.removeMediatorByView(view.storage);
		}
	}
}
