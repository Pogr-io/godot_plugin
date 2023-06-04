@tool
extends EditorPlugin


func _enable_plugin() -> void:
	add_autoload_singleton("POGR_Manager","res://addons/pogr_plugin/pogr_manager.tscn")
	ProjectSettings.set("pogr_sdk/ids/client_id","")
	ProjectSettings.set_initial_value("pogr_sdk/ids/client_id", "")
	ProjectSettings.set("pogr_sdk/ids/build_id","")
	ProjectSettings.set_initial_value("pogr_sdk/ids/build_id", "")
	ProjectSettings.set("pogr_sdk/api/url","")
	ProjectSettings.set_initial_value("pogr_sdk/api/url", "")
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR,preload("res://addons/pogr_plugin/plugin_window.tscn").instantiate())
	
func _disable_plugin() -> void:
	remove_autoload_singleton("POGR_Manager")
	ProjectSettings.clear("pogr_sdk/ids/client_id")
	ProjectSettings.clear("pogr_sdk/ids/build_id")
	ProjectSettings.clear("pogr_sdk/api/url")
	print("POGR SDK Plugin got diasbled (Please restart the editor if it's causing issues)")

func _get_plugin_name():
	return "Pogr SDK Plugin"
