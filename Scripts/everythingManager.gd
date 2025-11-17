extends Node2D

var title = ProjectSettings.get_setting("application/config/name")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	DisplayServer.window_set_title(str(title) + " | FPS: " + str(Engine.get_frames_per_second()))
