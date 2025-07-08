extends Node2D

var master
@export var parameterPanel:Control
var Layout = "NEW"
var ShowParameters = false
var selectedID = -1
@export var layoutName:LineEdit
@export var lineEdits:Array[LineEdit]
@export var fontSize:SpinBox
@export var parameterEdit:TextEdit
@export var checkboxes:Array[CheckBox]
@export var colorPick:ColorPickerButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master = get_node("/root/main/GUILayer/GUIMaster")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if selectedID!=-1&&Input.is_action_just_pressed("GUIEditToggleParameters")&&!ShowParameters:
		var node = get_node(master.elements.get(selectedID).get("path"))
		lineEdits[0].text = node.name
		if "Text" in node:
			lineEdits[1].visible = true
			lineEdits[1].text = node.Text
		else:lineEdits[1].visible = false
		if "Function" in node:
			lineEdits[2].visible = true
			lineEdits[2].text = node.Function
		else:lineEdits[2].visible = false
		if "FuncNode" in node:
			lineEdits[3].visible = true
			lineEdits[3].text = node.FuncNode
		else:lineEdits[3].visible = false
		if "FontSize" in node:
			fontSize.visible = true
			fontSize.value = node.FontSize
		else: fontSize.visible = false
		if "FuncParameters" in node:
			parameterEdit.visible = true
			parameterEdit.text = node.FuncParameters
		else:parameterEdit.visible = false
		if "AltValue" in node:
			checkboxes[0].visible = true
			checkboxes[0].button_pressed = node.AltValue
		else: checkboxes[0].visible = false
		if "color" in node:
			colorPick.visible = true
			colorPick.color = node.color
		else:colorPick.visible = false
		ShowParameters = true
	elif selectedID!=-1&&Input.is_action_just_pressed("GUIEditToggleParameters")&&ShowParameters:
		var node = get_node(master.elements.get(selectedID).get("path"))
		node.name = lineEdits[0].text
		if "Text" in node:node.Text = lineEdits[1].text
		if "Function" in node:node.Function = lineEdits[2].text
		if "FuncNode" in node:node.FuncNode = lineEdits[3].text
		if "FontSize" in node:node.FontSize = fontSize.value
		if "FuncParameters" in node:node.FuncParameters = parameterEdit.text
		if "AltValue" in node:node.AltValue = checkboxes[0].button_pressed
		if "color" in node:node.color = colorPick.color
		node.queue_redraw()
		master.elements.get(selectedID).erase("path")
		master.elements.get(selectedID).get_or_add("path",node.get_path())
		ShowParameters = false
	parameterPanel.visible = ShowParameters
	if ShowParameters:
		queue_redraw()
		return
	
	if Input.is_action_just_pressed("GUIEditNextItem"):selectedID+=1
	if Input.is_action_just_pressed("GUIEditPrevItem"):selectedID-=1
	selectedID = clamp(selectedID,-1,master.elements.size()-1)
	
	
	if Input.is_action_just_pressed("GUIEditButton"):
		var node = Node2D.new()
		var script = ResourceLoader.load("res://Scripts/GUI/gui_button.gd")
		node.name = "New Button"
		node.set_script(script)
		get_node("CanvasLayer").add_child(node)
	
	if Input.is_action_just_pressed("GUIEditCheckBox"):
		var node = Node2D.new()
		var script = ResourceLoader.load("res://Scripts/GUI/gui_check_box.gd")
		node.name = "New CheckBox"
		node.set_script(script)
		get_node("CanvasLayer").add_child(node)
	
	if Input.is_action_just_pressed("GUIEditSlider"):
		var node = Node2D.new()
		var script = ResourceLoader.load("res://Scripts/GUI/gui_slider.gd")
		node.name = "New Slider"
		node.set_script(script)
		get_node("CanvasLayer").add_child(node)
	if Input.is_action_just_pressed("GUIEditList"):
		var node = Node2D.new()
		var script = ResourceLoader.load("res://Scripts/GUI/gui_list.gd")
		node.name = "New List"
		node.set_script(script)
		get_node("CanvasLayer").add_child(node)
	if Input.is_action_just_pressed("GUIEditPanel"):
		var node = Node2D.new()
		var script = ResourceLoader.load("res://Scripts/GUI/gui_panel.gd")
		node.name = "New Panel"
		node.set_script(script)
		get_node("CanvasLayer").add_child(node)
	if Input.is_action_just_pressed("GUIEditLabel"):
		var node = Node2D.new()
		var script = ResourceLoader.load("res://Scripts/GUI/gui_label.gd")
		node.name = "New Label"
		node.set_script(script)
		get_node("CanvasLayer").add_child(node)
	
	
	if !ShowParameters&&Input.is_action_just_pressed("GUIEditClear"):
		selectedID=-1
		var gui = get_node("CanvasLayer").get_children()
		for element in gui:
			master.elements.erase(element.objID)
			element.queue_free()
	
	if !ShowParameters&&layoutName.text!=""&&Input.is_action_just_pressed("GUIEditSave"):
		Layout = layoutName.text
		var gui = get_node("CanvasLayer").get_children()
		var Res = ResourceLoader.load("res://GUILayouts/LayoutTemplate.tres").duplicate()
		for element in gui:
			var elDict = Dictionary()
			elDict.get_or_add("name",element.name)
			if "Text" in element:elDict.get_or_add("text",element.Text)
			elDict.get_or_add("type",element.Type)
			elDict.get_or_add("rect",element.Rect)
			if "FontSize" in element:elDict.get_or_add("fontSize",element.FontSize)
			if "Function" in element:elDict.get_or_add("func",element.Function)
			if "FuncNode" in element:elDict.get_or_add("funcNode",element.FuncNode)
			if "FuncParameters" in element:elDict.get_or_add("funcPars",element.FuncParameters)
			if "AltValue" in element:elDict.get_or_add("altValue",element.AltValue)
			if "color" in element:elDict.get_or_add("color",element.color)
			elDict.get_or_add("neighbours",element.Neighbours)
			Res.Elements.get_or_add(gui.find(element),elDict)
		ResourceSaver.save(Res,"res://GUILayouts/"+Layout+".tres",ResourceSaver.FLAG_NONE)
	
	if !ShowParameters&&Input.is_action_just_pressed("GUIEditLoad"):
		Layout = layoutName.text
		selectedID=-1
		var gui = get_node("CanvasLayer").get_children()
		for element in gui:
			master.elements.erase(element.objID)
			element.queue_free()
		var Res = ResourceLoader.load("res://GUILayouts/"+Layout+".tres")
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

			node.name = Res.Elements.get(element).get("name")
			node.set_script(script)
			node.Rect = Res.Elements.get(element).get("rect")
			node.z_index = -10
			node.show_behind_parent = true
			node.z_as_relative = false
			if "Function" in node:node.Function = Res.Elements.get(element).get("func")
			if "FuncNode" in node:node.FuncNode = Res.Elements.get(element).get("funcNode")
			if "FuncParameters" in node:node.FuncParameters = Res.Elements.get(element).get("funcPars")
			if "FontSize" in node:node.FontSize = Res.Elements.get(element).get("fontSize")
			if "Text" in node:node.Text = Res.Elements.get(element).get("text")
			if "AltValue" in node:node.AltValue = Res.Elements.get(element).get("altValue")
			if "color" in node:node.color = Res.Elements.get(element).get("color")
			node.Neighbours = Res.Elements.get(element).get("neighbours")
			get_node("CanvasLayer").add_child(node)
	
	queue_redraw()
	if selectedID==-1||ShowParameters:return
	
	if Input.is_action_just_pressed("GUIEditDelete"):
		var node = get_node(master.elements.get(selectedID).get("path"))
		selectedID=-1
		master.elements.erase(node.objID)
		node.queue_free()
	
	var mod = 1
	if Input.is_key_pressed(KEY_SHIFT):mod = 5
	var node = get_node(master.elements.get(selectedID).get("path"))
	if Input.is_action_just_pressed("GUIEditMoveUp")||(mod==5&&Input.is_action_pressed("GUIEditMoveUp")):
		
		node.Rect = Rect2i(node.Rect.position+Vector2i(0,-1*mod),node.Rect.size)
		node.queue_redraw()
	if Input.is_action_just_pressed("GUIEditMoveDown")||(mod==5&&Input.is_action_pressed("GUIEditMoveDown")):
		
		node.Rect = Rect2i(node.Rect.position+Vector2i(0,1*mod),node.Rect.size)
		node.queue_redraw()
	if Input.is_action_just_pressed("GUIEditMoveRight")||(mod==5&&Input.is_action_pressed("GUIEditMoveRight")):
		
		node.Rect = Rect2i(node.Rect.position+Vector2i(1*mod,0),node.Rect.size)
		node.queue_redraw()
	if Input.is_action_just_pressed("GUIEditMoveLeft")||(mod==5&&Input.is_action_pressed("GUIEditMoveLeft")):
		
		node.Rect = Rect2i(node.Rect.position+Vector2i(-1*mod,0),node.Rect.size)
		node.queue_redraw()
	
	if Input.is_action_just_pressed("GUIEditSizeUp")||(mod==5&&Input.is_action_pressed("GUIEditSizeUp")):
		
		node.Rect = Rect2i(node.Rect.position,node.Rect.size+Vector2i(0,1))
		node.queue_redraw()
	if Input.is_action_just_pressed("GUIEditSizeDown")||(mod==5&&Input.is_action_pressed("GUIEditSizeDown")):
		
		node.Rect = Rect2i(node.Rect.position,node.Rect.size+Vector2i(0,-1))
		node.queue_redraw()
	if Input.is_action_just_pressed("GUIEditSizeRight")||(mod==5&&Input.is_action_pressed("GUIEditSizeRight")):
		
		node.Rect = Rect2i(node.Rect.position,node.Rect.size+Vector2i(1,0))
		node.queue_redraw()
	if Input.is_action_just_pressed("GUIEditSizeLeft")||(mod==5&&Input.is_action_pressed("GUIEditSizeLeft")):
		
		node.Rect = Rect2i(node.Rect.position,node.Rect.size+Vector2i(-1,0))
		node.queue_redraw()
	
	if Input.is_action_just_pressed("GUIEditNBUp+"):
		node.Neighbours.x +=1
		node.Neighbours.x = clamp(node.Neighbours.x,-1,master.elements.size()-1)
	if Input.is_action_just_pressed("GUIEditNBUp-"):
		node.Neighbours.x -=1
		node.Neighbours.x = clamp(node.Neighbours.x,-1,master.elements.size()-1)
	
	if Input.is_action_just_pressed("GUIEditNBRight+"):
		node.Neighbours.y +=1
		node.Neighbours.y = clamp(node.Neighbours.y,-1,master.elements.size()-1)
	if Input.is_action_just_pressed("GUIEditNBRight-"):
		node.Neighbours.y -=1
		node.Neighbours.y = clamp(node.Neighbours.y,-1,master.elements.size()-1)
	
	if Input.is_action_just_pressed("GUIEditNBDown+"):
		node.Neighbours.z +=1
		node.Neighbours.z = clamp(node.Neighbours.z,-1,master.elements.size()-1)
	if Input.is_action_just_pressed("GUIEditNBDown-"):
		node.Neighbours.z -=1
		node.Neighbours.z = clamp(node.Neighbours.z,-1,master.elements.size()-1)
	
	if Input.is_action_just_pressed("GUIEditNBLeft+"):
		node.Neighbours.w +=1
		node.Neighbours.w = clamp(node.Neighbours.w,-1,master.elements.size()-1)
	if Input.is_action_just_pressed("GUIEditNBLeft-"):
		node.Neighbours.w -=1
		node.Neighbours.w = clamp(node.Neighbours.w,-1,master.elements.size()-1)
	
	pass

func _draw() -> void:
	draw_string(master.font,Vector2(0,16),"CURRENT LAYOUT: "+Layout)
	if selectedID != -1:
		var node = get_node(master.elements.get(selectedID).get("path"))
		var rect = node.Rect
		var Rect:Rect2i
		match master.elements.get(selectedID).get("type"):
			"Button":
				Rect = Rect2(rect.position+Vector2i(-4,-4),rect.size+Vector2i(8,8))
				draw_rect(Rect,Color.RED,false,1)
			"Slider":
				Rect = Rect2(rect.position+Vector2i(-4,-4-7.5),Vector2i(rect.size.x+8,15+8))
				draw_rect(Rect,Color.RED,false,1)
			"CheckBox":
				Rect = Rect2(rect.position+Vector2i(-9,-9),Vector2i(10+8,10+8))
				draw_rect(Rect,Color.RED,false,1)
			"List":
				Rect = Rect2(rect.position+Vector2i(-4,-4),rect.size+Vector2i(8,8))
				draw_rect(Rect,Color.RED,false,1)
		if node.Neighbours.x!=-1:
			var points:Array[Vector2i]
			var nNode = get_node(master.elements.get(node.Neighbours.x).get("path"))
			points.append(Rect.position+Vector2i((Rect.size.x/2),0))
			if nNode.Rect.position.y>=Rect.position.y:points.append(Rect.position+Vector2i((Rect.size.x/2)+8,-8))
			points.append(nNode.Rect.position)
			draw_polyline(points,Color.RED,2)
			draw_circle(nNode.Rect.position,2,Color.RED)
		if node.Neighbours.y!=-1:
			var points:Array
			var nNode = get_node(master.elements.get(node.Neighbours.y).get("path"))
			points.append(Rect.position+Vector2i((Rect.size.x),(Rect.size.y/2.0)))
			if nNode.Rect.position.x<=Rect.position.x:points.append(Rect.position+Vector2i((Rect.size.x)+8,(Rect.size.y/2)+8))
			points.append(nNode.Rect.position)
			draw_polyline(points,Color.RED)
		if node.Neighbours.z!=-1:
			var points:Array
			var nNode = get_node(master.elements.get(node.Neighbours.z).get("path"))
			points.append(Rect.position+Vector2i((Rect.size.x/2),Rect.size.y))
			if nNode.Rect.position.y<=Rect.position.y:points.append(Rect.position+Vector2i((Rect.size.x/2)-8,Rect.size.y+8))
			points.append(nNode.Rect.position)
			draw_polyline(points,Color.RED)
		if node.Neighbours.w!=-1:
			var points:Array
			var nNode = get_node(master.elements.get(node.Neighbours.w).get("path"))
			points.append(Rect.position+Vector2i(0,(Rect.size.y/2.0)))
			if nNode.Rect.position.x>=Rect.position.x:points.append(Rect.position+Vector2i(-8,(Rect.size.y/2)+8))
			points.append(nNode.Rect.position)
			draw_polyline(points,Color.RED)
		
		var offset:int = 0
		if rect.position.x>577:
			offset = master.font.get_string_size(str(rect),0,-1,10).x- rect.size.x
		draw_string(master.font,rect.position+Vector2i(0-offset,-10),str(rect),HORIZONTAL_ALIGNMENT_LEFT,-1,10)
		draw_string(master.font,rect.position+Vector2i(0-offset,-20),str(node.objID),HORIZONTAL_ALIGNMENT_LEFT,-1,10)
