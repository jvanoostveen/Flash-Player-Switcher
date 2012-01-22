package flashplayerswitcher.model.values
{
	import com.adobe.growl.Application;

	/**
	 * @author Joeri van Oostveen
	 */
	public class GrowlApplication extends Application
	{
		public function GrowlApplication(name:String, iconPath:String)
		{
			this.name = name;
			this.iconPath = iconPath;
		}
	}
}
