extends PanelContainer
class_name ExpiePanel

# 0 as placeholder, will be the instance id of the expie this panel
# should be associated with and display the info of
var associatedExpie = 0
#var increment = 1

func _ready():
	print("expie panel is ready") # debug, remove before flight
	# connect from the expie class the broadcast id signal to the recieve id
	# in this class, binding to the callable the instance
	Expie.broadcast_expie_id.connect(_receive_expie_id.bind())

func _receive_expie_id(emitter: int):
	print("function _recieve_expie_id called") # debug, remove before flight
	print("expie panel recieved an id: " + str(emitter)) # debug, remove before flight
	# change the associated expie to the instance id of whoever emitted the
	# broadcast signal that this panel is listening to
	associatedExpie = instance_from_id(emitter)
	print("expie panel parced entity from recieved id: " + str(associatedExpie))
	if is_instance_valid(associatedExpie) == true:
		print("entity is a valid instance") # debug, remove before flight
		if associatedExpie.is_ancestor_of(Expie) == true:
			print("entity is an expie") # debug, remove before flight
		else:
			print("entity isn't an expie") # debug, remove before flight
		print(associatedExpie.openedBook.expieID, associatedExpie.openedBook.expieName)
		%Expie1NameLabel.set_text(associatedExpie.openedBook.expieName)
	else:
		print("entity isn't a valid instance") # debug, remove before flight

#func _change_expie_name
#func _change_expie_mood
