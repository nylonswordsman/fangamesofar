extends Node2D
class_name TextModule

var TextLoaded = false
var LoadedGameText:Dictionary
var font:Font
var textFile:String = "game_english.txt"
var loaderText = "Loading localization file"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	font = ResourceLoader.load("res://GameFont.ttf")
	var json = JSON.new()
	var file = FileAccess.open("res://text/"+textFile, FileAccess.READ)
	var error = FAILED
	if file!=null:
		var text = file.get_as_text()
		file.close()
		error = json.parse(text)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) != TYPE_DICTIONARY:
			loaderText = "Text data wasn't loaded. Unable to continue.\n"
			loaderText += "Parse failure. Unexpected data!"
		else:
			LoadedGameText = data_received
	else:
		loaderText = "Text data wasn't loaded. Unable to continue.\n"
		if file!=null:loaderText += "JSON Parse Error: "+ json.get_error_message()+ " in "+ textFile+ " at line " +str(json.get_error_line())
	if LoadedGameText!=null:TextLoaded = true

func GetLocaleString(input:String) -> String:
	var final = ""
	var keys = input.split(" ")
	for key in keys:
		if LoadedGameText.has(key):final += LoadedGameText.get(key)
		
	return final

func GetLocaleStringFrom(input:String,key:String) -> String:
	var final = ""
	if LoadedGameText.has(input):
		var dict:Dictionary = LoadedGameText.get(input)
		if dict.has(key):final = dict.get(key)
	return final
