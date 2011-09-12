package flashplayerswitcher.tasks
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	
	[Event(name="complete", type="flash.events.Event")]
	
	public class ExtractBundle extends EventDispatcher
	{
		private var _source:File;
		private var _archive:File;
		
		private var _tool:NativeProcess;
		private var _gzip:NativeProcess;
		private var _pax:NativeProcess;
		
		private var _xpt:File;
		private var _fp:File;
		
		private var _tempDir:File;
		
		public function ExtractBundle(source:File)
		{
			_source = source;
		}

		public function execute():void
		{
			extractArchive();
			deflateArchive();
		}
		
		private function extractArchive():void
		{
			var source:File = _source.resolvePath("Contents/Resources/");
			// Adobe Flash Player.pkg or Adobe Flash Player Debugger.pkg
			var pkg:File = source.resolvePath("Adobe Flash Player.pkg");
			if (!pkg.exists)
				pkg = source.resolvePath("Adobe Flash Player Debugger.pkg");
			
			if (!pkg.exists) // nothing found, show error message
				throw new Error("No pkg found");
			
			source = pkg.resolvePath("Contents/Archive.pax.gz");
			
			_tempDir = File.createTempDirectory();
			trace("temp storage: " + _tempDir.nativePath);
			_archive = _tempDir.resolvePath(source.name);
			
			source.copyTo(_archive);
		}
		
		private function deflateArchive():void
		{
			_tool = new NativeProcess();
			_tool.addEventListener(NativeProcessExitEvent.EXIT, handleToolExit);
			
			var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			info.executable = File.applicationDirectory.resolvePath("tools/test.sh");
			var arguments:Vector.<String> = new Vector.<String>();
			arguments.push(_tempDir.nativePath);
			arguments.push(_archive.nativePath);
			info.arguments = arguments;
			
			_tool.start(info);
			
//			_gzip = new NativeProcess();
//			_gzip.addEventListener(NativeProcessExitEvent.EXIT, handleGZipExit);
//			
//			var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
//			info.executable = new File("/usr/bin/gzip");
//			var arguments:Vector.<String> = new Vector.<String>();
//			arguments.push("-d");
//			arguments.push(_archive.nativePath);
//			info.arguments = arguments;
//			
//			_gzip.start(info);
		}

		private function handleToolExit(event:NativeProcessExitEvent):void
		{
			trace("tool exit");
			
			var lzma:File = _tempDir.resolvePath("Internet Plug-Ins/Flash Player.plugin.lzma");
			// hmm, no way of decompressing this file...
		}

		private function handleGZipExit(event:NativeProcessExitEvent):void
		{
			_archive = _tempDir.resolvePath("Archive.pax");
			trace("pax archive exists: " + _archive.exists);
			
			_pax = new NativeProcess();
			_pax.addEventListener(NativeProcessExitEvent.EXIT, handlePaxExit);
			
			var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			info.executable = new File("/bin/pax");
			var arguments:Vector.<String> = new Vector.<String>();
			arguments.push("-r");
			arguments.push("-f");
			arguments.push(_tempDir.nativePath);
			arguments.push(_archive.nativePath);
			arguments.push("> /Users/joeri/Desktop/test.log");
			info.arguments = arguments;
			
			_pax.start(info);
		}

		private function handlePaxExit(event:NativeProcessExitEvent):void
		{
			
			
			_xpt = _tempDir.resolvePath("Internet Plug-Ins/flashplayer.xpt");
			_fp = _tempDir.resolvePath("Internet Plug-Ins/Flash Player.plugin.lzma");
			
			trace("fp lzma: " + _fp.nativePath);
			
			if (!_fp.exists)
			{
				trace("!exists");
				cleanup();
				return;
			}
			
			// decompress lzma
//			var lzma:LZMADecoder = new LZMADecoder();
			
			var fs_in:FileStream = new FileStream();
			fs_in.open(_fp, FileMode.READ);
			
			var data_in:ByteArray = new ByteArray();
			fs_in.readBytes(data_in, 0, fs_in.bytesAvailable);
			fs_in.close();
			
			var data_out:ByteArray = new ByteArray();
			
//			lzma.code(data_in, data_out, 0);
			
			_fp = _tempDir.resolvePath("Internet Plug-Ins/Flash Player.plugin");
			var fs_out:FileStream = new FileStream();
			fs_out.open(_fp, FileMode.WRITE);
			fs_out.writeBytes(data_out, 0, data_out.bytesAvailable);
			fs_out.close();
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function cleanup():void
		{
			if (_tempDir)
			{
				_tempDir.deleteDirectory(true);
				_tempDir = null;
			}
		}
	}
}
