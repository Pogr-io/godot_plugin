@tool
extends EditorPlugin

var pogrwindow: Control
var editor_menu_bar: MenuBar
var entry_btn: PopupMenu

func _enable_plugin() -> void:
	add_autoload_singleton("POGR_Manager","res://addons/pogr_plugin/autoloads/pogr_manager.tscn")
	pogrwindow = preload("res://addons/pogr_plugin/editor_scenes/restart_window.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU,pogrwindow)
	pogrwindow.connect("save_restart",save_restart)
	pogrwindow.connect("non_save_restart",restart)
	push_warning("POGR: PLEASE RESTART THE EDITOR")


func _enter_tree():
	if(get_tree().root.has_node("@EditorNode@17638")):
		editor_menu_bar = get_node("/root/@EditorNode@17638/@Control@697/@Panel@698/@VBoxContainer@706/@EditorTitleBar@707/@MenuBar@801")
		entry_btn = preload("res://addons/pogr_plugin/editor_scenes/gdeditor_pogr_button.tscn").instantiate()
		editor_menu_bar.add_child(entry_btn)

func _disable_plugin() -> void:
	if(get_tree().root.has_node("@EditorNode@17638")):
		entry_btn.queue_free()
	remove_autoload_singleton("POGR_Manager")
	remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU,pogrwindow)
	push_warning("POGR: PLEASE RESTART THE EDITOR (Disabled plugins can't restart the editor)")

func _get_plugin_name() -> String:
	return "Pogr SDK Plugin"

func save_restart() -> void:
	get_editor_interface().restart_editor(true)

func restart() -> void:
	get_editor_interface().restart_editor(false)
