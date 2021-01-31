extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Continue_button_up():
	get_parent().get_parent().visible = false
	get_parent().get_parent().get_parent().paused = false


func _on_Retry_button_up():
	get_tree().reload_current_scene()


func _on_Main_screen_button_up():
	get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")


func _on_Quit_button_up():
	get_tree().quit()
