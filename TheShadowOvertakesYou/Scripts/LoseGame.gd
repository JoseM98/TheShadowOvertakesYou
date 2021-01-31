extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var data = get_node("/root/PersistenData")
	data.Stage = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Try_again_button_up():
	get_tree().change_scene("res://Scenes/Levels/LevelComplete.tscn")


func _on_Main_menu_button_up():
	get_tree().change_scene("res://Scenes/Menus/MainMenu.tscn")


func _on_Quit_button_up():
	get_tree().quit()
