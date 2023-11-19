class_name RobberLocationScene
extends Node3D

signal assigned

var assigned_tile: HexagonTile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func assign_tile(tile: HexagonTile) -> void:
	assigned_tile = tile
	position = tile.position + Vector3(0, 1, 0)
	assigned.emit()
