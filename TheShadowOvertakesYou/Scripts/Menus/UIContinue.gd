extends Button


func _on_Continue_button_up() -> void:
	get_parent().get_parent().visible = false
	get_parent().get_parent().get_parent().paused = false
