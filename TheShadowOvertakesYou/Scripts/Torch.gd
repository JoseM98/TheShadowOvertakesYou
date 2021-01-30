extends Area2D

signal torch_picked

func _on_Torch_body_entered(_body: PhysicsBody2D)->void:
	emit_signal("torch_picked")
	queue_free()
