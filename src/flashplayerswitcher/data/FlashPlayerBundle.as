package flashplayerswitcher.data
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	/**
	 * @author Joeri van Oostveen <joeri@axis.fm>
	 */
	[Bindable]
	public class FlashPlayerBundle
	{
		public var id:int;
		public var name:String;
		public var version:String;
		public var beta:Boolean = false;
		public var debugger:Boolean = false;
		public var installed:Boolean = false;
		public var sourceUrl:String;

		public function FlashPlayerBundle()
		{
			
		}
		
		public function parse(bundle:File):void
		{
			var infoPlist:File = bundle.resolvePath("Contents/Info.plist");
			
			if (!infoPlist.exists)
			{
				throw new Error("No Info.plist found inside Bundle.");
			}
			
			var fs:FileStream = new FileStream();
			fs.open(infoPlist, FileMode.READ);
			var data:XML = new XML(fs.readUTFBytes(fs.bytesAvailable));
			fs.close();
			
			for each (var key:XML in data.dict.key)
			{
				switch (key.toString())
				{
					case PListKeys.BUNDLE_NAME:
						name = key.parent().*[key.childIndex() + 1][0];
						
						if (name.toLowerCase().indexOf("debugger") > -1)
							debugger = true;
						
						break;
					case PListKeys.BUNDLE_VERSION:
						version = key.parent().*[key.childIndex() + 1][0];
						break;
				}
			}
		}

	}
}
