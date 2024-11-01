@tool
extends EditorPlugin

var pogrwindow: Control
var editor_menu_bar: MenuBar
var entry_btn: PopupMenu

func _enable_plugin() -> void:
	if FileAccess.file_exists(ProjectSettings.globalize_path("res://") + "addons/pogr_plugin/assets/.gdignore"):
		DirAccess.remove_absolute(ProjectSettings.globalize_path("res://") + "addons/pogr_plugin/assets/.gdignore")
	add_autoload_singleton("POGR_Manager","res://addons/pogr_plugin/autoloads/pogr_manager.tscn")
	await get_tree().create_timer(0.2).timeout
	FileAccess.open("res://addons/pogr_plugin/assets/.gdignore",FileAccess.WRITE)
	pogrwindow = preload("res://addons/pogr_plugin/editor_scenes/restart_window.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU,pogrwindow)
	pogrwindow.connect("save_restart",save_restart)
	pogrwindow.connect("non_save_restart",restart)
	push_warning("POGR: PLEASE RESTART THE EDITOR")

func _enter_tree() -> void:
	entry_btn = preload("res://addons/pogr_plugin/editor_scenes/gdeditor_pogr_button.tscn").instantiate()
	var menu: Node = EditorInterface.get_base_control().get_child(0).get_child(0).get_child(0)
	menu.add_child(entry_btn)

func _disable_plugin() -> void:
	if FileAccess.file_exists(ProjectSettings.globalize_path("res://") + "addons/pogr_plugin/assets/.gdignore"):
		DirAccess.remove_absolute(ProjectSettings.globalize_path("res://") + "addons/pogr_plugin/assets/.gdignore")
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
