extends Node2D
class_name GuiMaster
@export var Debug = true

var font:Font
@export var sfx:Array[AudioStreamPlayer]
@export var Active = true
@export var fadeCruve:Curve
@export var SubLayers:Array[Node]

var GuiClick:float = 0
var GuiLastClick:Vector2
var hoveredID = -1
var lastHover = -1
var heldID = -1
var guiFade = 0
var fadeWait = false
var fadeScene:String
var fadeHide = false
var lastLoaded:String
var fadeLayout:String

var buttonInput = false
var savedMousePos

var InGame = false
var ShowPointer = true
var keepActive = false
var activeLayout = 0
@export var StartIds:Array[int]
@export var ReturnIds:Array[int]

var elements:Dictionary = Dictionary()

var textModule:TextModule

@export var PrimaryColor:Color
@export var SecondaryColor:Color
@export var BackgroundColor:Color
@export var HighlightColor:Color
@export var FlashCurve:Curve

func Fade(playSfx:bool=true) -> void:
	if playSfx:sfx[3].play()
	guiFade = 90
	fadeWait = true
	Active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	textModule = get_node("/root/main/TextModule")
	font = textModule.font
	guiFade = 46
	fadeLayout = "Menu"
	fadeWait = true
	pass # Replace with function body.

func AddElement(element:Node2D) -> void:
	elements.get_or_add(elements.size(),{"path":element.get_path(),"rect":element.Rect,"type":element.Type,"neighbours":element.Neighbours})
	element.objID = elements.size()-1

func FadeToScene(scene:String,hidePointer:bool=false,useGUI:bool=false) -> void:
	keepActive = useGUI
	Fade()
	fadeScene = scene
	fadeHide = hidePointer

func TrashLayoutOne() -> void:
	hoveredID = -1
	heldID = -1
	var gui = SubLayers[0].get_children()
	for element in gui:
		elements.erase(element.objID)
		element.queue_free()

func TrashLayoutTwo() -> void:
	hoveredID = -1
	heldID = -1
	var gui = SubLayers[1].get_children()
	for element in gui:
		elements.erase(element.objID)
		element.queue_free()

func GoToScene(scene:String,hidePointer:bool=false) -> void:
	if scene.begins_with("-"):
		var scn = scene.substr(1,scene.length())
		get_node("/root/"+scn).queue_free()
		TrashLayoutOne()
		LoadLayout("Menu")
		var menu = load("res://menu_node.tscn")
		var menuNode = menu.instantiate()
		get_node("/root/main").add_child(menuNode)
		ShowPointer = !hidePointer
		pass
	else:
		TrashLayoutOne()
		var next_level_resource = load("res://"+scene)
		var next_level = next_level_resource.instantiate()
		get_tree().root.add_child(next_level)
		get_node("/root/main/MenuNode").queue_free()
		InGame = true
		ShowPointer = !hidePointer
		lastLoaded = next_level.name

func LoadLayout(layoutName:String,sublayer:int=0) -> void:
	var Res = ResourceLoader.load("res://GUILayouts/"+layoutName+".tres")
	for element in Res.Elements:
		var node = Node2D.new()
		var script
		match Res.Elements.get(element).get("type"):
			"Button":
				script = ResourceLoader.load("res://Scripts/GUI/gui_button.gd")
			"Slider":
				script = ResourceLoader.load("res://Scripts/GUI/gui_slider.gd")
			"CheckBox":
				script = ResourceLoader.load("res://Scripts/GUI/gui_check_box.gd")
			"List":
				script = ResourceLoader.load("res://Scripts/GUI/gui_list.gd")
			"Panel":
				script = ResourceLoader.load("res://Scripts/GUI/gui_panel.gd")
			"Label":
				script = ResourceLoader.load("res://Scripts/GUI/gui_label.gd")
		node.name = Res.Elements.get(element).get("name")
		node.set_script(script)
		node.Rect = Res.Elements.get(element).get("rect")
		if "Function" in node:node.Function = Res.Elements.get(element).get("func")
		if "FuncNode" in node:node.FuncNode = Res.Elements.get(element).get("funcNode")
		if "FuncParameters" in node:node.FuncParameters = Res.Elements.get(element).get("funcPars")
		if "FontSize" in node:node.FontSize = Res.Elements.get(element).get("fontSize")
		if "Text" in node:node.Text = Res.Elements.get(element).get("text")
		if "AltValue" in node:node.AltValue = Res.Elements.get(element).get("altValue")
		if "color" in node:node.color = Res.Elements.get(element).get("color")
		node.Neighbours = Res.Elements.get(element).get("neighbours")
		SubLayers[sublayer].add_child(node)
		StartIds[sublayer] = Res.startID
		ReturnIds[sublayer] = Res.returnID

func BackToMenu() -> void:
	TogglePause()
	keepActive = false
	InGame = false
	Fade(false)
	fadeScene = "-"+lastLoaded
	fadeHide = false
	pass

func TogglePause() -> void:
	if InGame&&((!Active&&!keepActive)||(keepActive&&get_tree().paused==false)):
		sfx[4].play()
		Active = true
		ShowPointer = true
		LoadLayout("PauseMenu",1)
		activeLayout = 1
		get_tree().paused = true
	elif InGame&&((Active&&!keepActive)||(keepActive&&get_tree().paused==true)):
		sfx[6].play()
		Active = keepActive
		ShowPointer = !fadeHide
		get_tree().paused = false
		activeLayout = 0
		TrashLayoutTwo()

func _input(event: InputEvent) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !textModule.LoadedGameText:
		queue_redraw()
		return
	GuiClick -= delta*4.0
	GuiClick = clampf(GuiClick,0,1)
	
	if guiFade>0: guiFade -=1
	if guiFade==0&&fadeWait:
		Active = true
		fadeWait = false
		if fadeScene!="":
			if !fadeScene.begins_with("-")&&!keepActive:Active = false
			fadeScene = ""
		if fadeLayout!="":
			fadeLayout = ""
	if fadeScene!=""&&guiFade==45:
		GoToScene(fadeScene,fadeHide)
	if fadeLayout!=""&&guiFade==45:
		TrashLayoutOne()
		LoadLayout(fadeLayout)
	
	if Input.is_action_just_pressed("GUIMenu"):TogglePause()
	
	queue_redraw()
	#gui interactions
	
	
	if !Active:
		heldID = -1
		return
	var buttonPressed = false
	if Input.is_action_just_pressed("GUICursorDown"):
		buttonPressed = true
		if hoveredID==-1:hoveredID=StartIds[activeLayout]
		var node = get_node(elements.get(hoveredID).get("path"))
		if node.Neighbours.z==-1:return
		hoveredID = node.Neighbours.z
		sfx[0].play()
	if Input.is_action_just_pressed("GUICursorUp"):
		if hoveredID==-1:hoveredID=StartIds[activeLayout]
		buttonPressed = true
		var node = get_node(elements.get(hoveredID).get("path"))
		if node.Neighbours.x==-1:return
		hoveredID = node.Neighbours.x
		sfx[0].play()
	if Input.is_action_just_pressed("GUICursorLeft"):
		if hoveredID==-1:hoveredID=StartIds[activeLayout]
		buttonPressed = true
		var node = get_node(elements.get(hoveredID).get("path"))
		if node.Neighbours.w==-1:return
		hoveredID = node.Neighbours.w
		sfx[0].play()
	if Input.is_action_just_pressed("GUICursorRight"):
		if hoveredID==-1:hoveredID=StartIds[activeLayout]
		buttonPressed = true
		var node = get_node(elements.get(hoveredID).get("path"))
		if node.Neighbours.y==-1:return
		hoveredID = node.Neighbours.y
		sfx[0].play()
	if Input.is_action_just_pressed("GUICancel"):
		hoveredID = ReturnIds[activeLayout]
		buttonPressed = true
		sfx[0].play()
	
	if buttonPressed:
		buttonInput = true
		savedMousePos=get_viewport().get_mouse_position()
	
	if heldID!=-1:hoveredID=heldID
	var mousePos = get_viewport().get_mouse_position()
	if buttonInput&&mousePos!=savedMousePos:
		buttonInput = false
	if!buttonInput:hoveredID = -1
	var mousePosi:Vector2i = mousePos
	var array = SubLayers[activeLayout].get_children()
	var activeElements:Array
	for item in array:
		activeElements.append(item.objID)
	for element in activeElements:
		if buttonInput:break
		match elements.get(element).get("type"):
			"Button":
				var elRect:Rect2i = elements.get(element).get("rect")
				if elRect.has_point(mousePosi):
					if lastHover != element&&heldID!=element:sfx[0].play()
					hoveredID = element
					lastHover = element
			"Slider":
				var elRect:Rect2i = get_node(elements.get(element).get("path")).Rect
				var SliderR:Rect2i = Rect2i(elRect.position+Vector2i(elRect.size.y,-7.5),Vector2i(8,15))
				if SliderR.has_point(mousePosi):
					if lastHover != element&&heldID!=element:sfx[0].play()
					hoveredID = element
					lastHover = element
			"CheckBox":
				var elRect:Rect2i = Rect2i(elements.get(element).get("rect").position,Vector2i(19,16))
				if elRect.has_point(mousePosi):
					if lastHover != element&&heldID!=element:sfx[0].play()
					hoveredID = element
					lastHover = element
			"List":
				var elRect:Rect2i = elements.get(element).get("rect")
				if elRect.has_point(mousePosi):
					#if lastHover != element:sfx[0].play()
					hoveredID = element
					lastHover = element
					var node = get_node(elements.get(element).get("path"))
					var x = mousePosi.y-elRect.position.y+node.offset
					var ind:int = floori(x/20.0)
					if ind>=node.Items.size():ind=-1
					if ind != node.SelectedItem&&ind!=-1:
						sfx[0].play()
						node.hoverAnim = 0
					node.SelectedItem = ind
				pass
	if hoveredID ==-1:lastHover=-1
	if Input.is_action_just_pressed("GUICursorAction"):
		GuiClick = 1
		GuiLastClick = mousePos
		heldID = hoveredID
		if hoveredID!=-1:
			match elements.get(hoveredID).get("type"):
				"Button":
					sfx[1].play()
					var node = get_node(elements.get(hoveredID).get("path"))
					node.click = 8
					ElementCallFunc(node)
				"Slider":
					var node = get_node(elements.get(hoveredID).get("path"))
					node.offset = mousePos.x-(node.Rect.position.x+node.Rect.size.y)
				"CheckBox":
					var node = get_node(elements.get(hoveredID).get("path"))
					node.click = 8
					if node.Value:sfx[5].play()
					else: sfx[1].play()
					node.Value = !node.Value
					ElementCallFunc(node)
				"List":
					var node = get_node(elements.get(hoveredID).get("path"))
					if node.SelectedItem!=-1:
						node.click = 8
						sfx[1].play()
						node.callable.callv(node.Value)
	if Input.is_action_just_released("GUICursorAction"):heldID = -1

func ElementCallFunc(element:Node2D) -> void:
	if element.Function=="null":return
	var params:Array
	if element.FuncParameters!="":
		var parameters = element.FuncParameters.split(";")
		for par in parameters:
			var values = par.split(",")
			print(values[1])
			if values[1].ends_with("	"):	#        Protection from variable poisoning
				values[1] = values[1].left(-1)#      I dont even fucking know how
			if values[1].ends_with(" "):	#        Protection from variable poisoning AGAIN!!!!!!!!!!!!!!
				values[1] = values[1].left(-1)#      HOW??????????????????????????????????//
			print(type_string(typeof(values[1])))
			match values[1]:
				"string":
					params.append(values[0])
				"bool":
					params.append(values[0]=="true")
				"int":
					params.append(values[0].to_int())
				"float":
					params.append(values[0].to_float())
				"value":
					print(element.Value)
					params.append(element.Value)
	element.callable.callv(params)
	pass

func _draw() -> void:
	if Debug:
		draw_string(font,Vector2(0,16),"DEBUG",0,-1,16,Color.RED)
		draw_string(font,Vector2(0,32),fadeLayout,0,-1,16,Color.RED)
		draw_string(font,Vector2(0,48),str(activeLayout),0,-1,16,Color.RED)
	if guiFade>0:draw_rect(Rect2(0,0,1155,660),Color(0,0,0,fadeCruve.sample((90.0-guiFade)/90.0)))
	if !textModule.LoadedGameText:draw_multiline_string(font,Vector2(0,330-16),textModule.loaderText,HORIZONTAL_ALIGNMENT_CENTER,1155,16,-1,Color.WHITE,TextServer.BREAK_MANDATORY)
	#cursor draw section
	if !ShowPointer||buttonInput:return
	draw_set_transform(get_viewport().get_mouse_position())
	draw_char(font,Vector2(-2,13),"\\")
	draw_circle(-get_viewport().get_mouse_position()+GuiLastClick,(-5+(15*GuiClick)),Color(1,1,1,GuiClick),false,GuiClick)
