extends Button





func _on_button_up() -> void:
	# clean values
	get_tree().paused = false
	get_tree().reload_current_scene()
