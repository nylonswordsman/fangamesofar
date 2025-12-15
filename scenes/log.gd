extends VBoxContainer


func _on_log_entry_text_submitted(new_text: String) -> void:
	if new_text.begins_with("cmd ") == true:
		print("enter command tree here")
		%LogEntry.clear()
	else:
		print("non-command input")
		%LogEntry.clear()
