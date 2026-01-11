extends PopupMenu

func _input(event: InputEvent) -> void:
	match event:
		"rightMouse":
			# put popup where mouse is at time of rclick
			position = Vector2i(get_mouse_position())
			# toggle visibility
			visible != visible
