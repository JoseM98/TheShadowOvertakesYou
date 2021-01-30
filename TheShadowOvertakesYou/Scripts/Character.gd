extends KinematicBody2D

signal mark_used(marks_left)
signal fuel_used(fuel_left)

export (PackedScene) var Mark

export var speed = 10 # Character speed
export var light_decrement = float(0.025)
export var light_max_scale = 0.4
export var fuel_decrement = 10

var light_fuel_exchange = 0.01
var actual_light = 1 # Character light
var marks_left = 3
var actual_fuel = 0
var marks_position = []

func _ready():
	$Light2D.texture_scale = light_max_scale

func _process(delta):
	process_light(delta)

func _physics_process(delta: float) -> void:
	process_inputs(delta)
	

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
		
	move_and_slide(velocity * delta)
	#position += velocity/50*delta
	
	# Abilities
	if Input.is_action_just_pressed("ui_mark") && marks_left > 0:
		var mark = Mark.instance()
		mark.position = Vector2(position.x, position.y + 10)
		#get_tree().get_root().add_child(mark)
		get_parent().add_child(mark)
		marks_position.append(mark)
		marks_left -= 1
		emit_signal("mark_used",marks_left)
	
	# Fuel usage
	if Input.is_action_pressed("ui_fuel") && actual_fuel > 0 && actual_light < 1:
		actual_fuel -= fuel_decrement * delta
		actual_light += light_fuel_exchange
		emit_signal("fuel_used",actual_fuel)

func process_light(delta)->void:
	actual_light -= light_decrement * delta
	$Light2D.texture_scale = lerp(0,light_max_scale,actual_light)
	if actual_light <= 0:
		if actual_fuel > 0:
			actual_light = 1
			actual_fuel = 0
			emit_signal("fuel_used",actual_fuel)
		else:
			get_tree().change_scene("res://Scenes/Menus/LoseGame.tscn")


func _on_Torch_torch_picked()->void:
	actual_light = 1


func _on_Fuel_fuel_picked(fuel_amount = 20)->void:
	actual_fuel += fuel_amount
	print(actual_fuel)
