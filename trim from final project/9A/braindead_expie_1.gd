extends Node2D


func _ready():
	var expie1Book = load(NodePath("res://data/save1.tres")).expieBooks[0]
	match expie1Book.expieSpecies:
			"Experi.":
				# load an Experiment class as variable
				var expieToLoad = load("res://Scripts/expies/experiment.tscn").instantiate()
				# replace a braindead expie node with an Experiment
				# replaces the braindead expie corresponding to book's expieID
				expieToLoad.set_name("Expie1")
				add_sibling(expieToLoad)
				self.replace_by(expieToLoad, true)
				expieToLoad.translateBook(expie1Book)
				print(%Expie1)
				#self.free()
			"Orange":
				#print(expie1Book)
				pass
			"Milky":
				#print(expie1Book)
				pass
			"Hauler":
				#print(expie1Book)
				pass
			_:
				#print("empty")
				pass
