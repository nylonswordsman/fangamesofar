extends Node2D
var ran = false
func _process(delta: float) -> void:
	if !get_node("/root/main/TextModule").TextLoaded||ran:return
	var node = get_node("/root/main/GUILayer/GUIMaster/GUISubLayer/ListTesting")
	for x in range(0,50):
		node.Items.append("ITEM"+str(x))
	ran = true
	pass
