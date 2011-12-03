package flashplayerswitcher.view.preferences
{
	import flashplayerswitcher.controller.events.StorageAllowEditingChangedEvent;
	import flashplayerswitcher.controller.events.StorageDirectoryChangedEvent;
	import flashplayerswitcher.controller.events.preferences.StoragePrefsAllowEditingChangeEvent;
	import flashplayerswitcher.controller.events.preferences.StoragePrefsLocationSelectEvent;
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
			addContextListener(StorageDirectoryChangedEvent.CHANGED, updateStorageList);
			addContextListener(StorageAllowEditingChangedEvent.CHANGED, updateAllowEditing);
			
			addContextListener(StoragePrefsLocationSelectEvent.CANCEL, onCancel, StoragePrefsLocationSelectEvent);
			
			addViewListener(StoragePrefsLocationSelectEvent.CHANGE, onLocationChange, StoragePrefsLocationSelectEvent);
			addViewListener(StoragePrefsAllowEditingChangeEvent.CHANGE, dispatch, StoragePrefsAllowEditingChangeEvent);
			
			view.allowEditing = config.storageAllowEditing;
			updateStorageList();
		}
		
		private function updateAllowEditing(event:StorageAllowEditingChangedEvent):void
		{
			view.allowEditing = event.allowEditing;
		}

		private function onLocationChange(event:StoragePrefsLocationSelectEvent):void
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
		
		private function updateStorageList(event:StorageDirectoryChangedEvent = null):void
		{
			var locations:Array = new Array();
			
			view.allowEditingEnabled = false;
			
			if (config.storageDirectory.nativePath != File.applicationStorageDirectory.nativePath)
			{
				var currentStorage:Object = {label: config.storageDirectory.name, data: config.storageDirectory};
				locations.push(currentStorage);
				
				view.allowEditingEnabled = true;
			}
			var appStorage:Object = {label: resource("APPLICATION_STORAGE", StoragePreferencesPanel.ID), data: File.applicationStorageDirectory};
			locations.push(appStorage);
			
			var otherStorage:Object = {label: resource("OTHER", StoragePreferencesPanel.ID), data: null};
			locations.push(otherStorage);
			
			view.pluginStorageLocations = new ArrayCollection(locations);
			_ignoreChange = true;
			view.pluginStorageLocationSelectedIndex = -1;
			view.pluginStorageLocationSelectedIndex = 0;
			_ignoreChange = false;
		}
	}
}
