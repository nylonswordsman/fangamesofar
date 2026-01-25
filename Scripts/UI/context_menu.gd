extends PopupMenu

func _input(event: InputEvent):
	if Input.is_action_pressed("rightMouse"):
			# put popup where mouse is at time of rclick
			position = Vector2i(get_mouse_position())
			# toggle visibility
			visible = not visible
#			if visible == false:
#				visible = true
#			elif visible == true:
#				visible = false
