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
				# load Experiment class as variable
				var expieToLoad = ResourceLoader.load("res://Scripts/expies/experiment.tscn")\
				.instantiate()
				# add an Experiment as child
				add_child(expieToLoad)
				print(type_string(typeof(book)))
				expieToLoad.translateBook(book)
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




# just seeing which of these functions are available to me
# probably will not use these, ah... exceedingly poorly optimized solutions.
# i wanna do expie selection at some point
#func _input(event):
	#if event.is_action_pressed("leftMouse"):
		#(get_global_mouse_position())
		#pass
