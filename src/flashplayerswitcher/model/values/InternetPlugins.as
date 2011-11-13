package flashplayerswitcher.model.values
{
	import flash.filesystem.File;
	
	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	public class InternetPlugins
	{
		public var system:File;
		public var user:File;

		public function InternetPlugins()
		{
			system = (File.getRootDirectories()[0] as File).resolvePath("Library/Internet Plug-Ins");
			user = File.userDirectory.resolvePath("Library/Internet Plug-Ins");
		}
	}
}
