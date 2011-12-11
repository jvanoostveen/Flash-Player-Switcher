package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.InstalledPluginUpdatedEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
	import flashplayerswitcher.locale.Locale;
	import flashplayerswitcher.model.PluginsModel;
	import flashplayerswitcher.model.vo.FlashPlayerPlugin;
	import flashplayerswitcher.model.vo.PluginSet;

	import org.robotlegs.mvcs.Mediator;

	import flash.desktop.DockIcon;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;

	/**
	 * @author Joeri van Oostveen
	 */
	public class DockIconMediator extends Mediator
	{
		[Inject]
		public var icon:DockIcon;
		
		[Inject]
		public var installed:PluginsModel;
		
		override public function onRegister():void
		{
			addContextListener(PluginsUpdatedEvent.UPDATED, onPluginsUpdated, PluginsUpdatedEvent);
			addContextListener(InstalledPluginUpdatedEvent.USER, onUserPluginUpdated, InstalledPluginUpdatedEvent);
			
			eventMap.mapListener(icon.menu, Event.SELECT, onMenuItemSelected);
		}
		
		private function onUserPluginUpdated(event:InstalledPluginUpdatedEvent):void
		{
			updateMenuItems();
		}
		
		private function updateMenuItems():void
		{
			var user:FlashPlayerPlugin = installed.user;
			for each (var item:NativeMenuItem in icon.menu.items)
			{
				if (item.data)
				{
					if (item.data is String && item.data == "current")
					{
						item.label = resource("INSTALLED_NONE");
						if (user)
						{
							var type:String = user.debugger ? resource("DEBUGGER") : resource("RELEASE");
							item.label = resource("CURRENT_PLUGIN", Locale.MAIN, [user.version, type]);
						}
					}
				}
				
				if (item.submenu)
				{
					for each (var subitem:NativeMenuItem in item.submenu.items)
					{
						if (!subitem.data)
							continue;
						
						if (subitem.data is FlashPlayerPlugin)
						{
							if (user && (subitem.data as FlashPlayerPlugin).hash == user.hash)
								subitem.enabled = false;
							else
								subitem.enabled = true;
						}
					}
				}
			}
		}

		private function onPluginsUpdated(event:PluginsUpdatedEvent):void
		{
			reset();
			
			var items:Array = new Array();
			
			var label:NativeMenuItem = new NativeMenuItem(resource("PLUGINS"));
			label.enabled = false;
			items.push(label);
			
			var current:NativeMenuItem = new NativeMenuItem(resource("INSTALLED_NONE"));
			current.data = "current";
			current.enabled = false;
			items.push(current);
			if (installed.user)
			{
				var type:String = installed.user.debugger ? resource("DEBUGGER") : resource("RELEASE");
				current.label = resource("CURRENT_PLUGIN", Locale.MAIN, [installed.user.version, type]);
			}
			
			for each (var s:PluginSet in installed.sortedPlugins)
			{
				var item:NativeMenuItem = new NativeMenuItem(s.version);
				items.push(item);
				
				var submenu:NativeMenu = new NativeMenu();
				item.submenu = submenu;
				
				if (s.release)
				{
					var release:NativeMenuItem = new NativeMenuItem(resource("RELEASE"));
					release.data = s.release;
					submenu.addItem(release);
				}
				
				if (s.debugger)
				{
					var debugger:NativeMenuItem = new NativeMenuItem(resource("DEBUGGER"));
					debugger.data = s.debugger;
					submenu.addItem(debugger);
				}
			}
			
			icon.menu.items = items;
			
			updateMenuItems();
		}

		private function reset():void
		{
			for each (var item:NativeMenuItem in icon.menu.items)
			{
				if (item.submenu)
				{
					for each (var subitem:NativeMenuItem in item.submenu.items)
					{
						subitem.data = null;
						subitem = null;
					}
					
					item.submenu.items.length = 0;
					item.submenu = null;
				}
				
				item = null;
			}
			
			icon.menu.items.length = 0;
		}
		
		private function onMenuItemSelected(event:Event):void
		{
			var item:NativeMenuItem = event.target as NativeMenuItem;
			
			if (!item.data)
				return;
			
			if (item.data is FlashPlayerPlugin)
				dispatch(new ActivatePluginEvent(item.data as FlashPlayerPlugin));
		}
	}
}
