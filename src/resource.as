package
{
	import flashplayerswitcher.locale.Locale;

	import mx.resources.ResourceManager;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public function resource(key:String, bundle:String = "", parameters:Array = null):String
	{
		if (bundle == "")
			bundle = Locale.MAIN;
		
		var result:String = ResourceManager.getInstance().getString(bundle, key, parameters);
		if (!result)
			trace("Resource not found: " + key + " @ " + bundle);
		
		return result || "";
	}
}
