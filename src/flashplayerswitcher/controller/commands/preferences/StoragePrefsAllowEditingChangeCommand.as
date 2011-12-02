package flashplayerswitcher.controller.commands.preferences
{
	import flashplayerswitcher.controller.events.preferences.StoragePrefsAllowEditingChangeEvent;
	import flashplayerswitcher.service.IConfigService;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StoragePrefsAllowEditingChangeCommand extends Command
	{
		[Inject]
		public var event:StoragePrefsAllowEditingChangeEvent;
		
		[Inject]
		public var config:IConfigService;

		override public function execute():void
		{
			config.saveAllowEditing(event.allowEditing);
		}
	}
}
