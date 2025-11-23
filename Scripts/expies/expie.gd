extends Node2D
class_name expie

var aStarNavi = AStar2D.new()
@onready var tML = get_parent()
var selected: bool = false
signal broadcast_expie_id(emitter)

@export var openedBook: Dictionary = {
	"expieID": 0,
	"expieSpecies": "This may take a moment",
	"expieName": "Please wait...",
	"expieStatus": "Reconnecting...",
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
	"helditem": "equipment system not ready",
	"armor": "equipment system not ready",
	"gifts": [0,1,2,3,4,5,6,7],
}

# no need to calculate stats here, thats handled (w/ species mods!) in
# {species}.translateBook()
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
# ^ These stats are outside of the book

func _ready():
	# emit a signal with own instance id (defined at the top) attached
#		broadcast_expie_id.emit(get_instance_id())
		pass

func _input(_event):
	if Input.is_action_just_pressed("QuickSelectExpie1"):
		selected = not selected
	if Input.is_action_pressed("P") and selected == true:
		for point in tML.path:
			pass
		pass
#region debug
#	if Input.is_action_pressed("rightMouse"):
#		broadcast_expie_id.emit(self as Object)
#endregion

func recalculateSubstats(): # called when equipment is changed or on load
	pass

#func _process(_delta: float) -> void:
	#var ae = tML.aStarGrid.get_id_path(Vector2i(0,0),Vector2i(get_global_mouse_position()/17.0))
	#tML.path.clear()
	#for e in ae:
		#tML.path.append(Vector2(e*17.0)+Vector2(6.5,6.5))
	#queue_redraw()

#func _draw() -> void:
	#if tML.path.size()>0:
		#draw_polyline(tML.path,Color.ORANGE,2)
#func _ready():
	# alias because fffFFFFFFUck draw calls
	#var r = tML.aStarGrid.region
	# draw the boundary of the map as a harmless effect for debug purposes
	#draw_rect(Rect2i(Vector2i(r.position.x,r.position.y)*17,Vector2i(r.size.x,r.size.y)*17),Color.RED,false,4)
#func attack():

#func takeDamage():

#func takeHealing():

## make sure the expies manage their status somehow.
