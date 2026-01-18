extends PopupMenu

func _input(event: InputEvent):
	if InputEvent.is_action_pressed("rightMouse"):
			print("\a\a\a\a\a")
			# put popup where mouse is at time of rclick
			position = Vector2i(get_mouse_position())
			# toggle visibility
			visible != visible
#			if visible == false:
#				visible = true
#			elif visible == true:
#				visible = false
