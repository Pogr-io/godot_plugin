extends Node2D

func _ready():
	PogrSDK.debug()
	#TODO: make method for this PogrSDK singleton wich fires a signal to make the api request
	$CanvasLayer/Flow.play()
