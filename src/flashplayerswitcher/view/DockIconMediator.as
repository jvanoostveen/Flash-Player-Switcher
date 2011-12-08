package flashplayerswitcher.view
{
	import flashplayerswitcher.controller.events.ActivatePluginEvent;
	import flashplayerswitcher.controller.events.PluginsUpdatedEvent;
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
			
			eventMap.mapListener(icon.menu, Event.SELECT, onMenuItemSelected);
		}

		private function onPluginsUpdated(event:PluginsUpdatedEvent):void
		{
			reset();
			
			var items:Array = new Array();
			
			var label:NativeMenuItem = new NativeMenuItem(resource("PLUGINS"));
			label.enabled = false;
			items.push(label);
			
			for each (var s:PluginSet in installed.sortedPlugins)
			{
				var item:NativeMenuItem = new NativeMenuItem(s.version);
				items.push(item);
				
				var submenu:NativeMenu = new NativeMenu();
				item.submenu = submenu;
				
				if (s.release)
				{
					var release:NativeMenuItem = new NativeMenuItem("Release");
					release.data = s.release;
					submenu.addItem(release);
				}
				
				if (s.debugger)
				{
					var debugger:NativeMenuItem = new NativeMenuItem("Debugger");
					debugger.data = s.debugger;
					submenu.addItem(debugger);
				}
			}
			
			icon.menu.items = items;
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
