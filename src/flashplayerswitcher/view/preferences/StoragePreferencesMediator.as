package flashplayerswitcher.view.preferences
{
	import flashplayerswitcher.controller.events.StorageDirectoryChangedEvent;
	import flashplayerswitcher.controller.events.StoragePrefsLocationSelectEvent;
	import flashplayerswitcher.model.ConfigModel;

	import org.robotlegs.mvcs.Mediator;

	import mx.collections.ArrayCollection;

	import flash.filesystem.File;

	/**
	 * @author Joeri van Oostveen
	 */
	public class StoragePreferencesMediator extends Mediator
	{
		[Inject]
		public var view:StoragePreferencesPanel;
		
		[Inject]
		public var config:ConfigModel;
		
		private var _ignoreChange:Boolean = false;
		
		override public function onRegister():void
		{
			addContextListener(StorageDirectoryChangedEvent.CHANGED, update);
			addContextListener(StoragePrefsLocationSelectEvent.CANCEL, onCancel, StoragePrefsLocationSelectEvent);
			
			addViewListener(StoragePrefsLocationSelectEvent.CHANGE, onChange, StoragePrefsLocationSelectEvent);
			
			updateStorageList();
		}

		private function update(event:StorageDirectoryChangedEvent):void
		{
			updateStorageList();
		}
		
		private function onChange(event:StoragePrefsLocationSelectEvent):void
		{
			if (!_ignoreChange)
				dispatch(event.clone());
		}
		
		private function onCancel(event:StoragePrefsLocationSelectEvent):void
		{
			_ignoreChange = true;
			view.pluginStorageLocationSelectedIndex = -1;
			view.pluginStorageLocationSelectedIndex = 0;
			_ignoreChange = false;
		}
		
		private function updateStorageList():void
		{
			var locations:Array = new Array();
			
			view.allowEditingEnabled = false;
			
			if (config.storageDirectory.nativePath != File.applicationStorageDirectory.nativePath)
			{
				var currentStorage:Object = {label: config.storageDirectory.name, data: config.storageDirectory};
				locations.push(currentStorage);
				
				view.allowEditingEnabled = true;
			}
			var appStorage:Object = {label: "Application Storage", data: File.applicationStorageDirectory};
			locations.push(appStorage);
			
			var otherStorage:Object = {label: "Other...", data: null};
			locations.push(otherStorage);
			
			view.pluginStorageLocations = new ArrayCollection(locations);
			_ignoreChange = true;
			view.pluginStorageLocationSelectedIndex = -1;
			view.pluginStorageLocationSelectedIndex = 0;
			_ignoreChange = false;
		}
	}
}
