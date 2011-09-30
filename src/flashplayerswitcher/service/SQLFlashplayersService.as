package flashplayerswitcher.service
{
	import mx.collections.ArrayCollection;
	import flashplayerswitcher.model.InstalledBundlesModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.service.helpers.ISQLRunnerDelegate;

	import org.robotlegs.mvcs.Actor;

	import flash.data.SQLResult;
	import flash.errors.SQLError;

	/**
	 * @author Joeri van Oostveen
	 */
	public class SQLFlashplayersService extends Actor implements IFlashplayersService
	{
        [Inject]
        public var sqlRunner:ISQLRunnerDelegate;

        [Inject]
		public var installedBundles:InstalledBundlesModel;

		public function loadFlashplayers():void
		{
			sqlRunner.execute(LOAD_ALL_FLASHPLAYERS_SQL, null, result, FlashPlayerPlugin, fault);
		}
		
		private function result(data:SQLResult):void
		{
			installedBundles.bundles = new ArrayCollection(data.data);
		}
		
		private function fault(error:SQLError):void
		{
			trace(error.message);
		}
		
		[Embed(source="flashplayerswitcher/sql/flashplayers/LoadAllFlashplayers.sql", mimeType="application/octet-stream")]
		private static var LoadAllFlashplayersStatementText:Class;
		public static const LOAD_ALL_FLASHPLAYERS_SQL:String = new LoadAllFlashplayersStatementText();
	}
}
