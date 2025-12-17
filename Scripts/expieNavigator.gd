extends Node2D

@export var tML: TileMapLayer

func _process(_delta: float) -> void:
	var ae = tML.aStarGrid.get_id_path(Vector2i(0,0),Vector2i(get_global_mouse_position()/17.0))
	### ^ werdom what does this mean
	tML.path.clear()
	for e in ae: ### wedom what the fucl does this mean
		### wedm what the fuck does ae stand for
		# variable names for the sake of naming it (garbage name)
		# - Dj Jio
		tML.path.append(Vector2(e*17.0)+Vector2(6.5,6.5))
	queue_redraw()

func _draw() -> void:
	# alias because fffFFFFFFUck draw calls
	var region = tML.aStarGrid.region
	# draw the boundary of the map as a harmless effect for debug purposes
	draw_rect(Rect2i(Vector2i(region.position.x,region.position.y)*17,Vector2i(region.size.x,region.size.y)*17),Color.RED,false,4)
	if tML.path.size()>0:
		draw_polyline(tML.path,Color.ORANGE,2)
