extends CanvasLayer


func _on_Light_bar_value_changed(value):
	if value < 99:
		$"Fuel bar/Right end".visible = false
	else:
		$"Fuel bar/Right end".visible = true
