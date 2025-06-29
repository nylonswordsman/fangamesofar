extends Camera2D


func _input(event):
	if event.is_action_pressed("W"):
		translate(Vector2(0, -100))
	if event.is_action_pressed("A"):
		translate(Vector2(-100, 0))
	if event.is_action_pressed("S"):
		translate(Vector2(0, 100))
	if event.is_action_pressed("D"):
		translate(Vector2(100, 0))
