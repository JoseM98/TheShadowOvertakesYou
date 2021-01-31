extends Control


func _on_Continue_button_up():
	self.visible = false
	get_parent().paused = false


func _on_Retry_button_up():
	get_parent().paused = false
	get_tree().reload_current_scene()


func _on_Main_screen_button_up():
	get_parent().paused = false
	get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")


func _on_Quit_button_up():
	get_tree().quit()
