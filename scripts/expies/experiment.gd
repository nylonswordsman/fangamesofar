extends Node2D
class_name Experiment

@export var openedBook: Dictionary = {
	"expieSpecies": "fuck",
	"expieName": "fuck",
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
	"weapon": "fuck",
	"armor": "fuck",
	"gifts": [0,1,2,3,4,5,6,7],
}

var expieSpecies: String = "Experi."
var expieName: String = "blank"
var currentMood: int # no maxMood because max mood is 200 for all species
var currentHunger: int
var maxHunger: int = 100
# given before most other things
var pointsInSTR: int # points from player in stats
var pointsInDEX: int # points from player in stats
var pointsInCON: int # points from player in stats
var pointsInINT: int # points from player in stats
var pointsInWIS: int # points from player in stats
var pointsInCHA: int # points from player in stats
## add a + or - after the 5 for other species stat mods
## remove this comment once other species classes are being made
var STR: int = 5+pointsInSTR # final stats
var DEX: int = 5+pointsInDEX # final stats
var CON: int = 5+pointsInCON # final stats
var INT: int = 5+pointsInINT # final stats
var WIS: int = 5+pointsInWIS # final stats
var CHA: int = 5+pointsInCHA # final stats
var currentOverallIntegrity: int
var currentHeadIntegrity: int
var currentTorsoIntegrity: int
var currentLArmIntegrity: int
var currentRArmIntegrity: int
var currentLLegIntegrity: int
var currentRLegIntegrity: int
var maxOverallIntegrity: int = 120+(CON*20)
var maxHeadIntegrity: int = 40+(CON*4)
var maxTorsoIntegrity: int = 60+(CON*6)
var maxLArmIntegrity: int = 20+(CON*4)
var maxRArmIntegrity: int = 20+(CON*4)
var maxLLegIntegrity: int = 30+(CON*6)
var maxRLegIntegrity: int = 30+(CON*6)
var weapon = "placeholder"
var armor = "placeholder"
var gifts = [0,1,2,3,4,5,6,7]
# substats are only calculated when they are used


signal askForBook


func translateBook(book):
	openedBook = Dictionary(book) # absolutely no need for set func



func _input(event):
	if event.is_action_pressed("upArrow"):
		emit_signal("askForBook")
	if event.is_action_pressed("rightArrow"):
		print(expieName)
	if event.is_action_pressed("downArrow"):
		set("expieName", String(openedBook.expieName))



func recalculateSubstats(): # called when equipment is changed or on load
	pass

#func attack():

#func takeDamage():

#func takeHealing():



## make sure the expies manage their status with getters and setters
