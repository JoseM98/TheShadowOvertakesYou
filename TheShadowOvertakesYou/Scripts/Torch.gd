extends Area2D

signal torch_picked

func _process(delta):
	if $AnimatedSprite.frame == 0:
		$Light2D.visible = true
	else:
		$Light2D.visible = false

func _on_Torch_body_entered(_body: PhysicsBody2D)->void:
	emit_signal("torch_picked")
	queue_free()
