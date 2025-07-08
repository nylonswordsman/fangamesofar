extends Node2D
class_name GUILabel
var master:GuiMaster
var objID
var Type = "Label"
@export var Rect:Rect2i = Rect2i(0,0,75,20)
@export var color:Color =Color.WHITE
@export var Text:String = "HELP"
@export var Value:String = "Fuck off piece of shit"
@export var FontSize:int = 16
@export var Neighbours:Vector4i = Vector4i(-1,-1,-1,-1)
@export var AltValue:bool = false
var font:Font
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master = get_node("/root/main/GUILayer/GUIMaster")
	master.AddElement(self)
	font = get_node("/root/main/TextModule").font
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass

func _draw() -> void:
	var text = Value
	var col = color
	if AltValue:
		draw_rect(Rect,master.BackgroundColor)
		text = Text
		col = master.PrimaryColor
	var size = font.get_multiline_string_size(text,HORIZONTAL_ALIGNMENT_CENTER,Rect.size.x,FontSize,-1,\
	TextServer.BREAK_WORD_BOUND,TextServer.JUSTIFICATION_DO_NOT_SKIP_SINGLE_LINE)
	draw_multiline_string(font,Rect.position+Vector2i(0,FontSize),text,HORIZONTAL_ALIGNMENT_CENTER,Rect.size.x,FontSize,\
	-1,col,TextServer.BREAK_WORD_BOUND,TextServer.JUSTIFICATION_DO_NOT_SKIP_SINGLE_LINE)
	
