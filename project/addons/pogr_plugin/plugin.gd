@tool
extends EditorPlugin


func _enable_plugin() -> void:
	push_warning("POGR SDK Plugin got enabled (PLEASE  RESTART THE EDITOR)")
	ProjectSettings.set("pogr_sdk/ids/client_id","")
	ProjectSettings.set_initial_value("pogr_sdk/ids/client_id", "")
	ProjectSettings.set("pogr_sdk/ids/build_id","")
	ProjectSettings.set_initial_value("pogr_sdk/ids/build_id", "")
	ProjectSettings.set("pogr_sdk/api/url","")
	ProjectSettings.set_initial_value("pogr_sdk/api/url", "")

func _disable_plugin() -> void:
	ProjectSettings.clear("pogr_sdk/ids/client_id")
	ProjectSettings.clear("pogr_sdk/ids/build_id")
	ProjectSettings.clear("pogr_sdk/api/url")

func _get_plugin_name():
	return "Pogr SDK Plugin"
