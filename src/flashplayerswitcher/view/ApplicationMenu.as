package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ProvideFeedbackEvent;
	import flashplayerswitcher.controller.events.ShowHelpEvent;
	import flashplayerswitcher.controller.events.ShowPreferencesEvent;

	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.EventDispatcher;
	import flash.ui.Keyboard;

	/**
	 * @author Joeri van Oostveen
	 */
	public class ApplicationMenu extends EventDispatcher
	{
		public function ApplicationMenu()
		{
			if (NativeApplication.supportsMenu)
			{
				var separator:NativeMenuItem;
				
				// app menu
				var appMenu:NativeMenu = (NativeApplication.nativeApplication.menu.items[0] as NativeMenuItem).submenu;
				
				separator = new NativeMenuItem("", true);
				appMenu.addItemAt(separator, 1);
				
				var preferences:NativeMenuItem = new NativeMenuItem(resource("PREFERENCES_MENU_ITEM"));
				preferences.keyEquivalent = ",";
				preferences.keyEquivalentModifiers = [Keyboard.COMMAND];
				preferences.data = new ShowPreferencesEvent();
				appMenu.addItemAt(preferences, 2);
				
				// help menu
				var helpMenuItem:NativeMenuItem = new NativeMenuItem(resource("HELP_MENU_ITEM"));
				var helpMenu:NativeMenu = new NativeMenu();
				helpMenuItem.submenu = helpMenu;
				
				var help:NativeMenuItem = new NativeMenuItem(resource("HELP_MENU_ITEM_HELP"));
				help.data = new ShowHelpEvent();
				helpMenu.addItem(help);
				
				separator = new NativeMenuItem("", true);
				helpMenu.addItem(separator);
				
				var feedback:NativeMenuItem = new NativeMenuItem(resource("HELP_MENU_ITEM_FEEDBACK"));
				feedback.data = new ProvideFeedbackEvent();
				helpMenu.addItem(feedback);
				
				NativeApplication.nativeApplication.menu.addItem(helpMenuItem);
			}
		}
	}
}
