package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.model.PluginsModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginStoredCommand extends Command
	{
		[Inject]
		public var storage:PluginsModel;
		
		override public function execute():void
		{
			
		}
	}
}
