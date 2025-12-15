extends PanelContainer
class_name ExpiePanel

# 0 as placeholder, will be the instance id of the expie this panel
# should be associated with and display the info of
var associatedExpie = 0
#var increment = 1

#func _ready():
	#print("expie panel is ready") # debug, remove before flight
	## connect from the expie class the broadcast id signal to the recieve id
	## in this class, binding to the callable the instance
	#Expie.broadcast_expie_id.connect(_receive_expie_id.bind())

#func _receive_expie_id(emitter):
	#
	## this is accessing the experiment script rather than an individual id.
	## i think
	#
	## change the associated expie to the instance id of whoever emitted the
	## broadcast signal that this panel is listening to
	#associatedExpie = emitter
	#print("expie panel parced entity from recieved id: " + str(associatedExpie))
	#print(associatedExpie.openedBook.expieID, associatedExpie.openedBook.expieName)
	#%Expie1NameLabel.set_text(associatedExpie.openedBook.expieName)

#func _change_expie_name
#func _change_expie_mood
