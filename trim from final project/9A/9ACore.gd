extends Node2D




func _ready():
	## multiple save support is a later thing. for now only save1 is available
	## im lazy. cry about it lmao. ill do it after release probably
	# load save1 resource as a variable
	var currentFile = ResourceLoader.load("res://data//save1.tres")
	# load each expie book in expieBooks and individually iterate through
	# the results in a for loop.
	for book in currentFile.expieBooks:
		match book.expieSpecies:
			"Experi.":
				var expie = ResourceLoader.load("res://Scripts/expies/experiment.tscn")\
				.instantiate() # load Experiment class as variable
				add_child(expie) # add an Experiment as child
				#await expie.askForBook # < this is bad 
				print(type_string(typeof(book)))
				expie.translateBook(book)# There was no need for call func
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
