extends Area2D

signal fuel_picked(value)

export (int) var fuel_amount = 20

func _on_Fuel_body_entered(_body):
	emit_signal("fuel_picked",fuel_amount)
	queue_free()
