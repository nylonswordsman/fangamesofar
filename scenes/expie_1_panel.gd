extends PanelContainer

func _ready():
	expie.broadcast_expie_id.connect(_receive_expie_id)

func _receive_expie_id(id_speaking, id_holder):
	if id_speaking == 1:
		pass

#func _change_expie_name
#func _change_expie_mood
