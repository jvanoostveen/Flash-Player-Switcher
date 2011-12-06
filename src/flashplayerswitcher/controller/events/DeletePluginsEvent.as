package flashplayerswitcher.controller.events
{
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DeletePluginsEvent extends Event
	{
		public static const DELETE:String = "DeletePluginsEvent.DELETE";
		
		public var plugins:Array;
		
		public function DeletePluginsEvent(plugins:Array)
		{
			super(DELETE);
			
			this.plugins = plugins;
		}

		override public function clone():Event
		{
			return new DeletePluginsEvent(plugins);
		}
	}
}
