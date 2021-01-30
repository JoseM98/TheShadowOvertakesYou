extends Node2D

export (PackedScene) var character
export (PackedScene) var part1
export (PackedScene) var part2
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var startPoint = Vector2(0.0,0.0)
export var numCols = 4
export var numFiles = 4
export var torchProbability = 50
export var fuelProbability = 50



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = character.instance()
	player.position = Vector2(100.0,100.0)
	add_child(player)
	_createMap()
	
	pass # Replace with function body.


func _createMap() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var arrayMaps = [part1, part2]
	var arrayRotations = [0, 90, 180, 270]
	#var stage2 = part2.instance()
	
	var pixelEachTile = 16
	var tilesEachPart = 16
	var incrPos = pixelEachTile*tilesEachPart
	var pos = startPoint
	var posArray
	var posRotArray
	var stage: Node2D
	
	for _i in range(numFiles):
		pos.x = startPoint.x
		for _n in range(numCols):
			posArray = rng.randi_range(0,arrayMaps.size()-1)
			posRotArray = rng.randi_range(0,arrayRotations.size()-1)
			stage = arrayMaps[posArray].instance()
			add_child(stage)
			stage.position = pos
			stage.rotation_degrees = arrayRotations[posRotArray]
			
			# fuel
			if rng.randi_range(0,100) > fuelProbability:
				stage.get_child(1).queue_free()
			else:
				stage.get_child(1).rotation_degrees -= arrayRotations[posRotArray]
			
			# torch
			if rng.randi_range(0,100) > torchProbability:
				stage.get_child(2).queue_free()
			else:
				stage.get_child(2).rotation_degrees -= arrayRotations[posRotArray]
			
			pos.x += incrPos
		pos.y += incrPos
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
