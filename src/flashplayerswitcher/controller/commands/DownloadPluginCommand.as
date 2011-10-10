package flashplayerswitcher.controller.commands
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;

	import flashplayerswitcher.controller.events.CopyPluginToStorageEvent;
	import flashplayerswitcher.controller.events.DownloadPluginEvent;
	import flashplayerswitcher.controller.events.ShowPluginStorageListEvent;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;

	import org.robotlegs.mvcs.Command;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DownloadPluginCommand extends Command
	{
		[Inject]
		public var event:DownloadPluginEvent;
		
		override public function execute():void
		{
			commandMap.detain(this);
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onPluginLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			var request:URLRequest = new URLRequest(event.plugin.url);
			loader.load(request);
		}

		private function onPluginLoaded(evt:Event):void
		{
			// TODO: show extraction message
			
			var plugin:FlashPlayerPlugin = event.plugin;
			
			var loader:URLLoader = evt.currentTarget as URLLoader;
			loader.removeEventListener(Event.COMPLETE, onPluginLoaded);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			
			var data:ByteArray = loader.data as ByteArray;
			
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
			
			commandMap.release(this);
		}
	}
}
