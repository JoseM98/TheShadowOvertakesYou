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


func _on_Play_button_up():
	get_tree().change_scene("res://Scenes/Levels/LevelComplete.tscn")


func _on_Quit_button_up():
	get_tree().quit()


func _on_Controls_button_up():
	get_tree().change_scene("res://Scenes/Menus/ControlsMenu.tscn")
