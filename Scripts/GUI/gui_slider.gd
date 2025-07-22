extends Node2D
class_name GUISlider
var master:GuiMaster
var objID
var Type = "Slider"
@export var Rect:Rect2i = Rect2i(0,0,200,75)
@export var Value:float = 0
@export var Text:String = "Slider"
@export var FontSize:int = 10
@export var Function = "null"
@export var FuncNode = "null"
@export var FuncParameters:String
@export var Neighbours:Vector4i = Vector4i(-1,-1,-1,-1)
var callable:Callable
var selected = false
var held = false
var animations = 0
var hoverAnim = 0
var slideValue = 0
var lastPos = 0
var click = 0
var offset:float
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
	held = master.heldID==objID
	
	if held:
		Rect.size.y = clampi(get_viewport().get_mouse_position().x-Rect.position.x-offset,0,Rect.size.x)
		var floaty:float = Rect.size.y
		Value = floaty/Rect.size.x
		master.ElementCallFunc(self)
		if slideValue<=0:
			master.sfx[2].play()
			slideValue=15
			click=6
		slideValue -= abs(Rect.size.y - lastPos)
		lastPos = Rect.size.y
	else:slideValue = 0
	if selected||held||animations>0:queue_redraw()
	if selected||held:
		animations = hoverAnim+1
		if hoverAnim<12: hoverAnim+=1
	else:
		if hoverAnim>0:hoverAnim-=1
	if click>0:click-=1
	pass

func _draw() -> void:
	draw_set_transform(Rect.position)
	draw_string(master.font,Vector2i(0,-11),Text,1,-1,FontSize)
	draw_line(Vector2(0,0),Vector2(Rect.size.x,0),master.SecondaryColor)
	draw_circle(Vector2(Rect.size.y,0),5,master.BackgroundColor)
	draw_circle(Vector2(Rect.size.y,0),4.5,master.PrimaryColor,false,1)
	if selected||held:
		draw_circle(Vector2(Rect.size.y,0),5,Color(Color.WHITE,\
		master.FlashCurve.sample((hoverAnim/12.0)+(click/6.0))))
		draw_circle(Vector2(Rect.size.y,0),4.5,Color(Color.BLACK,\
		master.FlashCurve.sample((hoverAnim/12.0)+(click/6.0))),false,1)
