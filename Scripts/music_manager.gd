extends Node2D

@export var players:Array[AudioStreamPlayer]
var offset = 0

@export var Song:String = "Tenebrous"
@export var Layer:int = 1
var currentLayer:int = 0
@export var Combat:bool = false
@export var Paused:bool = false

var volume:float = 1.0
var combatVolume:float = 0.0
var swappingLayer:bool = false

var pitch:float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentLayer!=Layer:
		if !swappingLayer:
			players[2-offset].stream = ResourceLoader.load("res://assets/Music/"+Song+"Layer"+str(Layer)+"Normal.ogg")
			players[3-offset].stream = ResourceLoader.load("res://assets/Music/"+Song+"Layer"+str(Layer)+"Combat.ogg")
			if !players[2-offset].playing:players[2-offset].play(players[0+offset].get_playback_position())
			if !players[3-offset].playing:players[3-offset].play(players[0+offset].get_playback_position())
			swappingLayer = true
		if Combat&&combatVolume>0:combatVolume-=delta/2.0
		if !Combat&&volume>0:volume-=delta/2.0
		if combatVolume<=0&&volume<=0:
			swappingLayer = false
			players[0-offset].stop()
			players[1-offset].stop()
			currentLayer=Layer
			if offset==0:offset=2
			else:offset=0
			if Combat:combatVolume=1
			else:volume=1
	else:
		if Combat:
			if combatVolume<1:combatVolume+=delta/2.0
			if volume>0:volume-=delta/2.0
		else:
			if volume<1:volume+=delta/2.0
			if combatVolume>0:combatVolume-=delta/2.0
	volume = clampf(volume,0,1)
	combatVolume = clampf(combatVolume,0,1)
	players[0+offset].volume_linear = clampf(volume,0,1)
	players[1+offset].volume_linear = clampf(combatVolume,0,1)
	if !Combat:players[2-offset].volume_linear = clampf(1-volume,0,1)
	else:players[2-offset].volume_linear = clampf(0,0,1)
	if Combat:players[3-offset].volume_linear = clampf(1-combatVolume,0,1)
	else:players[3-offset].volume_linear = clampf(0,0,1)
	
	if Paused&&pitch>0.75:pitch-=delta/2.0
	elif pitch<1.0:pitch+=delta/2.0
	pitch = clampf(pitch,0.75,1.0)
	for player in players:
		player.pitch_scale=pitch
	
	queue_redraw()

func _draw() -> void:
	draw_line(Vector2(0,0),Vector2(100*players[0].volume_linear,0),Color.RED)
	draw_line(Vector2(0,5),Vector2(100*players[1].volume_linear,5),Color.RED)
	draw_line(Vector2(0,10),Vector2(100*players[2].volume_linear,10),Color.RED)
	draw_line(Vector2(0,15),Vector2(100*players[3].volume_linear,15),Color.RED)
	if swappingLayer:draw_circle(Vector2.ZERO,5,Color.RED)
	if offset==0:draw_line(Vector2(0,0),Vector2(0,5),Color.RED)
	else:draw_line(Vector2(0,10),Vector2(0,15),Color.RED)
