package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.service.ITrackerService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginStoredCommand extends Command
	{
		[Inject]
		public var tracker:ITrackerService;
		
		[Inject]
		public var storage:PluginsModel;
		
		override public function execute():void
		{
			tracker.track("/storage/total/" + storage.plugins.length + "/");
		}
	}
}
