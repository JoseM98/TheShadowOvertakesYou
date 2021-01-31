extends Node2D

export (PackedScene) var game
export (PackedScene) var part1
export (PackedScene) var part2
export (PackedScene) var part3
export (PackedScene) var part4
export (PackedScene) var exit_door

export var startPoint = Vector2(0.0,0.0)
export var numCols = 4
export var numRows = 4
export var torchProbability = 50
export var fuelProbability = 50

var y_limit = Vector2(-130,900)
var x_limit = Vector2(-130,900)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var game_instance = game.instance()
	game_instance.position = Vector2(100.0,100.0)
	add_child(game_instance)
	_createMap()
	
	pass # Replace with function body.


func _createMap() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var arrayMaps = [part1, part2, part3, part4]
	var arrayRotations = [0, 90, 180, 270]
	#var stage2 = part2.instance()
	
	var pixelEachTile = 16
	var tilesEachPart = 16
	var incrPos = pixelEachTile*tilesEachPart
	var pos = startPoint
	var posArray
	var posRotArray
	var stage: Node2D
	var doorTileRow = rng.randi_range(0,numCols-1)
	var doorTileCol = rng.randi_range(0,numRows-1)
	var doorPosition = Vector2(doorTileRow, doorTileCol)
	
	for _i in range(numRows):
		pos.x = startPoint.x
		for _n in range(numCols):
			posArray = rng.randi_range(0,arrayMaps.size()-1)
			posRotArray = rng.randi_range(0,arrayRotations.size()-1)
			stage = arrayMaps[posArray].instance()
			add_child(stage)
			stage.position = pos
			stage.rotation_degrees = arrayRotations[posRotArray]
			
			var fuel = stage.get_child(1)
			var torch = stage.get_child(2)
			if _i!=doorTileRow || _n!= doorTileCol:
				stage.get_child(4).queue_free()
			
			# fuel
			if rng.randi_range(0,100) > fuelProbability:
				fuel.queue_free()
			else:
				fuel.rotation_degrees -= arrayRotations[posRotArray]
			
			# torch
			if rng.randi_range(0,100) > torchProbability:
				torch.queue_free()
			else:
				torch.rotation_degrees -= arrayRotations[posRotArray]
			
			
			fuel.connect("fuel_picked", $Main.get_node("Character"), "_on_Fuel_fuel_picked")
			fuel.connect("fuel_picked", $Main.get_node("HUD"), "_on_Fuel_fuel_picked")
			torch.connect("torch_picked", $Main.get_node("Character"), "_on_Torch_torch_picked")
			
			pos.x += incrPos
		pos.y += incrPos
	
	# character position
	var col_i = rng.randi_range(1,numCols-1)
	var row_i = rng.randi_range(1,numRows-1)
	var valueError = 0;
	
	while doorPosition.distance_to(Vector2(row_i, col_i)) <= 1.6 && valueError<30:
		col_i = rng.randi_range(1,numCols-1)
		row_i = rng.randi_range(1,numRows-1)
		valueError+=1;
		print(valueError)
	$Main.get_node("Character").position = Vector2((256*row_i) ,(256*col_i+8))
	
	
	#var door = exit_door.instance()
	#door.position = Vector2(rng.randf_range(x_limit.x,x_limit.y),rng.randf_range(y_limit.x,y_limit.y))
	#var character_pos = $Main.get_node("Character").position
	#while door.position.distance_to(character_pos) <= 500:
	#	door.position = Vector2(rng.randf_range(x_limit.x,x_limit.y),rng.randf_range(y_limit.x,y_limit.y))
		
	#add_child(door)
	
	
