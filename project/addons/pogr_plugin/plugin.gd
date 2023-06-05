@tool
extends EditorPlugin

var pogrwindow: Node

func _enable_plugin() -> void:
	add_autoload_singleton("POGR_Manager","res://addons/pogr_plugin/pogr_manager.tscn")
	ProjectSettings.set("pogr_sdk/ids/client_id","")
	ProjectSettings.set_initial_value("pogr_sdk/ids/client_id", "")
	ProjectSettings.set("pogr_sdk/ids/build_id","")
	ProjectSettings.set_initial_value("pogr_sdk/ids/build_id", "")
	ProjectSettings.set("pogr_sdk/api/url","")
	ProjectSettings.set_initial_value("pogr_sdk/api/url", "")
	pogrwindow = preload("res://addons/pogr_plugin/plugin_window.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU,pogrwindow)
	add_control_to_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_LEFT,preload("res://addons/pogr_plugin/pogr_credits.tscn").instantiate())

func _disable_plugin() -> void:
	remove_autoload_singleton("POGR_Manager")
	ProjectSettings.clear("pogr_sdk/ids/client_id")
	ProjectSettings.clear("pogr_sdk/ids/build_id")
	ProjectSettings.clear("pogr_sdk/api/url")
	print("POGR SDK Plugin got diasbled (Please restart the editor if it's causing issues)")
	remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU,pogrwindow)

func _get_plugin_name():
	return "Pogr SDK Plugin"

func _forward_canvas_gui_input(event):
	print(event)
