package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ProgressBarPopupEvent extends Event
	{
		public static const SHOW:String = "show_progress_bar";
		public static const UPDATE:String = "update_progress_bar";
		public static const HIDE:String = "hide_progress_bar";
		
		public var label:String = "";
		public var indeterminate:Boolean = false;
		public var value:Number = 0;
		public var total:Number = 1;
		
		public function ProgressBarPopupEvent(type:String)
		{
			super(type);
		}

		override public function clone():Event
		{
			var event:ProgressBarPopupEvent = new ProgressBarPopupEvent(type);
			event.label = label;
			event.indeterminate = indeterminate;
			event.value = value;
			event.total = total;
			return event;
		}
	}
}
