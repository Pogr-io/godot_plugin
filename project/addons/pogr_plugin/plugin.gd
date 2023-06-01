@tool
extends EditorPlugin


func _enable_plugin() -> void:
	print("Pogr SDK Plugin got enabled (PLEASE  RESTART THE EDITOR)")
	ProjectSettings.set("PogrSDK/ids/ClientID","")
	ProjectSettings.set_initial_value("PogrSDK/ids/ClientID", "")
	ProjectSettings.set("PogrSDK/ids/BuildID","")
	ProjectSettings.set_initial_value("PogrSDK/ids/BuildID", "")
	

func _disable_plugin() -> void:
	ProjectSettings.clear("PogrSDK/ids/ClientID")
	ProjectSettings.clear("PogrSDK/ids/BuildID")

func _get_plugin_name():
	return "Pogr SDK Plugin"
