package
{
	import mx.resources.ResourceManager;
	
	/**
	 * @author Joeri van Oostveen
	 */
	public function resource(key:String, bundle:String = "Main", parameters:Array = null):String
	{
		var result:String = ResourceManager.getInstance().getString(bundle, key, parameters);
		if (!result)
			trace("Resource not found: " + key + " @ " + bundle);
		
		return result || "";
	}
}
