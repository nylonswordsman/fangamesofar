extends Node2D
class_name GUICheckbox
var master:GuiMaster
var objID
var Type = "CheckBox" 
@export var Rect:Rect2i = Rect2i(0,0,0,0)
@export var Value = false
@export var Text:String = "Settings"
@export var FontSize:int = 10
@export var Function = "null"
@export var FuncNode = "null"
@export var FuncParameters:String
@export var Neighbours:Vector4i = Vector4i(-1,-1,-1,-1)
var callable:Callable
var selected = false
var animations = 0
var hoverAnim = 0
var colorAnim = 0
var click = 0
var colorCurve:Curve = Curve.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colorCurve.add_point(Vector2(0,0))
	colorCurve.add_point(Vector2(0.5,1))
	colorCurve.add_point(Vector2(1,0))
	master = get_node("/root/main/GUILayer/GUIMaster")
	master.AddElement(self)
	if typeof(FuncNode)==4:
		if FuncNode == "master": FuncNode = master.get_path()
		elif FuncNode == "null": return
	callable = Callable(get_node(FuncNode),Function)
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	selected = master.hoveredID==objID
	if selected||animations>0:queue_redraw()
	if selected:
		animations = hoverAnim+1
		if hoverAnim<12: hoverAnim+=1
		else: colorAnim +=1
		if colorAnim>30:colorAnim=0
	else:
		if hoverAnim>0:hoverAnim-=1
		colorAnim = 0
	if click>0:click-=1
	pass

func _draw() -> void:
	draw_set_transform(Rect.position)
	draw_string(master.font,Vector2i(21,master.font.get_string_size(Text,0,-1,FontSize).y/1.5+1),\
	Text,1,-1,FontSize,master.PrimaryColor)
	var size = master.font.get_string_size("[X]",HORIZONTAL_ALIGNMENT_CENTER,-1,12)
	draw_rect(Rect2(Vector2.ZERO,Vector2(19,16)),master.SecondaryColor)
	if Value: 
		draw_string(master.font,Vector2i(-2,size.y/1.5),"[X]",HORIZONTAL_ALIGNMENT_CENTER,\
		-1,12,master.PrimaryColor)
	else: 
		draw_string(master.font,Vector2i(-2,size.y/1.5),"[ ]",HORIZONTAL_ALIGNMENT_CENTER,\
		-1,12,master.PrimaryColor)
	if selected:
		draw_rect(Rect2(Vector2.ZERO,Vector2(19,16)),Color(Color.WHITE,\
		master.FlashCurve.sample((hoverAnim/12.0)+(click/8.0))))
		if Value: 
			draw_string(master.font,Vector2i(-2,size.y/1.5),"[X]",HORIZONTAL_ALIGNMENT_CENTER,\
			-1,12,Color(Color.BLACK,master.FlashCurve.sample((hoverAnim/12.0)+(click/8.0))))
		else: 
			draw_string(master.font,Vector2i(-2,size.y/1.5),"[ ]",HORIZONTAL_ALIGNMENT_CENTER,\
			-1,12,Color(Color.BLACK,master.FlashCurve.sample((hoverAnim/12.0)+(click/8.0))))
