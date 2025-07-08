extends Node2D
class_name GUIList
var master:GuiMaster
var objID
var Type:String = "List"
@export var Rect:Rect2i = Rect2i(0,0,100,300)
@export var BorderWidth = 2
@export var Items:Array[String]
@export var Function:String = "null"
@export var FuncNode:String = "null"
@export var AltValue:bool = false
@export var Neighbours:Vector4i = Vector4i(-1,-1,-1,-1)
var Value
var region:Node2D
var offset:float = 0.0
var desiredOffset:float = 0.0
var callable:Callable
var selected = false
var animations:int = 0
var hoverAnim:int = 0
var colorAnim:int = 0
var click:int = 0
var SelectedItem:int = 0
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
	var node = Node2D.new()
	node.set_script(ResourceLoader.load("res://Scripts/GUI/gui_list_text.gd"))
	add_child(node)
	node.position = Vector2.ZERO
	region=node
	node.list = self
	print(node)
	callable = Callable(get_node(FuncNode),Function)
	clip_children = CanvasItem.CLIP_CHILDREN_AND_DRAW
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	selected = master.hoveredID==objID
	if !selected:SelectedItem=-1
	if SelectedItem!=-1:
		if AltValue:Value = SelectedItem
		else:Value = Items[SelectedItem]
	if selected||animations>0:
		queue_redraw()
	if hoverAnim==0:colorAnim=0
	if selected:
		animations = hoverAnim+1
		if hoverAnim<12: hoverAnim+=1
		else: colorAnim +=1
		if colorAnim>30:colorAnim=0
		var maxoffset = 0
		if Items.size()*20+16>Rect.size.y:maxoffset = (Items.size()*20+16)-Rect.size.y
		if Input.is_action_just_pressed("GUIScrollDown")&&desiredOffset<maxoffset:
			desiredOffset+=20.0
			master.sfx[2].play()
		if Input.is_action_just_pressed("GUIScrollUp")&&desiredOffset>0:
			desiredOffset-=20.0
			master.sfx[2].play()
		desiredOffset = clampf(desiredOffset,0,maxoffset)
	else:
		if hoverAnim>0:hoverAnim-=1
		colorAnim = 0
	if !selected&&animations>0: animations-=1
	if click>0:click-=1
	
	offset = lerpf(offset,desiredOffset,0.2)
	pass

func _draw() -> void:
	var animSize = clamp(hoverAnim,0,6)+click
	draw_rect(Rect2i(Rect.position,Rect.size),Color.BLACK)
	draw_rect(Rect2i(Rect.position,Rect.size),Color.WHITE,false,BorderWidth)
	
