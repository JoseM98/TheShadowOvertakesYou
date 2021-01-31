extends Area2D



func _on_Exit_Door_body_entered(body):
	get_tree().change_scene("res://Scenes/Menus/WinGame.tscn")
