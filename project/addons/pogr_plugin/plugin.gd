@tool
extends EditorPlugin

var pogrwindow: Control
var pogrsettings: Control

func _enable_plugin() -> void:
	add_autoload_singleton("POGR_Manager","res://addons/pogr_plugin/pogr_manager.tscn")
	pogrwindow = preload("res://addons/pogr_plugin/plugin_window.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU,pogrwindow)

func _enter_tree():
	pogrsettings = preload("res://addons/pogr_plugin/pogr_settings.tscn").instantiate()
	ProjectSettings.set("pogr_sdk/ids/client_id","")
	ProjectSettings.set_initial_value("pogr_sdk/ids/client_id", "")
	ProjectSettings.set("pogr_sdk/ids/build_id","")
	ProjectSettings.set_initial_value("pogr_sdk/ids/build_id", "")
	ProjectSettings.set("pogr_sdk/api/url","")
	ProjectSettings.set_initial_value("pogr_sdk/api/url", "")
	add_control_to_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT,pogrsettings) #TODO: add invisible project settings for it

func _disable_plugin() -> void:
	remove_autoload_singleton("POGR_Manager")
	ProjectSettings.clear("pogr_sdk/ids/client_id")
	ProjectSettings.clear("pogr_sdk/ids/build_id")
	ProjectSettings.clear("pogr_sdk/api/url")
	print("POGR SDK Plugin got diasbled (Please restart the editor if it's causing issues)")
	remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU,pogrwindow)
	remove_control_from_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT,pogrsettings)

func _get_plugin_name():
	return "Pogr SDK Plugin"

func _forward_canvas_gui_input(event):
	print(event)
