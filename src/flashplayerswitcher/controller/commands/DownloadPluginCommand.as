package flashplayerswitcher.controller.commands
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;

	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.controller.events.DownloadPluginEvent;
	import flashplayerswitcher.controller.events.ProgressBarPopupEvent;
	import flashplayerswitcher.controller.events.ShowPluginStorageListEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

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
		
		private var _queue:Vector.<FlashPlayerPlugin>;
		private var _plugin:FlashPlayerPlugin;
		private var _loader:URLLoader;
		
		override public function execute():void
		{
			commandMap.detain(this);
			
			_queue = event.plugins;
			
			loadQueue();
		}
		
		private function loadQueue():void
		{
			if (_queue.length == 0)
			{
				queueDone();
				return;
			}
			
			if (!_loader)
			{
				_loader = new URLLoader();
				_loader.dataFormat = URLLoaderDataFormat.BINARY;
				_loader.addEventListener(ProgressEvent.PROGRESS, onDownloadProgress);
				_loader.addEventListener(Event.COMPLETE, onPluginLoaded);
				_loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			}
			
			_plugin = _queue.shift();
			
			var request:URLRequest = new URLRequest(_plugin.url);
			_loader.load(request);
			
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
			
			var data:ByteArray = _loader.data as ByteArray;
			
			setTimeout(parseZip, 50, data);
		}
		
		private function parseZip(data:ByteArray):void
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
			
			_plugin.search(destination.getDirectoryListing()[0]);
			
			dispatch(new CopyPluginToStorageEvent(_plugin));
			
			destination.deleteDirectory(true);
			
			loadQueue();
		}

		private function onError(evt:IOErrorEvent):void
		{
			var loader:URLLoader = evt.currentTarget as URLLoader;
			loader.removeEventListener(Event.COMPLETE, onPluginLoaded);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			
			trace("unable to load plugin: " + _plugin.url);
			
			// TODO: show error message
			
			loadQueue();
		}

		private function queueDone():void
		{
			if (_loader)
			{
				_loader.removeEventListener(ProgressEvent.PROGRESS, onDownloadProgress);
				_loader.removeEventListener(Event.COMPLETE, onPluginLoaded);
				_loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				_loader = null;
			}
			
			dispatch(new ProgressBarPopupEvent(ProgressBarPopupEvent.HIDE));
			dispatch(new ShowPluginStorageListEvent());
			
			commandMap.release(this);
		}
	}
}
