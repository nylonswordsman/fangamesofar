extends Node2D

@export var tML: TileMapLayer

func _process(_delta: float) -> void:
	# the below line is really annoying it spams errors every milisecond when your mouse
	# is out of bounds and floods the debugger
	var wholePath = tML.aStarGrid.get_id_path(Vector2i(0,0),Vector2i(get_global_mouse_position()/17.0))
	tML.path.clear()
	for point in wholePath:
		tML.path.append(Vector2(point*17.0)+Vector2(6.5,6.5))
	queue_redraw()

func _draw() -> void:
	# alias because fffFFFFFFUck draw calls
	var region = tML.aStarGrid.region
	# draw the boundary of the map as a harmless effect for debug purposes
	draw_rect(Rect2i(Vector2i(region.position.x,region.position.y)*17,Vector2i(region.size.x,region.size.y)*17),Color.RED,false,4)
	if tML.path.size()>0:
		draw_polyline(tML.path,Color.ORANGE,2)

func _input(event: InputEvent):
	if Input.is_action_just_pressed("M"):
		var selectedEntity = instance_from_id(tML.selectedEntity)
		if tML.selectedEntity.get_base_script() == expie:
			selectedEntity.move(tML.path)
