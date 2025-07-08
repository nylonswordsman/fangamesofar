extends Node2D
class_name GUIPanel
var master:GuiMaster
var objID
var Type = "Panel"
@export var BorderWidth = 1
@export var Rect:Rect2i = Rect2i(0,0,75,20)
@export var color:Color =Color.BLACK
var savedColor
@export var Neighbours:Vector4i = Vector4i(-1,-1,-1,-1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master = get_node("/root/main/GUILayer/GUIMaster")
	master.AddElement(self)
	color = master.BackgroundColor
	savedColor = color
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if color!=savedColor:
		queue_redraw()
		savedColor = color
	pass

func _draw() -> void:
	draw_rect(Rect2i(Rect.position,Rect.size),color)
	draw_rect(Rect2i(Rect.position,Rect.size),master.PrimaryColor,false,BorderWidth)
	draw_rect(Rect2i(Rect.position+Vector2i(4,4),Rect.size-Vector2i(8,8)),master.PrimaryColor,false,BorderWidth)
