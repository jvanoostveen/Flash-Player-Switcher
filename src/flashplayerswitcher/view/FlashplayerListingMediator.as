package flashplayerswitcher.view
{
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class FlashplayerListingMediator extends Mediator
	{
		[Inject]
		public var view:FlashplayerListing;

		override public function onRegister():void
		{
//			addContextListener(type, listener, eventClass, useCapture, priority, useWeakReference)
		}
	}
}
