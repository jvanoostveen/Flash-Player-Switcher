package flashplayerswitcher.view
{
	import org.robotlegs.mvcs.Mediator;

	import flash.display.NativeMenuItem;
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ApplicationMenuMediator extends Mediator
	{
		override public function onRegister():void
		{
			addViewListener(Event.SELECT, onMenuItemSelected);
		}
		
		private function onMenuItemSelected(event:Event):void
		{
			var item:NativeMenuItem = event.target as NativeMenuItem;
			
			if (!item.data)
				return;
			
			if (item.data is Event)
				dispatch((item.data as Event).clone());
		}
	}
}
