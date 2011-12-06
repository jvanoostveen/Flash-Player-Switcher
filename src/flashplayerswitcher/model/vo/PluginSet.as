package flashplayerswitcher.model.vo
{
	import flash.events.EventDispatcher;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class PluginSet extends EventDispatcher
	{
		private var _release:FlashPlayerPlugin;
		private var _debugger:FlashPlayerPlugin;
		
		private var _name:String;
		private var _version:String;

		// detailed version info (for sorting etc).
		public var major:uint;
		public var minor:uint;
		public var revision:uint;
		public var build:uint;
		
		public function PluginSet()
		{
			
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get version():String
		{
			return _version;
		}

		public function set version(value:String):void
		{
			_version = value;
			
			var v:Array = _version.split(".");
			major = parseInt(v[0]);
			minor = parseInt(v[1]);
			revision = parseInt(v[2]);
			build = parseInt(v[3]);
		}
		
		public function addPlugin(plugin:FlashPlayerPlugin):void
		{
			if (plugin.debugger)
				debugger = plugin;
			else
				release = plugin;
		}

		public function get release():FlashPlayerPlugin
		{
			return _release;
		}

		public function set release(plugin:FlashPlayerPlugin):void
		{
			_release = plugin;
			
			_name = _release.name;
			version = _release.version;
		}

		public function get debugger():FlashPlayerPlugin
		{
			return _debugger;
		}

		public function set debugger(plugin:FlashPlayerPlugin):void
		{
			_debugger = plugin;
			
			_name = _debugger.name.substring(0, _debugger.name.indexOf(" Debugger"));
			version = _debugger.version;
		}
		
		public function get hasRelease():Boolean
		{
			return _release ? true : false;
		}
		
		public function get hasDebugger():Boolean
		{
			return _debugger ? true : false;
		}
	}
}
