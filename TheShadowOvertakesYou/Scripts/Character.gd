extends KinematicBody2D

signal dead

export (PackedScene) var Mark

export var speed = 10 # Character speed
export var light_decrement = float(0.025)
export var light_max_scale = 0.4
var actual_light = 1 # Character light
var marks_left = 3

func _ready():
	print("Character created")
	$Light2D.texture_scale = light_max_scale

func _process(delta):
	process_inputs(delta)
	process_light(delta)

func process_inputs(delta)->void:
	# Movement
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
	
	# Abilities
	if Input.is_action_just_pressed("ui_mark") && marks_left > 0:
		var mark = Mark.instance()
		mark.position = Vector2(position.x, position.y + 10)
		get_tree().get_root().add_child(mark)
		marks_left -= 1

func process_light(delta)->void:
	actual_light -= light_decrement * delta
	$Light2D.texture_scale = lerp(0,light_max_scale,actual_light)
	if actual_light <= 0:
		emit_signal("dead")

func _on_Torch_torch_picked()->void:
	actual_light = 1
