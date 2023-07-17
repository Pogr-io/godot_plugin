extends Node2D

func _ready():
	print("DEBUG HERE:")
	pogr_plugin.debug()
	$CanvasLayer/Control/Flow.play()
