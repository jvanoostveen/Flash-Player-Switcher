package flashplayerswitcher.service
{
	import flash.filesystem.File;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public interface IConfigService
	{
		function readConfig():void;
		function saveStorageDirectory(directory:File):void;
		function saveAllowEditing(value:Boolean):void;
	}
}
