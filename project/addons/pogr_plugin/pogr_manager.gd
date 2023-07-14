extends HTTPRequest

var close_request: bool = false
var mutex: Mutex = Mutex.new() # TODO for 4.1
var thread: Thread = Thread.new() # TODO for 4.1
var monitor_dict: Dictionary = {}

var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	toggle_session()

func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().set_auto_accept_quit(false)
		toggle_session()
		close_request = true

func toggle_session() -> void:
	config.load("res://addons/pogr_plugin/pogr.cfg")
	request("http://postman-echo.com/get", ["CLIENT_ID: " + config.get_value("api","client_id",""), "BUILD_ID: " + config.get_value("api","build_id","")], HTTPClient.METHOD_GET)

func _on_request_completed(_result, _response_code, _headers, body) -> void:
	var json: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	if(json["headers"]):
		print(json["headers"])
	if(close_request):
		get_tree().quit()


func _on_monitor_timer_timeout() -> void:
	var sys_monitor_info = pogr_plugin.get_sys_monitor_info()
	monitor_dict = {
		"Engine": "Godot Engine " + Engine.get_version_info().string,
		"OS": {
			"name": OS.get_name(),
			"distro": OS.get_distribution_name(),
			"version": OS.get_version(),
			"language": OS.get_locale(),
			"time": "{year}-{month}-{day} {hour}:{minute}:{second}".format(Time.get_datetime_dict_from_system(true))
		},
		"device": OS.get_model_name(),
		"unique_id": OS.get_unique_id(),
		"cpu": {
			"name": OS.get_processor_name(),
			"count": OS.get_processor_count(),
			"percentage": sys_monitor_info.cpu_load_percentage
		},
		"gpu": {
			"name": RenderingServer.get_video_adapter_name(),
			"vendor": RenderingServer.get_video_adapter_vendor(),
			"driver_info": OS.get_video_adapter_driver_info(),
			"api_version": RenderingServer.get_video_adapter_api_version(),
			"fps": Engine.get_frames_per_second()
		},
		"memory": {
			"max_physical": sys_monitor_info.max_phys_memory,
			"max_virtual": sys_monitor_info.max_virt_memory,
			"max_pagefile": sys_monitor_info.max_page_memory,
			"free_physical": sys_monitor_info.free_phys_memory,
			"free_virtual": sys_monitor_info.free_virt_memory,
			"free_pagefile": sys_monitor_info.free_page_memory,
		},
	}
	if(OS.has_feature("editor")):
		monitor_dict.merge({"build_type": "editor"})
	elif(OS.has_feature("debug")):
		monitor_dict.merge({"build_type": "debug"})
	elif(OS.has_feature("release")):
		monitor_dict.merge({"build_type": "release"})
	print(monitor_dict)
