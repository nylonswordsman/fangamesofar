extends Node2D
class_name GUIImage
var master:GuiMaster
var objID
var Type = "Image"
@export var Rect:Rect2i = Rect2i(0,0,75,20)
@export var color:Color =Color.WHITE
@export var image:Texture2D = ResourceLoader.load("res://Sprites/Language/ta.PNG")
@export var AltValue:bool = false
@export var Neighbours:Vector4i = Vector4i(-1,-1,-1,-1)
var changed:bool = true
var font:Font
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master = get_node("/root/main/GUILayer/GUIMaster")
	master.AddElement(self)
	font = get_node("/root/main/TextModule").font
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if changed:
		queue_redraw()
		changed = false
	pass

func _draw() -> void:
	draw_texture_rect(image,Rect,AltValue,color)
	if master.Debug:
		draw_rect(Rect,Color.RED,false)
