extends Node2D

var title = ProjectSettings.get_setting("application/config/name")
@export var currentFloor = 17
#@export var selectedEntity = Node2D

func _process(_delta):
	# fps counter because why not
	DisplayServer.window_set_title(str(title) + " | FPS: " + str(Engine.get_frames_per_second()))
