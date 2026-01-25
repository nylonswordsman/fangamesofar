extends Label
class_name log_message

func _ready():
	#theme_type_variation = 
	custom_minimum_size = Vector2(286,4)

func add_to_log(outputText=str):
	text += "\n>> " + outputText
