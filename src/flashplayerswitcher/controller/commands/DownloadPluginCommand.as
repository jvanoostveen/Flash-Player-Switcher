package flashplayerswitcher.controller.commands
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;

	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.controller.events.DownloadPluginEvent;
	import flashplayerswitcher.controller.events.ProgressBarPopupEvent;
	import flashplayerswitcher.controller.events.ShowPluginStorageListEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.service.ITrackerService;

	import org.robotlegs.mvcs.Command;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DownloadPluginCommand extends Command
	{
		[Inject]
		public var event:DownloadPluginEvent;
		
		[Inject]
		public var tracker:ITrackerService;
		
		override public function execute():void
		{
			commandMap.detain(this);
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(ProgressEvent.PROGRESS, onDownloadProgress);
			loader.addEventListener(Event.COMPLETE, onPluginLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			var request:URLRequest = new URLRequest(event.plugin.url);
			loader.load(request);
			
			var progress:ProgressBarPopupEvent = new ProgressBarPopupEvent(ProgressBarPopupEvent.SHOW);
			progress.label = resource('DOWNLOADING');
			dispatch(progress);
		}
		
		private function onDownloadProgress(evt:ProgressEvent):void
		{
			var progress:ProgressBarPopupEvent = new ProgressBarPopupEvent(ProgressBarPopupEvent.UPDATE);
			progress.label = resource("DOWNLOAD_PROGRESS");
			progress.value = Math.round(evt.bytesLoaded / 1024);
			progress.total = Math.round(evt.bytesTotal / 1024);
			dispatch(progress);
		}

		private function onPluginLoaded(evt:Event):void
		{
			var progress:ProgressBarPopupEvent = new ProgressBarPopupEvent(ProgressBarPopupEvent.SHOW);
			progress.label = resource("EXTRACTING");
			progress.indeterminate = true;
			dispatch(progress);
			
			var plugin:FlashPlayerPlugin = event.plugin;
			
			var loader:URLLoader = evt.currentTarget as URLLoader;
			loader.removeEventListener(Event.COMPLETE, onPluginLoaded);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			
			var data:ByteArray = loader.data as ByteArray;
			
			tracker.track("/download/" + plugin.version + "/" + (plugin.debugger ? "debugger" : "release") + "/");
			
			setTimeout(parseZip, 50, plugin, data);
		}
		
		private function parseZip(plugin:FlashPlayerPlugin, data:ByteArray):void
		{
			var fzip:FZip = new FZip();
			fzip.loadBytes(data);
			
			var destination:File = File.createTempDirectory();
			for (var i:int = 0; i < fzip.getFileCount(); i++)
			{
				var fzipFile:FZipFile = fzip.getFileAt(i);
				var file:File = destination.resolvePath(fzipFile.filename);
				
				if (fzipFile.filename.substr(-1) == "/")
				{
					file.createDirectory();
				} else {
					var fs:FileStream = new FileStream();
					fs.open(file, FileMode.WRITE);
					fs.writeBytes(fzipFile.content);
					fs.close();
				}
			}
			
			plugin.search(destination.getDirectoryListing()[0]);
			
			dispatch(new CopyPluginToStorageEvent(plugin));
			dispatch(new ProgressBarPopupEvent(ProgressBarPopupEvent.HIDE));
			dispatch(new ShowPluginStorageListEvent());
			
			destination.deleteDirectory(true);
			
			commandMap.release(this);
		}

		private function onError(evt:IOErrorEvent):void
		{
			var loader:URLLoader = evt.currentTarget as URLLoader;
			loader.removeEventListener(Event.COMPLETE, onPluginLoaded);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			
			trace("unable to load plugin: " + event.plugin.url);
			
			dispatch(new ProgressBarPopupEvent(ProgressBarPopupEvent.HIDE));
			// show error message
			
			commandMap.release(this);
		}
	}
}
