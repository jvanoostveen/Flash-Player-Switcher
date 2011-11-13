package flashplayerswitcher.service
{
	import flashplayerswitcher.controller.events.DownloadListDataErrorEvent;
	import flashplayerswitcher.model.DownloadPluginsModel;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.values.PluginDownloadURL;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import org.robotlegs.mvcs.Actor;

	import mx.collections.ArrayCollection;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginDownloadService extends Actor implements IPluginDownloadService
	{
		[Inject]
		public var downloadModel:DownloadPluginsModel;
		
		[Inject]
		public var installed:PluginsModel;
		
		[Inject]
		public var url:PluginDownloadURL;
		
		private var _loader:URLLoader;
		
		public function loadPlugins():void
		{
			if (!_loader)
			{
				_loader = new URLLoader();
				_loader.addEventListener(Event.COMPLETE, onListDataLoaded);
				_loader.addEventListener(IOErrorEvent.IO_ERROR, onListDataError);
			}
			
			var request:URLRequest = new URLRequest(url.toString());
			_loader.load(request);
		}

		private function onListDataLoaded(event:Event):void
		{
			var data:XML = new XML(_loader.data);
			
			var plugins:Array = new Array();
			for each (var pluginData:XML in data.plugin)
			{
				var plugin:FlashPlayerPlugin = new FlashPlayerPlugin();
				plugin.name = pluginData.name.toString();
				plugin.version = pluginData.version.toString();
				plugin.debugger = (pluginData.debugger.toString() == "true" ? true : false);
				plugin.url = pluginData.url.toString();
				plugin.hash = plugin.version + "_" + (plugin.debugger ? "debugger" : "release");
				
				if (!installed.contains(plugin))
					plugins.push(plugin);
			}
			
			plugins.sortOn(["major", "minor", "revision", "build"], Array.NUMERIC);
			downloadModel.plugins = new ArrayCollection(plugins);
		}

		private function onListDataError(event:IOErrorEvent):void
		{
			dispatch(new DownloadListDataErrorEvent(event.text));
		}
	}
}
