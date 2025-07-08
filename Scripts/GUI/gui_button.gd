extends Node2D
class_name GUIButton
var master:GuiMaster
var objID
var Type = "Button"
@export var Rect:Rect2i = Rect2i(0,0,75,20)
@export var BorderWidth = 1
@export var Text:String = "Button"
@export var FontSize:int = 16
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
	colorCurve.add_point(Vector2(0,1))
	colorCurve.add_point(Vector2(0.5,0))
	colorCurve.add_point(Vector2(1,1))
	master = get_node("/root/main/GUILayer/GUIMaster")
	master.AddElement(self)
	if typeof(FuncNode)==4:
		if FuncNode == "master": FuncNode = master.get_path()
		elif FuncNode == "null": return
	callable = Callable.create(get_node(FuncNode),Function)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	if !selected&&animations>0: animations-=1
	if click>0:click-=1
	pass

func _draw() -> void:
	draw_rect(Rect,master.BackgroundColor)
	draw_rect(Rect,master.PrimaryColor,false,BorderWidth)
	draw_string(master.font,Rect.position+Vector2i(0,(Rect.size.y/2)+master.font.get_string_size(Text,1,-1,FontSize).y/4),\
	Text,1,Rect.size.x,FontSize,master.PrimaryColor)
	if selected:
		draw_rect(Rect,Color(master.HighlightColor,master.FlashCurve.sample((hoverAnim/12.0)+(click/8.0))))
		draw_rect(Rect,Color(master.HighlightColor,master.FlashCurve.sample((hoverAnim/12.0)+(click/8.0))),false,BorderWidth)
		draw_string(master.font,Rect.position+Vector2i(0,(Rect.size.y/2)+master.font.get_string_size(Text,1,-1,FontSize).y/4),\
		Text,1,Rect.size.x,FontSize,Color(Color.BLACK,master.FlashCurve.sample((hoverAnim/12.0)+(click/8.0))))
