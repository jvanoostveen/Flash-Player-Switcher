package flashplayerswitcher.model.values
{
	/**
	 * @author Joeri van Oostveen
	 */
	public class GoogleAnalyticsAccount
	{
		public var id:String;
		
		public function GoogleAnalyticsAccount(id:String)
		{
			this.id = id;
		}
		
		public function toString():String
		{
			return id;
		}
	}
}
