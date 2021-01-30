extends Area2D

signal torch_picked

func _on_Torch_body_entered(body: PhysicsBody2D)->void:
	print("Collision with:", body.name)
	emit_signal("torch_picked")
	queue_free()
