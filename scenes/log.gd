extends VBoxContainer

#fixed your thingm, you'll thank me later - DJ Jio
func _on_log_entry_text_submitted(new_text: String) -> void:
	var args = new_text.split(" ") #split the string into an array to allow parameters for commands
	#args[0] - the command
	#args[anything else] - parameters
	match args[0]: #please use match from now on, for my sanity
		"cmd":
			print("enter command tree here, but its not gonna be here cuz this is not how terminals work")
		"help":
			print("enter command tree here")
		_: # < fallback to this if unknown command
			print("non-command input")
	%LogEntry.clear()
