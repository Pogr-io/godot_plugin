extends HTTPRequest

#FIX: random crash after 10 minutes maybe update less monitor values again
var close_request: bool = false
var monitor_dict: Dictionary = {}
var thread: Thread = Thread.new()
var close_thread: Thread = Thread.new()

var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	config.load("res://addons/pogr_plugin/pogr.cfg")
	thread.start(toggle_session)
	thread.wait_to_finish()
	thread.start(monitor_update)

func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().set_auto_accept_quit(false)
		close_thread.start(toggle_session)
		close_thread.wait_to_finish()
		thread.wait_to_finish()
		close_request = true

func toggle_session() -> void:
	request("http://postman-echo.com/get", ["CLIENT_ID: " + config.get_value("api","client_id",""), "BUILD_ID: " + config.get_value("api","build_id","")], HTTPClient.METHOD_GET)

func _on_request_completed(_result, _response_code, _headers, body) -> void:
	var json: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	if(json["headers"]):
		print(json["headers"])
	if(close_request):
		get_tree().quit()

func _on_monitor_timer_timeout() -> void:
	thread.wait_to_finish()
	thread.start(monitor_update)

func exec_sys_info() -> Dictionary:
	var output: Dictionary = {
			"cpu_percent": "unknown",
			"gpu_status": "unknown"
		}
	var cpu_percent: String;
	if (OS.get_name() == "Windows"):
		var cpupercentoutput = []
		OS.execute("wmic",["cpu", "get", "loadpercentage", "/format:csv"],cpupercentoutput,true)
		output.cpu_percent = cpupercentoutput[0].split(",")[2].strip_escapes()
		var gpustatusoutput = []
		OS.execute("wmic",["path", "win32_VideoController", "get", "status"],gpustatusoutput,true)
		output.gpu_status = gpustatusoutput[0].strip_escapes().strip_edges().split("      ")
		var reversed_gpu_statuses: Array # Last GPU is main used GPU
		reversed_gpu_statuses = output.gpu_status
		reversed_gpu_statuses.reverse()
		output.gpu_status = reversed_gpu_statuses[0]
	output.make_read_only()
	return output

func monitor_update() -> void:
	var sys_monitor_info = pogr_plugin.get_sys_monitor_info()

	monitor_dict = {
		"engine": "Godot Engine " + Engine.get_version_info().string,
		"loaded_objects":{
			"all": Performance.get_monitor(Performance.OBJECT_COUNT), 
			"nodes": Performance.get_monitor(Performance.OBJECT_NODE_COUNT),
			"orphan_nodes": Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT),
			"resource": Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT),
			"physics_active": {
					"2d": Performance.get_monitor(Performance.PHYSICS_2D_ACTIVE_OBJECTS),
					"3d": Performance.get_monitor(Performance.PHYSICS_3D_ACTIVE_OBJECTS)
				}
		},
		"os": {
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
			"percentage": exec_sys_info().cpu_percent,
			"process_time":{
				"physics" : Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS),
				"navigation": Performance.get_monitor(Performance.TIME_NAVIGATION_PROCESS)
			},
		},
		"gpu": {
			"name": RenderingServer.get_video_adapter_name(),
			"vendor": RenderingServer.get_video_adapter_vendor(),
			"driver_info": OS.get_video_adapter_driver_info(),
			"api_version": RenderingServer.get_video_adapter_api_version(),
			"frame_process_time": Performance.get_monitor(Performance.TIME_PROCESS),
			"rendered_objects_last_frame": Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME),
			"video_memory_used": Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED),
			"status": exec_sys_info().gpu_status,
			"fps": Performance.get_monitor(Performance.TIME_FPS)
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
