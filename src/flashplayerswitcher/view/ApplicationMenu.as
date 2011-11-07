package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ProvideFeedbackEvent;
	import flashplayerswitcher.controller.events.ShowHelpEvent;

	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.EventDispatcher;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ApplicationMenu extends EventDispatcher
	{
		public function ApplicationMenu()
		{
			if (NativeApplication.supportsMenu)
			{
				var helpMenuItem:NativeMenuItem = new NativeMenuItem("Help");
				var helpMenu:NativeMenu = new NativeMenu();
				helpMenuItem.submenu = helpMenu;
				
				var help:NativeMenuItem = new NativeMenuItem("Flash Player Switcher Help");
				help.data = new ShowHelpEvent();
				helpMenu.addItem(help);
				
				var separator:NativeMenuItem = new NativeMenuItem("", true);
				helpMenu.addItem(separator);
				
				var feedback:NativeMenuItem = new NativeMenuItem("Provide feedback");
				feedback.data = new ProvideFeedbackEvent();
				helpMenu.addItem(feedback);
				
				NativeApplication.nativeApplication.menu.addItem(helpMenuItem);
			}
		}
	}
}
