package flashplayerswitcher.view
{
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
			trace("prefs window mediator");
			view.allowEditing = true;
		}
	}
}
