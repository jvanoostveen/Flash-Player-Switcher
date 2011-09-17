package flashplayerswitcher.controller.commands
{
	import flashplayerswitcher.controller.events.CheckInstalledBundleVersionEvent;
	import flashplayerswitcher.model.InstalledBundlesModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Joeri van Oostveen
	 */
	public class InitializeAppCommand extends Command
	{
		[Inject]
		public var installedBundles:InstalledBundlesModel;
		
		override public function execute():void
		{
			dispatch(new CheckInstalledBundleVersionEvent(CheckInstalledBundleVersionEvent.SYSTEM));
			dispatch(new CheckInstalledBundleVersionEvent(CheckInstalledBundleVersionEvent.USER));
			
			
		}
	}
}
