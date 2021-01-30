extends KinematicBody2D

signal dead

export var speed = 10 # Character speed
export var light_decrement = float(0.025)
export var light_max_scale = 0.4
var actual_light = 1 # Character light

func _ready():
	print("Character created")
	$Light2D.texture_scale = light_max_scale

func _process(delta):
	process_movement(delta)
	process_light(delta)

func process_movement(delta)->void:
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
		$AnimatedSprite.animation = "walk_down"
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1
		$AnimatedSprite.animation = "walk_left"
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
		$AnimatedSprite.animation = "walk_right"
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -1
		$AnimatedSprite.animation = "walk_up"
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
		
	position += velocity * delta

func process_light(delta)->void:
	actual_light -= light_decrement * delta
	$Light2D.texture_scale = lerp(0,light_max_scale,actual_light)
	if actual_light <= 0:
		emit_signal("dead")

func _on_Torch_torch_picked()->void:
	actual_light = 1
