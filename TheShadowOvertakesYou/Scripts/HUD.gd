extends CanvasLayer

onready var scene_tree: = get_tree()
onready var pause_overlay: = get_node("UserInterface")
var paused: = false setget set_paused

func _on_Fuel_bar_value_changed(value):
	if value < 99:
		$"Fuel bar/Right end".visible = false
	else:
		$"Fuel bar/Right end".visible = true

func _on_Fuel_fuel_picked(value = 20):
	$"Fuel bar".value += value

func _on_Character_mark_used(marks_left):
	$HBoxContainer.get_child(marks_left).queue_free()


func _on_Character_fuel_used(fuel_left):
	$"Fuel bar".value = fuel_left

# Menu pausa
func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()
