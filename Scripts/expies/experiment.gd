extends expie
class_name Experiment

## experiment *specifically* has a maxHunger of 100
## remove this comment once other species classes are being made
var maxHunger: int = 100

func translateBook(book):
	openedBook = Dictionary(book)
	## experiment *specifically* has basically no species stat mods
	## add a +# or -# after the 5 for other species stat mods
	## remove this comment once other species classes are being made
	STR = 5 + openedBook.get("pointsInSTR")
	DEX = 5 + openedBook.get("pointsInDEX")
	CON = 5 + openedBook.get("pointsInCON")
	INT = 5 + openedBook.get("pointsInINT")
	WIS = 5 + openedBook.get("pointsInWIS")
	CHA = 5 + openedBook.get("pointsInCHA")
	print(openedBook)

func _input(_event):
	if Input.is_action_pressed("rightMouse"):
		broadcast_expie_id.emit(self as Object)
		
