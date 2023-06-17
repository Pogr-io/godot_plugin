@tool
extends Control

var config: ConfigFile = ConfigFile.new()

func _enter_tree():
	config.load("res://addons/pogr_plugin/pogr.cfg")
	$Panel/MarginContainer/GridContainer/ClientID.text = config.get_value("api","client_id")
	$Panel/MarginContainer/GridContainer/BuildID.text = config.get_value("api","build_id")
	$Panel/MarginContainer/GridContainer/ApiURL.text = config.get_value("api","api_url")

func _on_client_id_text_changed(new_text):
	config.set_value("api","client_id",new_text)
	config.save("res://addons/pogr_plugin/pogr.cfg")
func _on_build_id_text_changed(new_text):
	config.set_value("api","build_id",new_text)
	config.save("res://addons/pogr_plugin/pogr.cfg")
func _on_api_url_text_changed(new_text):
	config.set_value("api","api_url",new_text)
	config.save("res://addons/pogr_plugin/pogr.cfg")


func _on_about_pressed():
	$AcceptDialog.popup()

func _on_accept_dialog_confirmed():
	$Credits.popup()

func _on_credits_close_requested():
	$Credits.hide()
