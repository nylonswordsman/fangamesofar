extends Node2D


func _input(event):
	if event.is_action_pressed("leftArrow"):
		call("readExpieBooks")

func readExpieBooks():
	## multiple save support is a later thing. for now only save1 is available
	## im lazy. cry about it lmao. ill do it after release probably
	# load save1 resource as a variable
	var currentFile = ResourceLoader.load("res://data//save1.tres")
	# load each expie book in expieBooks and individually iterate through
	# the results in a for loop.
	for book in currentFile.expieBooks:
		match book.expieSpecies:
			"Experi.":
				var expie = ResourceLoader.load("res://scripts/expies/experiment.tscn")\
				.instantiate() # load Experiment class as variable
				add_child(expie) # add an Experiment as child
				await expie.askForBook
				call(expie.translateBook(book))
				#set("expie.openedBook", Dictionary(book))
			"Orange":
				#print(book)
				pass
			"Milky":
				#print(book)
				pass
			"Hauler":
				#print(book)
				pass
			_:
				#print("empty")
				pass


## have a bunch of the newly created expie object's variables overwritten
## by the contents of book in params of this function
