extends CanvasLayer

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
