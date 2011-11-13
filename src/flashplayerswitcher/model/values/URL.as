package flashplayerswitcher.model.values
{
	/**
	 * @author Joeri van Oostveen
	 */
	public class URL
	{
		public var url:String;
		
		public function URL(url:String)
		{
			this.url = url;
		}
		
		public function toString():String
		{
			return url;
		}
	}
}
