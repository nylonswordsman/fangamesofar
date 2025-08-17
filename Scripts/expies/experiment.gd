extends Node2D
class_name Experiment

var astarnavi = AStar2D.new()

@export var openedBook: Dictionary = {
	"expieSpecies": "None",
	"expieName": "Nu",
	"currentMood": 5,
	"currentHunger": 5,
	"pointsInSTR": 5,
	"pointsInDEX": 5,
	"pointsInCON": 5,
	"pointsInINT": 5,
	"pointsInWIS": 5,
	"pointsInCHA": 5,
	"currentOverallIntegrity": 5,
	"currentHeadIntegrity": 5,
	"currentTorsoIntegrity": 5,
	"currentLArmIntegrity": 5,
	"currentRArmIntegrity": 5,
	"currentLLegIntegrity": 5,
	"currentRLegIntegrity": 5,
	"weapon": "equipment system not ready",
	"armor": "equipment system not ready",
	"gifts": [0,1,2,3,4,5,6,7],
}

var maxHunger: int = 100
var STR: int = 5
var DEX: int = 5
var CON: int = 5
var INT: int = 5
var WIS: int = 5
var CHA: int = 5
var maxOverallIntegrity: int = 120+(CON*20)
var maxHeadIntegrity: int = 40+(CON*4)
var maxTorsoIntegrity: int = 60+(CON*6)
var maxLArmIntegrity: int = 20+(CON*4)
var maxRArmIntegrity: int = 20+(CON*4)
var maxLLegIntegrity: int = 30+(CON*6)
var maxRLegIntegrity: int = 30+(CON*6)
# The only stats outside of the book
func translateBook(book):
	openedBook = Dictionary(book) # absolutely no need for set func
	## add a + or - after the 5 for other species stat mods
	## remove this comment once other species classes are being made
	STR = 5 + openedBook.get("pointsInSTR")
	DEX = 5 + openedBook.get("pointsInDEX")
	CON = 5 + openedBook.get("pointsInCON")
	INT = 5 + openedBook.get("pointsInINT")
	WIS = 5 + openedBook.get("pointsInWIS")
	CHA = 5 + openedBook.get("pointsInCHA")

func _input(event):
	if event.is_action_pressed("rightArrow"):



		print(openedBook.get("expieName"))
func recalculateSubstats(): # called when equipment is changed or on load
	pass

#func attack():

#func takeDamage():

#func takeHealing():



## make sure the expies manage their status with getters and setters
