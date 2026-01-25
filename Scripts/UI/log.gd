extends VBoxContainer

#fixed your thingm, you'll thank me later - DJ Jio
func _on_terminal_text_submitted(new_text: String) -> void:
	var args = new_text.split(" ") #split the string into an array to allow parameters for commands
	#args[0] - the command
	#args[anything else] - parameters
	match args[0]:
		"cmd":
			print("enter command tree here, but its not gonna be here cuz this is not how terminals work")
		"help":
			%LogText.add_to_log("well thats too bad lmao")
		"?":
			%LogText.add_to_log("well thats too bad lmao")
		"send":
			%LogText.add_to_log(str("sent!"))
		#"rename":
			#args[1] should be the expie's current name
			#args[2] should be the desired name
			#if args[1] == "?", explain this
		_: # < fallback to this if unknown command
			%LogText.add_to_log(str('Unrecognized command: "' + str(args[0]) + '"'))
	%Terminal.clear()
