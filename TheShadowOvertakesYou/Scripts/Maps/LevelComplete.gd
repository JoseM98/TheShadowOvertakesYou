extends Node2D

export (PackedScene) var character
export (PackedScene) var part1
export (PackedScene) var part2
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var startPoint = Vector2(0.0,0.0)
var numCols = 2;
var numFiles = 2;



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
	#var stage2 = part2.instance()
	
	var pixelEachTile = 16
	var tilesEachPart = 16
	var incrPos = pixelEachTile*tilesEachPart
	var pos = startPoint
	var posArray
	var stage
	
	for i in range(numFiles):
		pos.x = startPoint.x
		for n in range(numCols):
			posArray = rng.randi_range(0,arrayMaps.size()-1)
			stage = arrayMaps[posArray].instance()
			add_child(stage)
			stage.position = pos
			pos.x += incrPos
		pos.y += incrPos
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
