extends KinematicBody2D

export var speed = 10 # Character speed

func _ready():
	print("Character created")

func _process(delta):
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
	
