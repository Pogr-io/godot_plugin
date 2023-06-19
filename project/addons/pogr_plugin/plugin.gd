@tool
extends EditorPlugin

var pogrwindow: Control
var pogrsettings: Control

func _enable_plugin() -> void:
	add_autoload_singleton("POGR_Manager","res://addons/pogr_plugin/pogr_manager.tscn")
	pogrwindow = preload("res://addons/pogr_plugin/plugin_window.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU,pogrwindow)
	pogrwindow.get_child(0).connect("confirmed",save_restart)
	pogrwindow.get_child(0).connect("canceled",restart)


func _enter_tree():
	pogrsettings = preload("res://addons/pogr_plugin/pogr_settings.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT,pogrsettings)

func _disable_plugin() -> void:
	remove_autoload_singleton("POGR_Manager")
	push_warning("POGR SDK Plugin got diasbled (Please restart the editor if it's causing issues)")
	remove_control_from_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT,pogrsettings)

func _get_plugin_name() -> String:
	return "Pogr SDK Plugin"

func save_restart() -> void:
	get_editor_interface().restart_editor(true)

func restart() -> void:
	get_editor_interface().restart_editor(false)
