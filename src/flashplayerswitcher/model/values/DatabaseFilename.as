package flashplayerswitcher.model.values
{
	
	/**
	 * @author Joeri van Oostveen
	 */
	public class DatabaseFilename
	{
		public var name:String;
		
		public function DatabaseFilename(name:String)
		{
			this.name = name;
		}
		
		public function toString():String
		{
			return name;
		}
	}
}
